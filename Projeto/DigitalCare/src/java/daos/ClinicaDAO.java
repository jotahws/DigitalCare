/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Clinica;
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
public class ClinicaDAO {
    
    private final String insereClinica = "INSERT INTO clinica (id_login, cnpj, razao_social, "
            + "nome_fantasia, site) VALUES (?,?,?,?,?)";
    private final String updateClinica = "UPDATE clinica SET razao_social = ?, nome_fantasia = ?, "
            + "site = ? WHERE id = ?";
    
    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;
    
    public final void atualizarClinica(Clinica clinica) throws ClassNotFoundException, SQLException {
        try { 
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(updateClinica);
            stmt.setString(1, clinica.getRazaoSocial());
            stmt.setString(2, clinica.getNomeFantasia());
            stmt.setString(3, clinica.getSite());
            stmt.setInt(4, clinica.getId());
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
    
    public final int inserirClinica(Clinica clinica) throws ClassNotFoundException, SQLException{
        try{
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereClinica, Statement.RETURN_GENERATED_KEYS);
            int idLogin = Facade.inserirLogin(clinica.getLogin());
            stmt.setInt(1, idLogin);
            stmt.setString(2, clinica.getCnpj());
            stmt.setString(3, clinica.getRazaoSocial());
            stmt.setString(4, clinica.getNomeFantasia());
            stmt.setString(5, clinica.getSite());
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
