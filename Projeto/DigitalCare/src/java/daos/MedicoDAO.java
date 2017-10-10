/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Cidade;
import beans.Consulta;
import beans.Endereco;
import beans.Estado;
import beans.Login;
import beans.Medico;
import com.mysql.jdbc.Statement;
import conexao.ConnectionFactory;
import facade.Facade;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Gabriel
 */
public class MedicoDAO {

    private final String insereMedico = "INSERT INTO medico (id_login, id_estado_crm, num_crm, nome, sobrenome, cpf, data_nascimento) "
            + "VALUES (?,?,?,?,?,?,?)";
    private final String buscaIdMedicoPorLogin = "SELECT id FROM medico WHERE id_login=?";
    private final String buscaMedicoPorLogin = "SELECT * FROM medico m "
            + "INNER JOIN estado e ON m.id_estado_crm = e.id "
            + "WHERE id_login=?";
    private final String updateMedico = "UPDATE medico SET nome=?, sobrenome=?, preco_consulta=?, data_nascimento=?, "
            + "telefone=?, telefone2=? WHERE id=?";
    private final String deleteMedicoEspecialidade = "DELETE FROM medico_especialidade WHERE id_medico =? "
            + "AND id_especialidade =?";
    private final String insereMedicoEspecialidade = "INSERT INTO medico_especialidade (id_medico, id_especialidade) "
            + "VALUES (?,?)";
    private final String buscarMedicoEspecialidade = "SELECT * FROM medico_especialidade WHERE id_medico =?";
    private final String listMedicos = "SELECT m.nome, m.data_nascimento, l.email, l.id, m.cpf, e.uf, m.sobrenome, " +
        " m.num_crm, m.preco_consulta, m.telefone, m.telefone2, m.avaliacao, m.id, m.id_login, m.id_estado_crm "  +
        " FROM medico m, login l, clinica cli, medico_clinica mc, clinica_endereco ce, estado e " +
        " WHERE m.id   = mc.id_medico  AND cli.id = ce.id_clinica AND mc.id_clinica_endereco  = ce.id " +
        "  AND cli.id = ce.id_clinica AND l.id   = m.id_login    AND e.id   = m.id_estado_crm    AND cli.id =?";
    
