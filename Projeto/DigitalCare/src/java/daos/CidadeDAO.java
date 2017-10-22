/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Cidade;
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
 * @author Gabriel
 */
public class CidadeDAO {

    private final String listaCidadePorEstado = "SELECT * FROM cidade WHERE id_estado = ?";
    private final String buscaCidadePorId = "SELECT * FROM cidade c INNER JOIN estado e ON c.id_estado = e.id "
            + "WHERE c.id = ?";
    private final String buscaCidadePorNome = "SELECT * FROM cidade c INNER JOIN estado e ON c.id_estado = e.id "
            + "WHERE c.nome = ?";
    private final String buscaCidadePorNomeParcial = "SELECT * FROM cidade c INNER JOIN estado e ON c.id_estado = e.id "
            + "WHERE c.nome LIKE ?;";

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    public List<Cidade> listarCidades(int idEstado) throws ClassNotFoundException, SQLException {

        try {
            List<Cidade> lista = new ArrayList();
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(listaCidadePorEstado);
            stmt.setInt(1, idEstado);
            rs = stmt.executeQuery();
            while (rs.next()) {

                int id = rs.getInt("id");
                String nome = rs.getString("nome");
                Cidade cidade = new Cidade();
                cidade.setId(id);
                cidade.setNome(nome);
                lista.add(cidade);
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

    public Cidade buscarCidade(int id) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaCidadePorId);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()) {
                //Cidade
                int idCidade = rs.getInt("c.id");
                String nomeCidade = rs.getString("c.nome");
                //Estado
                int idEstado = rs.getInt("e.id");
                String nomeEstado = rs.getString("e.nome");
                String ufEstado = rs.getString("e.uf");
                //instanciar
                Estado estado = new Estado(idEstado, nomeEstado, ufEstado);
                Cidade cidade = new Cidade(idCidade, estado, nomeCidade);
                return cidade;
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

    public Cidade buscarCidadeNome(String cidadeNome) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaCidadePorNome);
            stmt.setString(1, cidadeNome);
            rs = stmt.executeQuery();
            if (rs.next()) {
                //Cidade
                int idCidade = rs.getInt("c.id");
                String nomeCidade = rs.getString("c.nome");
                //Estado
                int idEstado = rs.getInt("e.id");
                String nomeEstado = rs.getString("e.nome");
                String ufEstado = rs.getString("e.uf");
                //instanciar
                Estado estado = new Estado(idEstado, nomeEstado, ufEstado);
                Cidade cidade = new Cidade(idCidade, estado, nomeCidade);
                return cidade;
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

    public List<Cidade> buscarCidadesPorNomeParcial(String nome) throws ClassNotFoundException, SQLException {
        try {
            List<Cidade> lista = new ArrayList();
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaCidadePorNomeParcial);
            stmt.setString(1, nome+"%");
            rs = stmt.executeQuery();
            while (rs.next()) {
                //Cidade
                int idCidade = rs.getInt("c.id");
                String nomeCidade = rs.getString("c.nome");
                //Estado
                int idEstado = rs.getInt("e.id");
                String nomeEstado = rs.getString("e.nome");
                String ufEstado = rs.getString("e.uf");
                //instanciar
                Estado estado = new Estado(idEstado, nomeEstado, ufEstado);
                Cidade cidade = new Cidade(idCidade, estado, nomeCidade);
                lista.add(cidade);
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
