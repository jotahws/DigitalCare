/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Consulta;
import beans.Medico;
import beans.Paciente;
import beans.PacienteUsuario;
import beans.Prontuario;
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
 * @author JotaWind
 */
public class ProntuarioDAO {
    
    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;
    
    private final String updateAtestado = "UPDATE prontuario_item SET ATESTADO = ? WHERE ID_CONSULTA = ?";
    private final String updateExame = "UPDATE prontuario_item SET EXAME = ? WHERE ID_CONSULTA = ?";
    private final String updateReceita = "UPDATE prontuario_item SET RECEITA = ? WHERE ID_CONSULTA = ?";
    private final String updateDescricao = "UPDATE prontuario_item SET DESCRICAO = ? WHERE ID_CONSULTA = ?";
    private final String criaProntuario = "INSERT INTO prontuario_item (ID_CONSULTA) VALUES (?);";
    private final String listaProntuarioPacienteMedico = "select * from prontuario_item pi \n"
            + "inner join consulta c on c.id = pi.id_consulta \n "
            + "AND c.status = 'Concluído' \n"
            + "where c.id_medico = ? AND c.id_paciente = ? order by c.datahora desc;";
    
    public void updateAtestado(Prontuario prontuario)throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(updateAtestado);
            stmt.setBlob(1, prontuario.getAtestado());
            stmt.setInt(2, prontuario.getConsulta().getId());
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
    
    public void updateReceita(Prontuario prontuario)throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(updateReceita);
            stmt.setBlob(1, prontuario.getReceita());
            stmt.setInt(2, prontuario.getConsulta().getId());
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
    
    public void updateExame(Prontuario prontuario)throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(updateExame);
            stmt.setBlob(1, prontuario.getExame());
            stmt.setInt(2, prontuario.getConsulta().getId());
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
    
    public void updateDescricao(Prontuario prontuario)throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(updateDescricao);
            stmt.setBlob(1, prontuario.getDescricao());
            stmt.setInt(2, prontuario.getConsulta().getId());
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
    
    public Prontuario criaProntuario(Prontuario prontuario) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(criaProntuario, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, prontuario.getConsulta().getId());
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                prontuario.setId(rs.getInt(1));
            }
            return prontuario;
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
    
    public List<Prontuario> listaProntuariosPacienteMedico(PacienteUsuario paciente, Medico medico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(listaProntuarioPacienteMedico);
            stmt.setInt(1, medico.getId());
            stmt.setInt(2, paciente.getPaciente().getId());
            rs = stmt.executeQuery();
            List<Prontuario> prontuarios = new ArrayList<>();
            while (rs.next()) {
                Prontuario prontuario = new Prontuario();
                Consulta consulta = new Consulta();
                prontuario.setId(rs.getInt("pi.id"));
                prontuario.setAtestado(rs.getBlob("pi.atestado"));
                prontuario.setExame(rs.getBlob("pi.exame"));
                prontuario.setDescricao(rs.getBlob("pi.descricao"));
                prontuario.setReceita(rs.getBlob("pi.receita"));
                consulta.setId(rs.getInt("c.id"));
                consulta = Facade.getConsultaPorId(consulta);
                prontuario.setConsulta(consulta);
                prontuarios.add(prontuario);
            }
            return prontuarios;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }
}
