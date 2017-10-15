/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Especialidade;
import com.mysql.jdbc.Statement;
import conexao.ConnectionFactory;
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
public class EspecialidadeDAO {
    
    private final String buscaEspecialidadesPorMedico = "SELECT * FROM especialidade es " +
       "INNER JOIN medico_especialidade me ON es.id = me.id_especialidade " +
       "WHERE me.id_medico = ?";
    private final String buscaEspecialidades = "SELECT * FROM especialidade es";
    private final String deleteEspecialidades = "DELETE FROM medico_especialidade WHERE id_medico = ?";
    private final String insereEspecialidade = "INSERT INTO medico_especialidade "
            + "(id_medico, id_especialidade) VALUES (?,?)";
    private final String buscaEspecialidadePorId = "SELECT * FROM especialidade WHERE id=?";
    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    public Especialidade buscarEspecialidadePorId(int id) throws ClassNotFoundException, SQLException{
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaEspecialidadePorId);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()){
                Especialidade especialidade = new Especialidade();
                especialidade.setId(rs.getInt("id"));
                especialidade.setNome(rs.getString("nome"));
                especialidade.setDescricao(rs.getString("descricao"));
                return especialidade;
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
    
    public int inserirEspecialidadeMedico(int idMedico, int idEspecialidade) throws ClassNotFoundException, SQLException{
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereEspecialidade, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, idMedico);
            stmt.setInt(2, idEspecialidade);
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
    
    public void deletarEspecialidadesMedico(int idMedico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(deleteEspecialidades);
            stmt.setInt(1, idMedico);
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
    
    public List<Especialidade> buscarEspecialidadesPorMedico(int idMedico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaEspecialidadesPorMedico);
            stmt.setInt(1, idMedico);
            rs = stmt.executeQuery();
            List<Especialidade> lista = new ArrayList();
            while (rs.next()){
                Especialidade especialidade = new Especialidade();
                especialidade.setId(rs.getInt("es.id"));
                especialidade.setNome(rs.getString("es.nome"));
                especialidade.setDescricao(rs.getString("es.descricao"));
                lista.add(especialidade);
            }
            return lista;
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
    
    public List<Especialidade> buscarEspecialidades() throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaEspecialidades);
            rs = stmt.executeQuery();
            List<Especialidade> lista = new ArrayList();
            while (rs.next()){
                Especialidade especialidade = new Especialidade();
                especialidade.setId(rs.getInt("es.id"));
                especialidade.setNome(rs.getString("es.nome"));
                especialidade.setDescricao(rs.getString("es.descricao"));
                lista.add(especialidade);
            }
            return lista;
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
    
}
