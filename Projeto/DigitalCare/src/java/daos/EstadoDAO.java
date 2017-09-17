/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Estado;
import conexao.ConnectionFactory;
import facade.Facade;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author JotaWind
 */
public class EstadoDAO {
    
    private final String listaEstados = "SELECT * from estado;";
    
    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;
    
    public List<Estado> listarEstados() throws ClassNotFoundException, SQLException {
        try {
            List<Estado> lista = new ArrayList();
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(listaEstados);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Estado estado = new Estado();
                int idEst = rs.getInt("id");
                String nome = rs.getString("nome");
                String uf = rs.getString("uf");
                estado.setId(idEst);
                estado.setNome(nome);
                estado.setUf(uf);
                lista.add(estado);
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
