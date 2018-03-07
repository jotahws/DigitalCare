/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Login;
import beans.Medicamento;
import beans.PacienteUsuario;
import conexao.ConnectionFactory;
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
public class MedicamentoDAO {
    
    private final String buscaMedicamentoPorNome = "select distinct nome, principio_ativo FROM medicamento_anvisa where nome LIKE ?;";

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;
    
    public List<Medicamento> buscar(Medicamento medicamento) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaMedicamentoPorNome);
            stmt.setString(1, "%"+medicamento.getNome()+"%");
            rs = stmt.executeQuery();
            List<Medicamento> medicamentos = new ArrayList();
            while (rs.next()) {
                medicamento = new Medicamento();
//                medicamento.setId(rs.getInt("id"));
//                medicamento.setEan(rs.getString("ean"));
                String nome = Medicamento.capitalizeString(rs.getString("nome"));
                medicamento.setNome(nome);
                medicamento.setPrincipioAtivo(Medicamento.capitalizeString(rs.getString("principio_ativo")));
                medicamentos.add(medicamento);
            }
            return medicamentos;
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
