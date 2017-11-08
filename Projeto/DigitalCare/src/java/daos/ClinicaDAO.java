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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Gabriel
 */
public class ClinicaDAO {
    
    private final String insereClinica = "INSERT INTO clinica (id_login, cnpj, razao_social, "
            + "nome_fantasia, site) VALUES (?,?,?,?,?)";
    private final String updateClinica = "UPDATE clinica SET razao_social = ?, nome_fantasia = ?, "
            + "site = ? WHERE id = ?";
    private final String buscaClinicaPorLogin = "SELECT * FROM clinica WHERE id_login = ?";
    private final String listaClinicas = "SELECT * FROM clinica";
    
    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;
    
    public final Clinica buscarClinicaPorLogin(int idLogin) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaClinicaPorLogin);
            stmt.setInt(1, idLogin);
            rs = stmt.executeQuery();
            if (rs.next()) {
                Clinica clinica = new Clinica();
                clinica.setId(rs.getInt("id"));
                clinica.setAvaliacao(rs.getDouble("avaliacao"));
                clinica.setCnpj(rs.getString("cnpj"));
                clinica.setNomeFantasia(rs.getString("nome_fantasia"));
                clinica.setRazaoSocial(rs.getString("razao_social"));
                clinica.setSite(rs.getString("site"));
                return clinica;
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
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
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
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
        return 0;
    }

    public List<Clinica> listarClinicas() throws ClassNotFoundException, SQLException {
        try {
            List<Clinica> lista = new ArrayList();
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(listaClinicas);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Clinica clinica = new Clinica();
                clinica.setId(rs.getInt("id"));
                clinica.setNomeFantasia(rs.getString("nome_fantasia"));
                clinica.setSite(rs.getString("site"));
                clinica.setAvaliacao(rs.getDouble("avaliacao"));
                lista.add(clinica);
            }
            return lista;
        } finally {
            try {
                con.close();
                stmt.close();
                rs.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

}
