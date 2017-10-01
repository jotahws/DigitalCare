/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Endereco;
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
public class EnderecoDAO {
    
    private final String insereEndereco = "INSERT INTO endereco (id_cidade, cep, rua, numero, complemento, bairro) "
            + "VALUES (?,?,?,?,?,?)";
    private final String updateEndereco = "UPDATE endereco SET id_cidade=?, cep=?, rua=?, numero=?, complemento=?, "
            + "bairro=? where id=?";
    
    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;
   
    public void atualizarEndereco(Endereco endereco) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(updateEndereco);
            stmt.setInt(1, endereco.getCidade().getId());
            stmt.setString(2, endereco.getCep());
            stmt.setString(3, endereco.getRua());
            stmt.setString(4, endereco.getNumero());
            stmt.setString(5, endereco.getComplemento());
            stmt.setString(6, endereco.getBairro());
            stmt.setInt(7, endereco.getId());
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
    
    public int inserirEndereco(Endereco endereco) throws ClassNotFoundException, SQLException{
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereEndereco, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, endereco.getCidade().getId());
            stmt.setString(2, endereco.getCep());
            stmt.setString(3, endereco.getRua());
            stmt.setString(4, endereco.getNumero());
            stmt.setString(5, endereco.getComplemento());
            stmt.setString(6, endereco.getBairro());
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
}
