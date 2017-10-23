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
import conexao.ConnectionFactory;
import facade.Facade;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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

    private final String listaHorariosPorMedico = "select * from medico_horarios mh \n"
            + "INNER JOIN medico_clinica mc ON mc.id = mh.id_medico_clinica \n"
            + "INNER JOIN medico m ON m.id = mc.id_medico \n"
            + "INNER JOIN clinica_endereco ce ON ce.id = mc.id_clinica_endereco \n"
            + "WHERE m.id = ? ORDER BY mh.horario_inicio;";
    
    private String buscaHorariosConsulta = "SELECT * FROM medico_horarios mh\n" +
                                            "INNER JOIN medico_clinica mc ON mh.id_medico_clinica = mh.id\n" +
                                            "INNER JOIN clinica_endereco ce ON mc.id_clinica_endereco = ce.id\n" +
                                            "INNER JOIN endereco en ON ce.id_endereco = en.id\n" +
                                            "INNER JOIN cidade ci ON en.id_cidade = ci.id\n" +
                                            "INNER JOIN estado st ON ci.id_estado = st.id/n" +
                                            "INNER JOIN clinica cl ON ce.id_clinica = cl.id\n" +
                                            "INNER JOIN login l ON cl.id_login = l.id\n" +
                                            "INNER JOIN medico m ON mc.id_medico = m.id\n" +
                                            "INNER JOIN medico_especialidade me ON me.id_medico = m.id\n" +
                                            "INNER JOIN especialidade es ON me.id_especialidade = es.id\n" +
                                            "WHERE es.nome = ? ";
    
    private final String buscaFaltasSemana = "SELECT * FROM medico_falta\n" +
                                            "WHERE data_inicio >= ? AND " +
                                            "(data_fim <= ? OR data_fim IS NULL) AND "+
                                            "id_medico IN (?)\n" +
                                            "ORDER BY id_medico";
    
    private final String buscaConsultasSemana = "SELECT * FROM consulta \n" +
                                                "WHERE datahora BETWEEN ? AND ? AND id_medico IN (?)";

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    public List<Consulta> buscarConsultasSemana(Date dataInicio, Date dataFim, String idMedicos) throws ClassNotFoundException, SQLException {
        List<Consulta> lista = new ArrayList();
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaConsultasSemana);
            java.sql.Date dataISql = new java.sql.Date(dataInicio.getTime());
            java.sql.Date dataFSql = new java.sql.Date(dataFim.getTime());
            stmt.setDate(1, dataISql);
            stmt.setDate(2, dataFSql);
            stmt.setString(3, idMedicos);
            rs = stmt.executeQuery();
            SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy"); // formato da data 
            while (rs.next()) {
                Consulta consulta = new Consulta();
                String datahora = fmt.format(rs.getDate("datahora")); // aqui você passa o Date para converter
                consulta.setIdMedico(rs.getInt("id_medico"));
                consulta.setDataHora(datahora);
                lista.add(consulta);
            }
            return lista;
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }
    
    public List<MedicoFalta> buscarFaltasSemana(Date dataInicio, Date dataFim, String idMedicos) throws ClassNotFoundException, SQLException {
        List<MedicoFalta> lista = new ArrayList();
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaFaltasSemana);
            java.sql.Date dataISql = new java.sql.Date(dataInicio.getTime());
            java.sql.Date dataFSql = new java.sql.Date(dataFim.getTime());
            stmt.setDate(1, dataISql);
            stmt.setDate(2, dataFSql);
            stmt.setString(3, idMedicos);
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
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }
    
    public List<MedicoHorario> buscarHorariosConsulta(String especialidade, String cidade, String clinica) throws ClassNotFoundException, SQLException {
        if (!("".equals(cidade)))
            buscaHorariosConsulta += " AND ci.nome = " + cidade;
        if (!("".equals(clinica)))
            buscaHorariosConsulta += " AND cl.nome_fantasia = " + clinica;
        buscaHorariosConsulta += " ORDER BY m.id ";
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
                cliEnd.setNome(rs.getString("ce.nome"));
                cliEnd.setTelefone1(rs.getString("ce.telefone1"));
                cliEnd.setTelefone2(rs.getString("ce.telefone2"));
                Medico medico = new Medico();
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
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
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
            stmt.setTime(4, horario.getHoraInicio());
            stmt.setTime(5, horario.getHoraFim());
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                horario.setId(rs.getInt(1));
                return horario;
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

    public void apagarHorario(MedicoHorario horario) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(apagarHorario);
            stmt.setInt(1, horario.getId());
            stmt.executeUpdate();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
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
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }
}
