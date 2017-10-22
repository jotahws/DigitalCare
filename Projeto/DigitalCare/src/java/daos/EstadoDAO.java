/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Estado;
import conexao.ConnectionFactory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author JotaWind
 */
public class EstadoDAO {
    
    private final String listaEstados = "SELECT * FROM estado;";
    private final String buscaEstadoPorId = "SELECT * FROM estado WHERE id=?";
    
    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;
    
    public Estado buscarEstadoPorId(int idEstado) throws ClassNotFoundException, SQLException{
        try{
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaEstadoPorId);
            stmt.setInt(1, idEstado);
            rs = stmt.executeQuery();
            if (rs.next()){
                Estado estado = new Estado();
                String nome = rs.getString("nome");
                String uf = rs.getString("uf");
                estado.setId(idEstado);
                estado.setNome(nome);
                estado.setUf(uf);
                return estado;
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
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }
    
}
