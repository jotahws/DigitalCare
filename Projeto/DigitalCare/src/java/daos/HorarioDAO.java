/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Cidade;
import beans.Clinica;
import beans.ClinicaEndereco;
import beans.Consulta;
import beans.Endereco;
import beans.Estado;
import beans.MedicoHorario;
import beans.Login;
import beans.Medico;
import beans.MedicoFalta;
import beans.Paciente;
import beans.PacienteUsuario;
import conexao.ConnectionFactory;
import facade.Facade;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author JotaWind
 */
public class HorarioDAO {

    private final String inserirHorario = "INSERT INTO medico_horarios (id_medico_clinica, dia_semana, horario_inicio, horario_fim) \n"
            + "VALUES ((select id from medico_clinica mc where mc.id_medico = ? AND mc.id_clinica_endereco = ?),\n"
            + " ?, ?, ?);";

    private final String apagarHorario = "DELETE FROM medico_horarios WHERE id=?;";

    private final String buscaConsultasMedico = "SELECT * FROM consulta c \n "
            + "INNER JOIN medico m ON c.id_medico = m.id \n "
            + "INNER JOIN paciente p ON c.id_paciente = p.id \n "
            + "INNER JOIN clinica_endereco ce ON c.id_clinica_endereco = ce.id \n "
            + "WHERE m.id = ?;";
    
    private final String buscaConsultaPorId = "SELECT * FROM consulta c \n "
            + "INNER JOIN medico m ON c.id_medico = m.id \n "
            + "INNER JOIN paciente p ON c.id_paciente = p.id \n "
            + "INNER JOIN clinica_endereco ce ON c.id_clinica_endereco = ce.id \n "
            + "WHERE c.id = ?;";
    
    private final String buscaConsultaAtualPorMedico = "SELECT * FROM consulta c \n "
            + "INNER JOIN medico m ON c.id_medico = m.id \n "
            + "INNER JOIN paciente p ON c.id_paciente = p.id \n "
            + "INNER JOIN clinica_endereco ce ON c.id_clinica_endereco = ce.id \n "
            + "WHERE m.id=? AND c.status = 'Em andamento';";
    
    private final String buscaConsultasPaciente = "SELECT * FROM consulta c \n "
            + "INNER JOIN medico m ON c.id_medico = m.id \n "
            + "INNER JOIN paciente p ON c.id_paciente = p.id \n "
            + "INNER JOIN clinica_endereco ce ON c.id_clinica_endereco = ce.id \n "
            + "WHERE p.id = ? AND status != 'Cancelado';";

    private final String listaHorariosPorMedico = "select * from medico_horarios mh \n"
            + "INNER JOIN medico_clinica mc ON mc.id = mh.id_medico_clinica \n"
            + "INNER JOIN medico m ON m.id = mc.id_medico \n"
            + "INNER JOIN clinica_endereco ce ON ce.id = mc.id_clinica_endereco \n"
            + "WHERE m.id = ? ORDER BY mh.horario_inicio;";

    private String buscaHorariosConsulta = "SELECT * FROM medico_horarios mh \n "
            + "INNER JOIN medico_clinica mc ON mh.id_medico_clinica = mc.id \n "
            + "INNER JOIN clinica_endereco ce ON mc.id_clinica_endereco = ce.id \n "
            + "INNER JOIN endereco en ON ce.id_endereco = en.id \n "
            + "INNER JOIN cidade ci ON en.id_cidade = ci.id \n "
            + "INNER JOIN estado st ON ci.id_estado = st.id \n "
            + "INNER JOIN clinica cl ON ce.id_clinica = cl.id \n "
            + "INNER JOIN login l ON cl.id_login = l.id \n "
            + "INNER JOIN medico m ON mc.id_medico = m.id \n "
            + "INNER JOIN medico_especialidade me ON me.id_medico = m.id \n "
            + "INNER JOIN especialidade es ON me.id_especialidade = es.id \n "
            + "WHERE es.id = ? ";

    private final String buscaFaltasSemanaMedico = "SELECT * FROM medico_falta\n"
            + "WHERE data_inicio >= ? AND "
            + "(data_fim <= ? OR data_fim IS NULL) AND "
            + "id_medico = ?\n";

    private final String buscaConsultasSemanaMedico = "SELECT * FROM consulta \n"
            + "WHERE datahora BETWEEN ? AND ? AND id_medico = ?";

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    public List<Consulta> buscarConsultasSemana(Date dataInicio, Date dataFim, Integer idMedicos) throws ClassNotFoundException, SQLException {
        List<Consulta> lista = new ArrayList();
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaConsultasSemanaMedico);
            java.sql.Timestamp dataISql = new java.sql.Timestamp(dataInicio.getTime());
            java.sql.Timestamp dataFSql = new java.sql.Timestamp(dataFim.getTime());
            stmt.setTimestamp(1, dataISql);
            stmt.setTimestamp(2, dataFSql);
            stmt.setInt(3, idMedicos);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Consulta consulta = new Consulta();
                Timestamp datahora = rs.getTimestamp("datahora");
                consulta.setIdMedico(rs.getInt("id_medico"));
                consulta.setDataHora(datahora);
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

