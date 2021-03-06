/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Cidade;
import beans.Endereco;
import beans.Estado;
import beans.Login;
import beans.Paciente;
import beans.PacienteUsuario;
import conexao.ConnectionFactory;
import facade.Facade;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Gabriel
 */
public class PacienteUsuarioDAO {

    private final String inserePacienteUsuario = "INSERT INTO paciente_usuario (id_paciente, id_login, "
            + "id_endereco, telefone, telefone2) VALUES (?,?,?,?,?)";
    private final String deletePacienteUsuario = "DELETE FROM paciente_usuario where paciente_usuario.id =?";
    private final String deletePaciente = "DELETE FROM paciente where paciente.id =?";
    private final String deleteEndereco = "DELETE FROM endereco where endereco.id =?";
    private final String deleteLogin = "DELETE FROM login where login.id =?";
    private final String updatePacienteUsuario = "UPDATE paciente_usuario, paciente, endereco, login "
            + "SET paciente_usuario.telefone=?, paciente_usuario.telefone2=?, paciente.cpf=?, "
            + "    paciente.sexo=?,             paciente.nome=?,              paciente.data_nascimento=?,"
            + "    paciente.sobrenome=?,        endereco.bairro=?,            endereco.cep=?,"
            + "    endereco.complemento=?,      endereco.id_cidade=?,         endereco.numero=?,"
            + "    endereco.rua=?,              login.email=?"
            + "    WHERE paciente_usuario.id_endereco = endereco.id"
            + "      AND paciente_usuario.id_paciente = paciente.id"
            + "      AND paciente_usuario.id_login    = login.id"
            + "      AND paciente.id=?";
    private final String buscaPacienteUsuarioPorIdLogin = "SELECT * FROM paciente_usuario pu "
            + "INNER JOIN login lo on pu.id_login = lo.id "
            + "INNER JOIN paciente pa on pu.id_paciente = pa.id "
            + "INNER JOIN endereco en on pu.id_endereco = en.id "
            + "INNER JOIN cidade ci on en.id_cidade = ci.id "
            + "INNER JOIN estado es on ci.id_estado = es.id "
            + "WHERE lo.id = ?";
    private final String buscaPacienteUsuarioPorIdPaciente = "SELECT * FROM paciente_usuario pu "
            + "INNER JOIN login lo on pu.id_login = lo.id "
            + "INNER JOIN paciente pa on pu.id_paciente = pa.id "
            + "INNER JOIN endereco en on pu.id_endereco = en.id "
            + "INNER JOIN cidade ci on en.id_cidade = ci.id "
            + "INNER JOIN estado es on ci.id_estado = es.id "
            + "WHERE pa.id = ?";
    private final String buscaPacientePorId = "SELECT	paciente_usuario.telefone,              paciente_usuario.telefone2,"
            + "		paciente.cpf, 				paciente.data_nascimento,"
            + "        paciente.nome,				paciente.sexo,"
            + "        paciente.sobrenome,			paciente.id,"
            + "        endereco.bairro,			endereco.cep,"
            + "        endereco.complemento,                   endereco.id,"
            + "        endereco.id_cidade,			endereco.numero,"
            + "        endereco.rua,				cidade.nome,"
            + "        cidade.id,				cidade.id_estado,"
            + "        estado.id,				estado.nome,"
            + "        estado.uf,                              login.senha,"
            + "        login.email,                            login.perfil,"
            + "        login.perfil,                           login.id"
            + "   FROM	paciente_usuario, paciente, endereco, cidade, estado, login"
            + "  WHERE	paciente_usuario.id_endereco = endereco.id"
            + "    AND	paciente_usuario.id_paciente = paciente.id"
            + "    AND endereco.id_cidade           = cidade.id"
            + "    AND cidade.id_estado             = estado.id"
            + "    AND login.id                     = paciente_usuario.id_login"
            + "    AND paciente_usuario.id_login = ?";

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    public final int inserirPacienteUsuario(PacienteUsuario pacienteUsuario) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(inserePacienteUsuario, Statement.RETURN_GENERATED_KEYS);
            int idPaciente = Facade.inserirPaciente(pacienteUsuario.getPaciente());
            int idLogin = Facade.inserirLogin(pacienteUsuario.getLogin());
            int idEndereco = Facade.inserirEndereco(pacienteUsuario.getEndereco());
            stmt.setInt(1, idPaciente);
            stmt.setInt(2, idLogin);
            stmt.setInt(3, idEndereco);
            stmt.setString(4, pacienteUsuario.getTelefone());
            stmt.setString(5, pacienteUsuario.getTelefone2());
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
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
        return 0;
    }

    public PacienteUsuario buscaPacientePorIdLogin(int id) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaPacientePorId);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()) {
                PacienteUsuario pacienteUsuario = new PacienteUsuario();
                Paciente paciente = new Paciente();
                Endereco endereco = new Endereco();
                Cidade cidade = new Cidade();
                Estado estado = new Estado();
                Login login = new Login();

                login.setEmail(rs.getString("login.email"));
                login.setId(rs.getInt("login.id"));
                login.setPerfil(rs.getInt("login.perfil"));
                login.setSenha(rs.getString("login.senha"));
                pacienteUsuario.setTelefone(rs.getString("paciente_usuario.telefone"));
                pacienteUsuario.setTelefone2(rs.getString("paciente_usuario.telefone2"));

                paciente.setCpf(rs.getString("paciente.cpf"));
                paciente.setDataNascimento(rs.getDate("paciente.data_nascimento"));
                paciente.setId(rs.getInt("paciente.id"));
                paciente.setNome(rs.getString("paciente.nome"));
                paciente.setSexo(rs.getString("paciente.sexo"));
                paciente.setSobrenome(rs.getString("paciente.sobrenome"));

                endereco.setBairro(rs.getString("endereco.bairro"));
                endereco.setCep(rs.getString("endereco.cep"));
                endereco.setComplemento(rs.getString("endereco.complemento"));
                endereco.setNumero(rs.getString("endereco.numero"));
                endereco.setRua(rs.getString("endereco.rua"));
                endereco.setId(rs.getInt("endereco.id"));

                cidade.setId(rs.getInt("cidade.id"));
                cidade.setNome(rs.getString("cidade.nome"));

                estado.setId(rs.getInt("estado.id"));
                estado.setNome(rs.getString("estado.nome"));
                estado.setUf(rs.getString("estado.uf"));

                cidade.setEstado(estado);
                endereco.setCidade(cidade);
                pacienteUsuario.setPaciente(paciente);
                pacienteUsuario.setEndereco(endereco);
                pacienteUsuario.setLogin(login);
                return pacienteUsuario;
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

    public void alteraDadosPaciente(PacienteUsuario pacienteUsuario) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(updatePacienteUsuario);
            stmt.setString(1, pacienteUsuario.getTelefone());
            stmt.setString(2, pacienteUsuario.getTelefone2());
            stmt.setString(3, pacienteUsuario.getPaciente().getCpf());
            stmt.setString(4, pacienteUsuario.getPaciente().getSexo());
            stmt.setString(5, pacienteUsuario.getPaciente().getNome());
            java.sql.Date dataSql = new java.sql.Date(pacienteUsuario.getPaciente().getDataNascimento().getTime());
            stmt.setDate(6, dataSql);
            stmt.setString(7, pacienteUsuario.getPaciente().getSobrenome());
            stmt.setString(8, pacienteUsuario.getEndereco().getBairro());
            stmt.setString(9, pacienteUsuario.getEndereco().getCep());
            stmt.setString(10, pacienteUsuario.getEndereco().getComplemento());
            stmt.setInt(11, pacienteUsuario.getEndereco().getCidade().getId());
            stmt.setString(12, pacienteUsuario.getEndereco().getNumero());
            stmt.setString(13, pacienteUsuario.getEndereco().getRua());
            stmt.setString(14, pacienteUsuario.getLogin().getEmail());
            stmt.setInt(15, pacienteUsuario.getPaciente().getId());

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

    public PacienteUsuario buscarPacienteUsuarioPorIdLogin(int idLogin) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaPacienteUsuarioPorIdLogin);
            stmt.setInt(1, idLogin);
            rs = stmt.executeQuery();
            if (rs.next()) {
                PacienteUsuario pacienteUsuario = new PacienteUsuario();
                Paciente paciente = new Paciente();
                Endereco endereco = new Endereco();
                Cidade cidade = new Cidade();
                Estado estado = new Estado();

                pacienteUsuario.setTelefone(rs.getString("pu.telefone"));
                pacienteUsuario.setTelefone2(rs.getString("pu.telefone2"));

                paciente.setCpf(rs.getString("pa.cpf"));
                paciente.setDataNascimento(rs.getDate("pa.data_nascimento"));
                paciente.setId(rs.getInt("pa.id"));
                paciente.setNome(rs.getString("pa.nome"));
                paciente.setSexo(rs.getString("pa.sexo"));
                paciente.setSobrenome(rs.getString("pa.sobrenome"));

                endereco.setBairro(rs.getString("en.bairro"));
                endereco.setCep(rs.getString("en.cep"));
                endereco.setComplemento(rs.getString("en.complemento"));
                endereco.setNumero(rs.getString("en.numero"));
                endereco.setRua(rs.getString("en.rua"));
                endereco.setId(rs.getInt("en.id"));

                cidade.setId(rs.getInt("ci.id"));
                cidade.setNome(rs.getString("ci.nome"));

                estado.setId(rs.getInt("es.id"));
                estado.setNome(rs.getString("es.nome"));
                estado.setUf(rs.getString("es.uf"));

                cidade.setEstado(estado);
                endereco.setCidade(cidade);
                pacienteUsuario.setPaciente(paciente);
                pacienteUsuario.setEndereco(endereco);
                return pacienteUsuario;
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

    public void deletePacienteUsuario(PacienteUsuario pacienteUsuario) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(deletePacienteUsuario);
            stmt.setInt(1, pacienteUsuario.getId());
            stmt.executeUpdate();
            
            stmt = con.prepareStatement(deletePaciente);
            stmt.setInt(1, pacienteUsuario.getPaciente().getId());
            stmt.executeUpdate();
            
            stmt = con.prepareStatement(deleteEndereco);
            stmt.setInt(1, pacienteUsuario.getEndereco().getId());
            stmt.executeUpdate();
            
            
            stmt = con.prepareStatement(deleteLogin);
            stmt.setInt(1, pacienteUsuario.getLogin().getId());
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
    
    public PacienteUsuario buscarPacienteUsuarioPorIdPaciente(int idPaciente) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaPacienteUsuarioPorIdPaciente);
            stmt.setInt(1, idPaciente);
            rs = stmt.executeQuery();
            if (rs.next()) {
                PacienteUsuario pacienteUsuario = new PacienteUsuario();
                Paciente paciente = new Paciente();
                Endereco endereco = new Endereco();
                Cidade cidade = new Cidade();
                Estado estado = new Estado();

                pacienteUsuario.setTelefone(rs.getString("pu.telefone"));
                pacienteUsuario.setTelefone2(rs.getString("pu.telefone2"));
                pacienteUsuario.setId(rs.getInt("pu.id"));

                paciente.setCpf(rs.getString("pa.cpf"));
                paciente.setDataNascimento(rs.getDate("pa.data_nascimento"));
                paciente.setId(rs.getInt("pa.id"));
                paciente.setNome(rs.getString("pa.nome"));
                paciente.setSexo(rs.getString("pa.sexo"));
                paciente.setSobrenome(rs.getString("pa.sobrenome"));

                endereco.setBairro(rs.getString("en.bairro"));
                endereco.setCep(rs.getString("en.cep"));
                endereco.setComplemento(rs.getString("en.complemento"));
                endereco.setNumero(rs.getString("en.numero"));
                endereco.setRua(rs.getString("en.rua"));
                endereco.setId(rs.getInt("en.id"));

                cidade.setId(rs.getInt("ci.id"));
                cidade.setNome(rs.getString("ci.nome"));

                estado.setId(rs.getInt("es.id"));
                estado.setNome(rs.getString("es.nome"));
                estado.setUf(rs.getString("es.uf"));

                cidade.setEstado(estado);
                endereco.setCidade(cidade);
                pacienteUsuario.setPaciente(paciente);
                pacienteUsuario.setEndereco(endereco);
                return pacienteUsuario;
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
