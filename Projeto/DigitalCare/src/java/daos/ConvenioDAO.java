/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Convenio;
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

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

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
