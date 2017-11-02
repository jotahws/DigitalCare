/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Consulta;
import beans.Medico;
import conexao.ConnectionFactory;
import facade.Facade;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author JotaWind
 */
public class ConsultaDAO {

    private final String insereNovaConsulta = "INSERT INTO consulta (id_medico, id_paciente, id_clinica_endereco, datahora, status) "
            + "VALUES (?, ?, ?, ?, ?);";
    private final String deletaConsulta = "UPDATE consulta SET status='Cancelado' WHERE id=?";

    private final String countStatusPorMedicoNoDia = "SELECT c.status, COUNT(c.id) as qtdd FROM consulta c WHERE c.id_medico=? AND date(c.datahora) =  curdate() GROUP BY c.status;";

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    public Consulta insereConsulta(Consulta consulta) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereNovaConsulta, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, consulta.getMedico().getId());
            stmt.setInt(2, consulta.getPaciente().getId());
            stmt.setInt(3, consulta.getClinicaEndereco().getId());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String dataHoraString = sdf.format(consulta.getDataHora());
            stmt.setString(4, dataHoraString);
            stmt.setString(5, consulta.getStatus());
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                consulta.setId(rs.getInt(1));
                return consulta;
            }
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
        return null;
    }

    public void cancelaConsulta(Consulta consulta) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(deletaConsulta);
            stmt.setInt(1, consulta.getId());
            stmt.executeUpdate();
        } finally {
            try {
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

    public List<String[]> buscarStatusPorMedicoNoDia(Medico medico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(countStatusPorMedicoNoDia);
            stmt.setInt(1, medico.getId());
            rs = stmt.executeQuery();
            List<String[]> status = new ArrayList();
            while (rs.next()) {
                String[] item = {rs.getString("status"), rs.getString("qtdd")};
                status.add(item);
            }
            return status;
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
