/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.ClinicaEndereco;
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
public class ClinicaEnderecoDAO {
    
    private final String insereClinicaEndereco = "INSERT INTO clinica_endereco (id_clinica, id_endereco, "
            + "telefone1, telefone2) VALUES (?,?,?,?)";
    private final String updateClinicaEndereco = "UPDATE clinica_endereco SET telefone1 = ?, "
            + "telefone2 = ? WHERE id = ?";
    private final String removeClinicaEndereco = "DELETE FROM clinica_endereco "
            + "WHERE id=?;";
    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;
    
    public final void atualizarClinicaEndereco(ClinicaEndereco clinicaEndereco) throws ClassNotFoundException, SQLException {
        try {
            Facade.atualizarClinica(clinicaEndereco.getClinica());
            Facade.atualizarEndereco(clinicaEndereco.getEndereco());
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(updateClinicaEndereco);  
            stmt.setString(1, clinicaEndereco.getTelefone1());
            stmt.setString(2, clinicaEndereco.getTelefone2());
            stmt.setInt(3,clinicaEndereco.getId());
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
    
    public final int inserirClinicaEndereco(ClinicaEndereco clinicaEndereco) throws ClassNotFoundException, SQLException{
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereClinicaEndereco, Statement.RETURN_GENERATED_KEYS);
            int idClinica = Facade.inserirClinica(clinicaEndereco.getClinica());
            int idEndereco = Facade.inserirEndereco(clinicaEndereco.getEndereco());
            stmt.setInt(1,idClinica);
            stmt.setInt(2,idEndereco);
            stmt.setString(3, clinicaEndereco.getTelefone1());
            stmt.setString(4, clinicaEndereco.getTelefone2());
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
    public final int novaClinicaEndereco(ClinicaEndereco clinicaEndereco) throws ClassNotFoundException, SQLException{
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereClinicaEndereco, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1,clinicaEndereco.getClinica().getId());
            stmt.setInt(2,clinicaEndereco.getEndereco().getId());
            stmt.setString(3, clinicaEndereco.getTelefone1());
            stmt.setString(4, clinicaEndereco.getTelefone2());
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

    public void removerClinicaEndereco(ClinicaEndereco clinicaEndereco) throws ClassNotFoundException, SQLException{
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(removeClinicaEndereco);
            stmt.setInt(1,clinicaEndereco.getId());
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
