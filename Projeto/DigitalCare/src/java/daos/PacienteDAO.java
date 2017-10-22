/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.ClinicaEndereco;
import beans.Consulta;
import beans.ConvenioPaciente;
import beans.Endereco;
import beans.Login;
import beans.Paciente;
import beans.PacienteUsuario;
import beans.Prontuario_cab;
import beans.Prontuario_item;
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
public class PacienteDAO {

    private final String inserePaciente = "INSERT INTO paciente (cpf, nome, sobrenome, data_nascimento, sexo) "
            + "VALUES (?,?,?,?,?)";
    private final String listPacientes = "SELECT * FROM paciente pac"
            + "   INNER JOIN paciente_usuario        pusu ON (pac.id  		= pusu.id_paciente)"
            + "   INNER JOIN endereco     	   endP	ON (endP.id 		= pusu.id_endereco)"
            + "   INNER JOIN login 		   logP	ON (logP.id 		= pusu.id_login)"
            + "   INNER JOIN paciente_convenio         pc	ON (pc.id_paciente 	= pac.id)"
            + "   INNER JOIN convenio 		   conv ON (conv.id		= pc.id_convenio)"
            + "   INNER JOIN consulta 		    con ON (con.id_paciente	= pac.id)"
            + "   INNER JOIN prontuario_item        pitem	ON (pitem.id_consulta	= con.id)"
            + "   INNER JOIN prontuario_cab          pcab	ON (pcab.id		= pitem.id_prontuario_cab)"
            + "   INNER JOIN clinica                  cli ON (pcab.id_clinica	= cli.id)"
            + "   INNER JOIN clinica_endereco        cend	ON (cend.id_clinica	= cli.id)"
            + "   INNER JOIN endereco 		 endCli	ON (cend.id_endereco	= endCli.id)"
            + "   INNER JOIN medico                     m	ON (con.id_medico	= m.id)"
            + "where m.id = ? and pac.id = pcab.id_paciente and cend.id = con.id_clinica_endereco;";

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    public int inserirPaciente(Paciente paciente) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(inserePaciente, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, paciente.getCpf());
            stmt.setString(2, paciente.getNome());
            stmt.setString(3, paciente.getSobrenome());
            java.sql.Date dataSql = new java.sql.Date(paciente.getDataNascimento().getTime());
            stmt.setDate(4, dataSql);
            stmt.setString(5, paciente.getSexo());
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
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
        return 0;
    }

    public List<PacienteUsuario> listaPacientesNoMedico(int idMedico) throws SQLException, ClassNotFoundException {
        try {
            List<PacienteUsuario> lista = new ArrayList();
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(listPacientes);
            stmt.setInt(1, idMedico);
            rs = stmt.executeQuery();
            while (rs.next()) {
                PacienteUsuario pacienteUsuario = new PacienteUsuario();
                Paciente paciente = new Paciente();
                Login login = new Login();
                Endereco endereco = new Endereco();
                ConvenioPaciente convenioPacinete = new ConvenioPaciente();
                Consulta consulta = new Consulta();
                Prontuario_cab prontuario_cab = new Prontuario_cab();
                Prontuario_item prontuario_item = new Prontuario_item();
                Endereco endClinica = new Endereco();
                ClinicaEndereco clinicaEnd = new ClinicaEndereco();
                List<ClinicaEndereco> listaClinica = new ArrayList();
                lista.add(pacienteUsuario);
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
