/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Medico;
import com.mysql.jdbc.Statement;
import conexao.ConnectionFactory;
import facade.Facade;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Gabriel
 */
public class MedicoDAO {
    
    private final String insereMedico = "INSERT INTO medico (id_login, id_estado_crm, num_crm, nome, sobrenome, cpf) "
            + "VALUES (?,?,?,?,?,?)";
    
    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;
    
    public int inserirMedico(Medico medico) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(insereMedico, Statement.RETURN_GENERATED_KEYS);
            int idLogin = Facade.inserirLogin(medico.getLogin());
            stmt.setInt(1, idLogin);
            stmt.setInt(2, medico.getEstadoCrm().getId());
            stmt.setString(3, medico.getNumeroCrm());
            stmt.setString(4, medico.getNome());
            stmt.setString(5, medico.getSobrenome());
            stmt.setString(6, medico.getCpf());
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } finally {
            try {
                stmt.close();
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
        return 0;
    }
    
}
