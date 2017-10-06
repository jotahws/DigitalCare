/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Convenio;
import beans.ConvenioPaciente;
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
public class ConvenioDAO {

    private final String buscaConveniosPorMedico = "SELECT * FROM convenio co "
            + "INNER JOIN medico_convenio mc ON co.id = mc.id_convenio "
            + "WHERE mc.id_medico = ?";
    private final String buscaConvenios = "SELECT * FROM convenio";
    private final String deleteConvenioMedico = "DELETE FROM medico_convenio WHERE id_medico =?";
    private final String buscaConvenioPorId = "SELECT * FROM convenio WHERE id=?";
    private final String insereConvenioMedico = "INSERT INTO medico_convenio "
            + "(id_medico, id_convenio) VALUES (?,?)";
    private final String deleteConvenioPaciente = "DELETE FROM paciente_convenio WHERE id_paciente = ?";
    private final String insereConvenioPaciente = "INSERT INTO paciente_convenio (id_paciente, id_convenio, "
            + "numero, validade) VALUES (?,?,?,?)";

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    public int inserirConvenioPaciente(ConvenioPaciente convenioPaciente) throws ClassNotFoundException, SQLException{
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereConvenioPaciente, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, convenioPaciente.getPaciente().getId());
            stmt.setInt(2, convenioPaciente.getConvenio().getId());
            stmt.setString(3, convenioPaciente.getNumero());
            java.sql.Date dataSql = new java.sql.Date(convenioPaciente.getValidade().getTime());
            stmt.setDate(4, dataSql);
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
    
    public int inserirConvenioMedico(int idMedico, int idConvenio) throws ClassNotFoundException, SQLException{
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereConvenioMedico, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, idMedico);
            stmt.setInt(2, idConvenio);
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
    
    public Convenio buscarConvenioPorId(int id) throws ClassNotFoundException, SQLException{
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaConvenioPorId);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()){
                Convenio convenio = new Convenio();
                convenio.setId(rs.getInt("id"));
                convenio.setNome(rs.getString("nome"));
                return convenio;
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
    
    public void deletarConveniosPaciente(int idPaciente) throws ClassNotFoundException, SQLException{
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(deleteConvenioPaciente);
            stmt.setInt(1, idPaciente);
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
    
    public void deletarConveniosMedico(int idMedico) throws ClassNotFoundException, SQLException{
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(deleteConvenioMedico);
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
    
    public List<Convenio> buscarConveniosPorMedico(int idMedico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaConveniosPorMedico);
            stmt.setInt(1, idMedico);
            rs = stmt.executeQuery();
            List<Convenio> lista = new ArrayList();
            while (rs.next()) {
                Convenio convenio = new Convenio();
                convenio.setId(rs.getInt("id"));
                convenio.setNome(rs.getString("nome"));
                lista.add(convenio);
            }
            return lista;
        } finally {
            try {
                stmt.close();
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public List<Convenio> buscarConvenios() throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaConvenios);
            rs = stmt.executeQuery();
            List<Convenio> lista = new ArrayList();
            while (rs.next()) {
                Convenio convenio = new Convenio();
                convenio.setId(rs.getInt("id"));
                convenio.setNome(rs.getString("nome"));
                lista.add(convenio);
            }
            return lista;
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
