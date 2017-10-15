/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Cidade;
import beans.ClinicaEndereco;
import beans.Endereco;
import beans.Estado;
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
 * @author Gabriel
 */
public class EnderecoDAO {

    private final String insereEndereco = "INSERT INTO endereco (id_cidade, cep, rua, numero, complemento, bairro) "
            + "VALUES (?,?,?,?,?,?)";
    private final String updateEndereco = "UPDATE endereco SET id_cidade=?, cep=?, rua=?, numero=?, complemento=?, "
            + "bairro=? where id=?";
    private final String removeEndereco = "DELETE FROM endereco "
            + "WHERE id=?;";
    private final String buscaEnderecosClinica = "SELECT * FROM clinica_endereco ce "
            + "INNER JOIN endereco en ON ce.id_endereco = en.id "
            + "INNER JOIN cidade ci ON en.id_cidade = ci.id "
            + "INNER JOIN estado es ON ci.id_estado = es.id "
            + "WHERE ce.id_clinica = ?";

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    public List<ClinicaEndereco> buscarEnderecosClinica(int idClinica) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaEnderecosClinica);
            stmt.setInt(1, idClinica);
            rs = stmt.executeQuery();
            List<ClinicaEndereco> lista = new ArrayList();
            while (rs.next()) {
                Estado estado = new Estado();
                estado.setId(rs.getInt("es.id"));
                estado.setNome(rs.getString("es.nome"));
                estado.setUf(rs.getString("es.uf"));
                Cidade cidade = new Cidade();
                cidade.setEstado(estado);
                cidade.setId(rs.getInt("ci.id"));
                cidade.setNome(rs.getString("ci.nome"));
                Endereco endereco = new Endereco();
                endereco.setCidade(cidade);
                endereco.setId(rs.getInt("en.id"));
                endereco.setBairro(rs.getString("en.bairro"));
                endereco.setCep(rs.getString("en.cep"));
                endereco.setComplemento(rs.getString("en.complemento"));
                endereco.setNumero(rs.getString("en.numero"));
                endereco.setRua(rs.getString("en.rua"));
                ClinicaEndereco clinicaEndereco = new ClinicaEndereco();
                clinicaEndereco.setEndereco(endereco);
                clinicaEndereco.setTelefone1(rs.getString("ce.telefone1"));
                clinicaEndereco.setTelefone2(rs.getString("ce.telefone2"));
                clinicaEndereco.setNome(rs.getString("ce.nome"));
                clinicaEndereco.setId(rs.getInt("ce.id"));
                lista.add(clinicaEndereco);
            }
            return lista;
        } finally {
            try {
                stmt.close();
                con.close();
                rs.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public void atualizarEndereco(Endereco endereco) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(updateEndereco);
            stmt.setInt(1, endereco.getCidade().getId());
            stmt.setString(2, endereco.getCep());
            stmt.setString(3, endereco.getRua());
            stmt.setString(4, endereco.getNumero());
            stmt.setString(5, endereco.getComplemento());
            stmt.setString(6, endereco.getBairro());
            stmt.setInt(7, endereco.getId());
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

    public int inserirEndereco(Endereco endereco) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereEndereco, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, endereco.getCidade().getId());
            stmt.setString(2, endereco.getCep());
            stmt.setString(3, endereco.getRua());
            stmt.setString(4, endereco.getNumero());
            stmt.setString(5, endereco.getComplemento());
            stmt.setString(6, endereco.getBairro());
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } finally {
            try {
                stmt.close();
                con.close();
                rs.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
        return 0;
    }

    public void deletarEndereco(Endereco endereco) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(removeEndereco);
            stmt.setInt(1, endereco.getId());
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
}
