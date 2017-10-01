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
    private final String buscaPacientePorId = "SELECT	paciente_usuario.telefone,              paciente_usuario.telefone2," +
                                            "		paciente.cpf, 				paciente.data_nascimento," +
                                               "        paciente.nome,				paciente.sexo," +
                                               "        paciente.sobrenome,			paciente.id," +
                                               "        endereco.bairro,			endereco.cep," +
                                               "        endereco.complemento,                   endereco.id," +
                                               "        endereco.id_cidade,			endereco.numero," +
                                               "        endereco.rua,				cidade.nome," +
                                               "        cidade.id,				cidade.id_estado," +
                                               "        estado.id,				estado.nome," +
                                               "        estado.uf,                              login.senha," +
                                               "        login.email,                            login.perfil," +
                                               "        login.perfil,                           login.id" +
                                               "   FROM	paciente_usuario, paciente, endereco, cidade, estado, login" +
                                               "  WHERE	paciente_usuario.id_endereco = endereco.id" +
                                               "    AND	paciente_usuario.id_paciente = paciente.id" +
                                               "    AND endereco.id_cidade           = cidade.id" +
                                               "    AND cidade.id_estado             = estado.id" +
                                               "    AND login.id                     = paciente_usuario.id_login" +
                                               "    AND paciente_usuario.id_login = ?";
    
    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;
    
    public final int inserirPacienteUsuario(PacienteUsuario pacienteUsuario) throws ClassNotFoundException, SQLException{
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(inserePacienteUsuario, Statement.RETURN_GENERATED_KEYS);
            int idPaciente = Facade.inserirPaciente(pacienteUsuario.getPaciente());
            int idLogin    = Facade.inserirLogin(pacienteUsuario.getLogin());
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
                stmt.close();
                con.close();
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
                return pacienteUsuario;
                }
        } finally {
            try {
                stmt.close();
                con.close();
                rs.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
        return null;
        
    }
}
