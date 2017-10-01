/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Especialidade;
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
    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

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
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }
    
}
