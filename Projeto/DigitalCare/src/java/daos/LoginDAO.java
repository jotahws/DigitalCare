/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Clinica;
import beans.Login;
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
public class LoginDAO {

    private final String insereLogin = "INSERT INTO login (email, senha, perfil) VALUES (?,?,?)";
    private final String buscaLoginPorEmail = "select * from login l where l.email = ? AND l.senha = ?;";
    private final String buscaLoginPorId = "select * from login l where l.id = ?;";
    private final String buscaSenhaAtual = "select * from login l where l.id=? and l.senha =?;";
    private final String updateSenha = "update login set login.senha = ? where login.id=?";
    private final String deleteLogin = "DELETE FROM login WHERE id=?";

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    public void deletarLogin(int id) throws ClassNotFoundException, SQLException{
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(deleteLogin);
            stmt.setInt(1, id);
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
    
    public int inserirLogin(Login login) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereLogin, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, login.getEmail());
            stmt.setString(2, login.getSenha());
            stmt.setInt(3, login.getPerfil());
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
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
        return 0;
    }

    public Login buscarLogin(Login login) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaLoginPorEmail);
            stmt.setString(1, login.getEmail());
            stmt.setString(2, login.getSenha());
            rs = stmt.executeQuery();
            if (rs.next()) {
                //login
                int idLogin = rs.getInt("l.id");
                int perfil = rs.getInt("l.perfil");
                login.setId(idLogin);
                login.setPerfil(perfil);
                return login;
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
    
    public Login buscarLoginPorId(int id) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaLoginPorId);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()) {
                //login
                Login login = new Login();
                int idLogin = rs.getInt("l.id");
                int perfil = rs.getInt("l.perfil");
                String email = rs.getString("l.email");
                login.setId(idLogin);
                login.setPerfil(perfil);
                login.setEmail(email);
                return login;
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

    public Boolean verificaSenhaAtual(int id, String senha) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaSenhaAtual);
            stmt.setInt(1, id);
            stmt.setString(2, senha);
            rs = stmt.executeQuery();
            return rs.next();
        } finally {
            try {
                stmt.close();
                con.close();
                rs.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public void atualizaSenhaPacienteUsuario(PacienteUsuario pacienteUsuario, String novaSenha) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(updateSenha);
            stmt.setString(1, novaSenha);
            stmt.setInt(2, pacienteUsuario.getLogin().getId());
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

    public Boolean senhaAtualCorreta(int id, String senha) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaSenhaAtual);
            stmt.setInt(1, id);
            stmt.setString(2, senha);
            rs = stmt.executeQuery();
            return rs.next();
        } finally {
            try {
                stmt.close();
                con.close();
                rs.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public void atualizaSenha(int id, String novaSenha) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(updateSenha);
            stmt.setString(1, novaSenha);
            stmt.setInt(2, id);
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