    private final String desvinculaMedicoClinica = "DELETE FROM medico_clinica where id_medico=? AND id_clinica_endereco =?";

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

//    public List<MedicoEspecialidade> buscarMedicoEspecialidade(int idMedico) throws ClassNotFoundException, SQLException{
//        try {
//            List<MedicoEspecialidade> lista = new ArrayList();
//            con = new ConnectionFactory().getConnection();
//            stmt = con.prepareStatement(buscarMedicoEspecialidade);
//            stmt.setInt(1, idMedico);
//            rs = stmt.executeQuery();
//            while (rs.next()) {
//                int id = rs.getInt("id");
//                int idEspecialidade = rs.getInt("id_especialidade");
//                MedicoEspecialidade medicoEspecialidade = new MedicoEspecialidade(id, idMedico, idEspecialidade);
//                lista.add(medicoEspecialidade);
//            }
//            return lista;
//        } finally {
//            try {
//                con.close();
//                stmt.close();
//                rs.close();
//            } catch (SQLException ex) {
//                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
//            }
//        }
//    }
    public void inserirMedicoEspecialidade(int idEspecialidade, int idMedico) throws SQLException, ClassNotFoundException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereMedicoEspecialidade);
            stmt.setInt(1, idMedico);
            stmt.setInt(2, idEspecialidade);
            stmt.executeUpdate();
        } finally {
            try {
                stmt.close();
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public void deletarMedicoEspecialidade(int idEspecialidade, int idMedico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(deleteMedicoEspecialidade);
            stmt.setInt(1, idMedico);
            stmt.setInt(2, idEspecialidade);
            stmt.executeUpdate();
        } finally {
            try {
                stmt.close();
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public void atualizarMedico(Medico medico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(updateMedico);
            stmt.setString(1, medico.getNome());
            stmt.setString(2, medico.getSobrenome());
            stmt.setDouble(3, medico.getPrecoConsulta());
            java.sql.Date dataSql = new java.sql.Date(medico.getDataNascimento().getTime());
            stmt.setDate(4, dataSql);
            stmt.setString(5, medico.getTelefone1());
            stmt.setString(6, medico.getTelefone2());
            stmt.setInt(7, medico.getId());
            stmt.executeUpdate();
        } finally {
            try {
                stmt.close();
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public int buscarIdMedicoPorLogin(int idLogin) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaIdMedicoPorLogin);
            stmt.setInt(1, idLogin);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } finally {
            try {
                stmt.close();
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
        return 0;
    }

    public int inserirMedico(Medico medico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereMedico, Statement.RETURN_GENERATED_KEYS);
            int idLogin = Facade.inserirLogin(medico.getLogin());
            stmt.setInt(1, idLogin);
            stmt.setInt(2, medico.getEstadoCrm().getId());
            stmt.setString(3, medico.getNumeroCrm());
            stmt.setString(4, medico.getNome());
            stmt.setString(5, medico.getSobrenome());
            stmt.setString(6, medico.getCpf());
            java.sql.Date dataSql = new java.sql.Date(medico.getDataNascimento().getTime());
            stmt.setDate(7, dataSql);

            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } finally {
            try {
                stmt.close();
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
        return 0;
    }

    public Medico getMedicoPorLogin(int idLogin) throws SQLException, ClassNotFoundException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaMedicoPorLogin);
            stmt.setInt(1, idLogin);
            rs = stmt.executeQuery();
            if (rs.next()) {
                Estado estado = new Estado();
                estado.setId(rs.getInt("e.id"));
                estado.setNome(rs.getString("e.nome"));
                estado.setUf(rs.getString("e.uf"));
                Medico medico = new Medico();
                medico.setEstadoCrm(estado);
                medico.setId(rs.getInt("m.id"));
                medico.setNome(rs.getString("m.nome"));
                medico.setSobrenome(rs.getString("m.sobrenome"));
                medico.setCpf(rs.getString("m.cpf"));
                medico.setPrecoConsulta(rs.getDouble("m.preco_consulta"));
                medico.setDataNascimento(rs.getDate("m.data_nascimento"));
                medico.setTelefone1(rs.getString("m.telefone"));
                medico.setTelefone2(rs.getString("m.telefone2"));
                medico.setNumeroCrm(rs.getString("m.num_crm"));
                medico.setPrecoConsulta(rs.getDouble("m.preco_consulta"));
                medico.setAvaliacao(rs.getDouble("m.avaliacao"));
                return medico;
            }
        } finally {
            try {
                stmt.close();
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
        return null;
    }

    public List<Medico> listaMedicosNaClinica(int idClinica) throws ClassNotFoundException, SQLException {
        try {
            List<Medico> lista = new ArrayList();
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(listMedicos);
            stmt.setInt(1, idClinica);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Medico medico = new Medico();
                Login login = new Login();
                Estado estado = new Estado();
                
                estado.setUf(rs.getString("e.uf"));
                login.setEmail(rs.getString("l.email"));
                login.setId(rs.getInt("l.id"));
                medico.setLogin(login);
                medico.setEstadoCrm(estado);
                medico.setId(rs.getInt("m.id"));
                medico.setNome(rs.getString("m.nome"));
                medico.setSobrenome(rs.getString("m.sobrenome"));
                medico.setCpf(rs.getString("m.cpf"));
                medico.setNumeroCrm(rs.getString("m.num_crm"));
                medico.setPrecoConsulta(rs.getDouble("m.preco_consulta"));
                medico.setAvaliacao(rs.getDouble("m.avaliacao"));
                medico.setTelefone1(rs.getString("m.telefone"));
                medico.setTelefone2(rs.getString("m.telefone2"));
                medico.setDataNascimento(rs.getDate("m.data_nascimento"));
                lista.add(medico);
            }
            return lista;
        } finally {
            try {
                con.close();
                stmt.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public void desvincularMedicoClinica(int idMedico, int idClinica) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(desvinculaMedicoClinica);
            stmt.setInt(1, idMedico);
            stmt.setInt(2, idClinica);
            stmt.executeUpdate();
        } finally {
            try {
                stmt.close();
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

}
