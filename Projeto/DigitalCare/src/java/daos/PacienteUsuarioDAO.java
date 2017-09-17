/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.PacienteUsuario;
import conexao.ConnectionFactory;
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
    
    private final String inserePacienteUsuario = "INSERT INTO paciente_usuario (id_paciente, id_endereco, "
            + "email, senha, telefone1, telefone) VALUES (?,?,?,?,?,?)";
    
    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;
    
    public final int inserirPacienteUsuario(PacienteUsuario pacienteUsuario) throws ClassNotFoundException, SQLException{
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(inserePacienteUsuario, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, pacienteUsuario.getPaciente().getId());
            stmt.setInt(2, pacienteUsuario.getEndereco().getId());
            stmt.setString(3, pacienteUsuario.getEmail());
            stmt.setString(4, pacienteUsuario.getSenha());
            stmt.setString(5, pacienteUsuario.getTelefone());
            stmt.setString(6, pacienteUsuario.getTelefone2());
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
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
}
