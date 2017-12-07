/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Clinica;
import beans.ClinicaEndereco;
import beans.Consulta;
import beans.Medico;
import beans.Paciente;
import conexao.ConnectionFactory;
import facade.Facade;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author JotaWind
 */
public class ConsultaDAO {

    private final String insereNovaConsulta = "INSERT INTO consulta (id_medico, id_paciente, id_clinica_endereco, datahora, status) "
            + "VALUES (?, ?, ?, ?, ?);";
    private final String cancelaConsulta = "UPDATE consulta SET status='Cancelado' WHERE id=?";

    private final String concluiConsulta = "UPDATE consulta SET status='Concluído' WHERE id=?";

    private final String iniciaConsulta = "UPDATE consulta SET status='Em andamento' WHERE id=?";

    private final String pacienteEmEspera = "UPDATE consulta SET status='Em espera' WHERE id=?";

    private final String countStatusPorMedicoNoDia = "SELECT c.status, COUNT(c.id) as qtdd FROM consulta c WHERE c.id_medico=? AND date(c.datahora) =  curdate() GROUP BY c.status;";

    private final String countStatusPorClinicaNoDia = "SELECT c.status, COUNT(c.id) as qtdd \n"
            + "FROM consulta c INNER JOIN clinica_endereco ce ON c.id_clinica_endereco = ce.id\n"
            + "INNER JOIN clinica cli ON cli.id = ce.id_clinica\n"
            + "WHERE cli.id=? AND date(c.datahora) = curdate() \n"
            + "GROUP BY c.status;";

    private final String consultasAtuaisPorClinica = "SELECT * FROM consulta c\n"
            + "INNER JOIN medico m ON c.id_medico = m.id\n"
            + "INNER JOIN paciente p ON c.id_paciente = p.id\n"
            + "INNER JOIN clinica_endereco ce ON c.id_clinica_endereco = ce.id\n"
            + "INNER JOIN clinica cli ON ce.id_clinica = cli.id\n"
            + "WHERE cli.id=? AND c.status = 'Em andamento';";

    private final String proximasConsultasPorClinica = "SELECT * FROM consulta c\n"
            + "INNER JOIN medico m ON c.id_medico = m.id\n"
            + "INNER JOIN paciente p ON c.id_paciente = p.id\n"
            + "INNER JOIN clinica_endereco ce ON c.id_clinica_endereco = ce.id\n"
            + "INNER JOIN clinica cli ON ce.id_clinica = cli.id\n"
            + "WHERE m.id=?\n"
            + "AND c.datahora > (SELECT c.datahora FROM consulta c \n"
            + "INNER JOIN medico m ON c.id_medico = m.id\n"
            + "WHERE m.id=? AND c.status IN  ( 'Em andamento', 'Concluído' ) \n"
            + "ORDER BY c.datahora DESC LIMIT 1)\n"
            + "AND date(c.datahora) = curdate()\n"
            + "AND c.status = 'Em andamento'\n"
            + "ORDER BY c.datahora \n"
            + "LIMIT 1;";

    private final String pacientesUltimaSemanaPorMedico = "SELECT p.sexo, count(DISTINCT p.id) as no_pacientes\n"
            + "FROM consulta c\n"
            + "INNER JOIN medico m ON c.id_medico = m.id\n"
            + "INNER JOIN paciente p ON c.id_paciente = p.id\n"
            + "WHERE m.id=? AND c.status = 'Concluído'\n"
            + "AND date(c.datahora) BETWEEN CURDATE() - INTERVAL 7 DAY AND CURDATE()\n"
            + "group by p.sexo \n"
            + "ORDER BY p.sexo;";

    private final String totalConcluidoPorMedico = "SELECT count(c.id) as no_consultas\n"
            + "FROM consulta c\n"
            + "INNER JOIN medico m ON c.id_medico = m.id\n"
            + "WHERE m.id=?\n"
            + "AND c.status = 'Concluído';";

    private final String diaComMaisConsultasPorMedico = "SELECT DAYOFWEEK(c.datahora) as dia_semana, count(DAYOFWEEK(c.datahora)) as consultas\n"
            + "FROM consulta c\n"
            + "INNER JOIN medico m ON c.id_medico = m.id\n"
            + "WHERE m.id=? AND c.status = 'Concluído'\n"
            + "GROUP BY DAYOFWEEK(c.datahora);";

