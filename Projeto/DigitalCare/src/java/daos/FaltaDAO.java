/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Falta;
import beans.Medico;
import conexao.ConnectionFactory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author joao.wind
 */
public class FaltaDAO {

    private String inserirFalta = "INSERT INTO medico_falta (id_medico, data_inicio, data_fim, horario_inicio, horario_fim) \n"
            + "VALUES (?, ?, ?, ?, ?);";
    
    private final String buscaFaltasMedico = "SELECT * FROM medico_falta \n"
            + "WHERE id_medico = ?\n";

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;
    
    public final Falta insereFalta(Falta falta) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(inserirFalta, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, falta.getMedico().getId());
            SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat hour = new SimpleDateFormat("HH:mm");
            stmt.setString(2, date.format(falta.getDataInicio().getTime()));
            stmt.setString(3, date.format(falta.getDataFim().getTime()));
            stmt.setString(4, hour.format(falta.getDataInicio().getTime()));
            stmt.setString(5, hour.format(falta.getDataFim().getTime()));
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                falta.setId(rs.getInt(1));
                return falta;
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

    public List<Falta> buscarFaltas(Medico medico) throws ClassNotFoundException, SQLException, ParseException {
        List<Falta> lista = new ArrayList();
        SimpleDateFormat datefmt = new SimpleDateFormat("yyyy-MM-ddHH:mm:ss");
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaFaltasMedico);
            stmt.setInt(1, medico.getId());
            rs = stmt.executeQuery();
            while (rs.next()) {
                Falta medFalta = new Falta();
                Calendar cal = Calendar.getInstance();
                cal.setTime(rs.getDate("data_inicio"));
                Calendar calInicio = Calendar.getInstance();
                calInicio.setTime(datefmt.parse(rs.getString("data_inicio")+rs.getTime("horario_inicio").toString()));
                Calendar calFim = Calendar.getInstance();
                calFim.setTime(datefmt.parse(rs.getString("data_fim")+rs.getTime("horario_fim").toString()));
                medFalta.setDataInicio(calInicio);
                medFalta.setDataFim(calFim);
                medFalta.setId(rs.getInt("id"));
                lista.add(medFalta);
            }
            return lista;
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