    public List<MedicoFalta> buscarFaltasSemana(Date dataInicio, Date dataFim, Integer idMedicos) throws ClassNotFoundException, SQLException {
        List<MedicoFalta> lista = new ArrayList();
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaFaltasSemanaMedico);
            java.sql.Date dataISql = new java.sql.Date(dataInicio.getTime());
            java.sql.Date dataFSql = new java.sql.Date(dataFim.getTime());
            stmt.setDate(1, dataISql);
            stmt.setDate(2, dataFSql);
            stmt.setInt(3, idMedicos);
            rs = stmt.executeQuery();
            while (rs.next()) {
                MedicoFalta medFalta = new MedicoFalta();
                medFalta.setIdMedico(rs.getInt("id_medico"));
                medFalta.setDataInicio(rs.getDate("data_inicio"));
                medFalta.setDataFim(rs.getDate("data_fim"));
                medFalta.setHoraInicio(rs.getTime("horario_inicio"));
                medFalta.setHoraFim(rs.getTime("horario_fim"));
                lista.add(medFalta);
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

    public List<MedicoHorario> buscarHorariosConsulta(String especialidade, String cidade, String clinica, Medico medico1) throws ClassNotFoundException, SQLException {
        if (!("".equals(cidade))) {
            buscaHorariosConsulta += " AND ci.id = " + cidade;
        }
        if (!("".equals(clinica))) {
            buscaHorariosConsulta += " AND cl.id = " + clinica + " ";
        }
        buscaHorariosConsulta += "\n  AND m.id="+ medico1.getId() +"\n ORDER BY m.id ";
        try {
            List<MedicoHorario> lista = new ArrayList();
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaHorariosConsulta);
            stmt.setString(1, especialidade);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Login login = new Login();
                login.setEmail(rs.getString("l.email"));
                Clinica cli = new Clinica();
                cli.setAvaliacao(rs.getDouble("cl.avaliacao"));
                cli.setCnpj(rs.getString("cl.cnpj"));
                cli.setId(rs.getInt("cl.id"));
                cli.setNomeFantasia(rs.getString("cl.nome_fantasia"));
                cli.setRazaoSocial(rs.getString("cl.razao_social"));
                cli.setLogin(login);
                cli.setSite(rs.getString("cl.site"));
                Estado estado = new Estado();
                estado.setNome(rs.getString("st.nome"));
                estado.setUf(rs.getString("st.uf"));
                Cidade cdd = new Cidade();
                cdd.setEstado(estado);
                cdd.setNome(rs.getString("ci.nome"));
                Endereco end = new Endereco();
                end.setCidade(cdd);
                end.setBairro(rs.getString("en.bairro"));
                end.setCep(rs.getString("en.cep"));
                end.setComplemento(rs.getString("en.complemento"));
                end.setNumero(rs.getString("en.numero"));
                end.setRua(rs.getString("en.rua"));
                ClinicaEndereco cliEnd = new ClinicaEndereco();
                cliEnd.setClinica(cli);
                cliEnd.setEndereco(end);
                cliEnd.setId(rs.getInt("ce.id"));
                cliEnd.setNome(rs.getString("ce.nome"));
                cliEnd.setTelefone1(rs.getString("ce.telefone1"));
                cliEnd.setTelefone2(rs.getString("ce.telefone2"));
                Medico medico = new Medico();
                medico.setId(rs.getInt("m.id"));
                medico.setAvaliacao(rs.getDouble("m.avaliacao"));
                medico.setNome(rs.getString("m.nome"));
                medico.setSobrenome(rs.getString("m.sobrenome"));
                medico.setPrecoConsulta(rs.getDouble("m.preco_consulta"));
                MedicoHorario horario = new MedicoHorario();
                horario.setClinicaEndereco(cliEnd);
                horario.setDiaSemana(rs.getInt("mh.dia_semana"));
                horario.setHoraFim(rs.getTime("mh.horario_fim"));
                horario.setHoraInicio(rs.getTime("mh.horario_inicio"));
                horario.setMedico(medico);
                lista.add(horario);
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

    public final MedicoHorario inserirHorario(MedicoHorario horario) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(inserirHorario, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, horario.getMedico().getId());
            stmt.setInt(2, horario.getClinicaEndereco().getId());
            stmt.setInt(3, horario.getDiaSemana());
            java.sql.Time horaInicioSql = new java.sql.Time(horario.getHoraInicio().getTime());
            java.sql.Time horaFimSql = new java.sql.Time(horario.getHoraFim().getTime());
            stmt.setTime(4, horaInicioSql);
            stmt.setTime(5, horaFimSql);
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                horario.setId(rs.getInt(1));
                return horario;
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

    public void apagarHorario(MedicoHorario horario) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(apagarHorario);
            stmt.setInt(1, horario.getId());
            stmt.executeUpdate();
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

    public List<MedicoHorario> listaHorariosPorMedico(Medico medico) throws ClassNotFoundException, SQLException {
        try {
            List<MedicoHorario> lista = new ArrayList();
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(listaHorariosPorMedico);
            stmt.setInt(1, medico.getId());
            rs = stmt.executeQuery();
            while (rs.next()) {
                ClinicaEndereco clinicaEndereco = Facade.getClinicaEnderecoPorId(rs.getInt("ce.id"));
                MedicoHorario horario = new MedicoHorario();
                horario.setId(rs.getInt("mh.id"));
                horario.setDiaSemana(rs.getInt("mh.dia_semana"));
                horario.setHoraFim(rs.getTime("mh.horario_fim"));
                horario.setHoraInicio(rs.getTime("mh.horario_inicio"));
                horario.setMedico(medico);
                horario.setClinicaEndereco(clinicaEndereco);
                lista.add(horario);
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

    public List<Consulta> buscarConsultasMedico(Medico medico) throws ClassNotFoundException, SQLException {
        List<Consulta> lista = new ArrayList();
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaConsultasMedico);
            stmt.setInt(1, medico.getId());
            rs = stmt.executeQuery();
            while (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("c.datahora");
                Date datahora = timestamp;
                Paciente paciente = new Paciente(rs.getInt("p.id"), rs.getString("p.cpf"), rs.getString("p.nome"), rs.getString("p.sobrenome"), rs.getDate("p.data_nascimento"), rs.getString("p.sexo"));
                ClinicaEndereco clinicaEndereco = Facade.getClinicaEnderecoPorId(rs.getInt("c.id_clinica_endereco"));
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

    public List<Consulta> buscarConsultasPaciente(PacienteUsuario pacienteUsuario) throws ClassNotFoundException, SQLException {
        List<Consulta> lista = new ArrayList();
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaConsultasPaciente);
            stmt.setInt(1, pacienteUsuario.getPaciente().getId());
            rs = stmt.executeQuery();
            while (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("c.datahora");
                Date datahora = timestamp;
                Paciente paciente = new Paciente(rs.getInt("p.id"), rs.getString("p.cpf"), rs.getString("p.nome"), rs.getString("p.sobrenome"), rs.getDate("p.data_nascimento"), rs.getString("p.sexo"));
                Medico medico = Facade.buscarMedicoPorId(rs.getInt("m.id_login"));
                ClinicaEndereco clinicaEndereco = Facade.getClinicaEnderecoPorId(rs.getInt("c.id_clinica_endereco"));
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
    
    public Consulta buscarConsultaPorId(Consulta consulta) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaConsultaPorId);
            stmt.setInt(1, consulta.getId());
            rs = stmt.executeQuery();
            if (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("c.datahora");
                Date datahora = timestamp;
                PacienteUsuario pacienteUsuario = Facade.getPacienteUsuarioPorIdPaciente(rs.getInt("p.id"));
                pacienteUsuario.getPaciente().setListaConvenios(Facade.getListaConveniosPaciente(pacienteUsuario.getPaciente().getId()));
                Medico medico = Facade.buscarMedicoPorId(rs.getInt("m.id_login"));
                ClinicaEndereco clinicaEndereco = Facade.getClinicaEnderecoPorId(rs.getInt("c.id_clinica_endereco"));
                consulta = new Consulta(rs.getInt("c.id"), datahora, rs.getString("c.status"), medico, new Paciente(), clinicaEndereco);
                consulta.setPacienteUsuario(pacienteUsuario);
                return consulta;
            }
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
        return null;
    }
    
    public Consulta buscarConsultaAtualPorMedico(Medico medico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaConsultaAtualPorMedico);
            stmt.setInt(1, medico.getId());
            rs = stmt.executeQuery();
            if (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("c.datahora");
                Date datahora = timestamp;
                PacienteUsuario pacienteUsuario = Facade.getPacienteUsuarioPorIdPaciente(rs.getInt("p.id"));
                pacienteUsuario.getPaciente().setListaConvenios(Facade.getListaConveniosPaciente(pacienteUsuario.getPaciente().getId()));
                Medico medico2 = Facade.buscarMedicoPorId(rs.getInt("m.id_login"));
                ClinicaEndereco clinicaEndereco = Facade.getClinicaEnderecoPorId(rs.getInt("c.id_clinica_endereco"));
                Consulta consulta = new Consulta(rs.getInt("c.id"), datahora, rs.getString("c.status"), medico2, new Paciente(), clinicaEndereco);
                pacienteUsuario.setProntuarios(Facade.getListaProntuarioPacienteMedico(pacienteUsuario, medico));
                consulta.setPacienteUsuario(pacienteUsuario);
                return consulta;
            }
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
        return null;
    }
}
