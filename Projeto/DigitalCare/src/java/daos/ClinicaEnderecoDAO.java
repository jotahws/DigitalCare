/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.ClinicaEndereco;
import beans.Endereco;
import beans.Medico;
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
 * @author Gabriel
 */
public class ClinicaEnderecoDAO {

    private final String insereClinicaEndereco = "INSERT INTO clinica_endereco (id_clinica, id_endereco, "
            + "telefone1, telefone2, nome) VALUES (?,?,?,?,?)";
    private final String updateClinicaEndereco = "UPDATE clinica_endereco SET telefone1 = ?, "
            + "telefone2 = ?, nome = ? WHERE id = ?";
    private final String removeClinicaEndereco = "DELETE FROM clinica_endereco "
            + "WHERE id=?;";
    private final String buscaClinicaEnderecoPorID = "SELECT * FROM clinica_endereco ce \n"
            + "INNER JOIN endereco e ON e.id = ce.id_endereco\n"
            + "WHERE ce.id=?;";
    private final String buscaClinicaEnderecoMedico = "SELECT * FROM clinica_endereco ce \n"
            + "INNER JOIN endereco e ON e.id = ce.id_endereco\n"
            + "INNER JOIN medico_clinica mc ON mc.id_clinica_endereco = ce.id\n"
            + "INNER JOIN medico m ON mc.id_medico = m.id\n"
            + "WHERE m.id=?;";
    private final String insereMedicoClinica = "INSERT INTO medico_clinica (id_clinica_endereco, id_medico) VALUES (?, ?)";

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    public final void atualizarClinicaEndereco(ClinicaEndereco clinicaEndereco) throws ClassNotFoundException, SQLException {
        try {
            Facade.atualizarClinica(clinicaEndereco.getClinica());
            Facade.atualizarEndereco(clinicaEndereco.getEndereco());
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(updateClinicaEndereco);
            stmt.setString(1, clinicaEndereco.getTelefone1());
            stmt.setString(2, clinicaEndereco.getTelefone2());
            stmt.setString(3, clinicaEndereco.getNome());
            stmt.setInt(4, clinicaEndereco.getId());
            stmt.executeUpdate();
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

    public final int inserirClinicaEndereco(ClinicaEndereco clinicaEndereco) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereClinicaEndereco, Statement.RETURN_GENERATED_KEYS);
            int idClinica = Facade.inserirClinica(clinicaEndereco.getClinica());
            int idEndereco = Facade.inserirEndereco(clinicaEndereco.getEndereco());
            stmt.setInt(1, idClinica);
            stmt.setInt(2, idEndereco);
            stmt.setString(3, clinicaEndereco.getTelefone1());
            stmt.setString(4, clinicaEndereco.getTelefone2());
            stmt.setString(5, clinicaEndereco.getNome());
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
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
        return 0;
    }

    public final int novaClinicaEndereco(ClinicaEndereco clinicaEndereco) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereClinicaEndereco, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, clinicaEndereco.getClinica().getId());
            stmt.setInt(2, clinicaEndereco.getEndereco().getId());
            stmt.setString(3, clinicaEndereco.getTelefone1());
            stmt.setString(4, clinicaEndereco.getTelefone2());
            stmt.setString(5, clinicaEndereco.getNome());
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
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
        return 0;
    }

    public void removerClinicaEndereco(ClinicaEndereco clinicaEndereco) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(removeClinicaEndereco);
            stmt.setInt(1, clinicaEndereco.getId());
            stmt.executeUpdate();
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

    public void vincularMedicoClinica(int idMedico, int idClinicaEndereco) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereMedicoClinica);
            stmt.setInt(1, idClinicaEndereco);
            stmt.setInt(2, idMedico);
            stmt.executeUpdate();
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

    public ClinicaEndereco buscaClinicaEnderecoPorId(int idClinicaEnd) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaClinicaEnderecoPorID);
            stmt.setInt(1, idClinicaEnd);
            rs = stmt.executeQuery();
            if (rs.next()) {
                Endereco end = new Endereco();
                end.setId(rs.getInt("e.id"));
                end.setRua(rs.getString("e.rua"));
                end.setNumero(rs.getString("e.numero"));
                end.setBairro(rs.getString("e.bairro"));
                ClinicaEndereco clinicaEnd = new ClinicaEndereco();
                clinicaEnd.setId(idClinicaEnd);
                clinicaEnd.setNome(rs.getString("ce.nome"));
                clinicaEnd.setEndereco(end);
                return clinicaEnd;
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

    public List<ClinicaEndereco> buscaClinicaEnderecoPorMedico(Medico medico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaClinicaEnderecoMedico);
            stmt.setInt(1, medico.getId());
            rs = stmt.executeQuery();
            List<ClinicaEndereco> lista = new ArrayList();
            while (rs.next()) {
                Endereco end = new Endereco();
                end.setId(rs.getInt("e.id"));
                end.setRua(rs.getString("e.rua"));
                end.setNumero(rs.getString("e.numero"));
                end.setBairro(rs.getString("e.bairro"));
                ClinicaEndereco clinicaEnd = new ClinicaEndereco();
                clinicaEnd.setId(rs.getInt("ce.id"));
                clinicaEnd.setNome(rs.getString("ce.nome"));
                clinicaEnd.setEndereco(end);
                lista.add(clinicaEnd);
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