    private final String TotalCanceladoPorMedico = "SELECT count(c.id) as no_consultas\n"
            + "FROM consulta c\n"
            + "INNER JOIN medico m ON c.id_medico = m.id\n"
            + "WHERE m.id=?\n"
            + "AND c.status = 'Cancelado';";

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    public Consulta insereConsulta(Consulta consulta) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereNovaConsulta, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, consulta.getMedico().getId());
            stmt.setInt(2, consulta.getPaciente().getId());
            stmt.setInt(3, consulta.getClinicaEndereco().getId());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String dataHoraString = sdf.format(consulta.getDataHora());
            stmt.setString(4, dataHoraString);
            stmt.setString(5, consulta.getStatus());
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                consulta.setId(rs.getInt(1));
                return consulta;
            }
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
        return null;
    }

    public void cancelaConsulta(Consulta consulta) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(cancelaConsulta);
            stmt.setInt(1, consulta.getId());
            stmt.executeUpdate();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public void concluiConsulta(Consulta consulta) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(concluiConsulta);
            stmt.setInt(1, consulta.getId());
            stmt.executeUpdate();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public void iniciaConsulta(Consulta consulta) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(iniciaConsulta);
            stmt.setInt(1, consulta.getId());
            stmt.executeUpdate();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public void pacienteEmEspera(Consulta consulta) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(pacienteEmEspera);
            stmt.setInt(1, consulta.getId());
            stmt.executeUpdate();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public List<String[]> buscarStatusPorMedicoNoDia(Medico medico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(countStatusPorMedicoNoDia);
            stmt.setInt(1, medico.getId());
            rs = stmt.executeQuery();
            List<String[]> status = new ArrayList();
            while (rs.next()) {
                String[] item = {rs.getString("status"), rs.getString("qtdd")};
                status.add(item);
            }
            return status;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public List<String[]> buscarStatusPorClinicaNoDia(Clinica clinica) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(countStatusPorClinicaNoDia);
            stmt.setInt(1, clinica.getId());
            rs = stmt.executeQuery();
            List<String[]> status = new ArrayList();
            while (rs.next()) {
                String[] item = {rs.getString("status"), rs.getString("qtdd")};
                status.add(item);
            }
            return status;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public List<Consulta> buscarConsultasEmAndamentoPorClinica(Clinica clinica) throws ClassNotFoundException, SQLException {
        List<Consulta> lista = new ArrayList();
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(consultasAtuaisPorClinica);
            stmt.setInt(1, clinica.getId());
            rs = stmt.executeQuery();
            while (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("c.datahora");
                java.util.Date datahora = timestamp;
                Paciente paciente = new Paciente(rs.getInt("p.id"), rs.getString("p.cpf"), rs.getString("p.nome"), rs.getString("p.sobrenome"), rs.getDate("p.data_nascimento"), rs.getString("p.sexo"));
                ClinicaEndereco clinicaEndereco = Facade.getClinicaEnderecoPorId(rs.getInt("c.id_clinica_endereco"));
                Medico medico = Facade.getMedicoPorCPF(rs.getString("m.cpf"));
                Consulta consulta = new Consulta(rs.getInt("c.id"), datahora, rs.getString("c.status"), medico, paciente, clinicaEndereco);
                lista.add(consulta);
            }
            return lista;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public Consulta buscarProximasConsultasPorClinica(Medico medico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(proximasConsultasPorClinica);
            stmt.setInt(1, medico.getId());
            stmt.setInt(2, medico.getId());
            rs = stmt.executeQuery();
            if (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("c.datahora");
                java.util.Date datahora = timestamp;
                Paciente paciente = new Paciente(rs.getInt("p.id"), rs.getString("p.cpf"), rs.getString("p.nome"), rs.getString("p.sobrenome"), rs.getDate("p.data_nascimento"), rs.getString("p.sexo"));
                ClinicaEndereco clinicaEndereco = Facade.getClinicaEnderecoPorId(rs.getInt("c.id_clinica_endereco"));
                Consulta consulta = new Consulta(rs.getInt("c.id"), datahora, rs.getString("c.status"), medico, paciente, clinicaEndereco);
                return consulta;
            }
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
        return null;
    }

    public List<String[]> getPacientesDaUltimaSemana(Medico medico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(pacientesUltimaSemanaPorMedico);
            stmt.setInt(1, medico.getId());
            rs = stmt.executeQuery();
            List<String[]> sexo = new ArrayList();
            int totalInt = 0;
            while (rs.next()) {
                String[] item = {rs.getString("sexo"), rs.getString("no_pacientes")};
                sexo.add(item);
                totalInt += Integer.parseInt(item[1]);
            }
            String[] totalStr = {"total", String.valueOf(totalInt)};
            sexo.add(totalStr);
            return sexo;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public List<String[]> getTotalConcluido(Medico medico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(totalConcluidoPorMedico);
            stmt.setInt(1, medico.getId());
            rs = stmt.executeQuery();
            List<String[]> total = new ArrayList();
            while (rs.next()) {
                String[] item = {rs.getString("no_consultas")};
                total.add(item);
            }
            return total;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public List<String[]> getTotalCancelado(Medico medico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(TotalCanceladoPorMedico);
            stmt.setInt(1, medico.getId());
            rs = stmt.executeQuery();
            List<String[]> total = new ArrayList();
            while (rs.next()) {
                String[] item = {rs.getString("no_consultas")};
                total.add(item);
            }
            return total;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public List<String[]> getDiaSemanaMaisConsultas(Medico medico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(diaComMaisConsultasPorMedico);
            stmt.setInt(1, medico.getId());
            rs = stmt.executeQuery();
            List<String[]> diaSemana = new ArrayList();
            String[] aux = {"0"};
            while (rs.next()) {
                String[] item = {rs.getString("dia_semana"), rs.getString("consultas")};
                if (Integer.parseInt(item[1]) > Integer.parseInt(aux[0])) {
                    aux = item;
                }
            }
            diaSemana.add(aux);
            return diaSemana;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }
}
