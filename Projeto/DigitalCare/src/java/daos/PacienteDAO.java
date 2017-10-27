/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Cidade;
import beans.ClinicaEndereco;
import beans.Consulta;
import beans.Convenio;
import beans.ConvenioPaciente;
import beans.Endereco;
import beans.Estado;
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
    private final String perfilPaciente = "SELECT * FROM paciente pac"
            + "   INNER JOIN paciente_usuario        pusu ON (pac.id  		= pusu.id_paciente)"
            + "   INNER JOIN endereco     	   endP	ON (endP.id 		= pusu.id_endereco)"
            + "   INNER JOIN login 		   logP	ON (logP.id 		= pusu.id_login)"
            + "   INNER JOIN consulta 		    con ON (con.id_paciente	= pac.id)"
            + "   INNER JOIN prontuario_item      pitem	ON (pitem.id_consulta	= con.id)"
            + "   INNER JOIN prontuario_cab        pcab	ON (pcab.id		= pitem.id_prontuario_cab)"
            + "   INNER JOIN clinica                cli ON (pcab.id_clinica	= cli.id)"
            + "   INNER JOIN clinica_endereco      cend	ON (cend.id_clinica	= cli.id)"
            + "   INNER JOIN endereco 		 endCli	ON (cend.id_endereco	= endCli.id)"
            + "   INNER JOIN medico                   m	ON (con.id_medico	= m.id)"
            + "   INNER JOIN cidade                 cid ON (cid.id              = endP.id_cidade)"
            + "   INNER JOIN estado                  es ON (es.id               = cid.id_estado)"    
            + "where m.id=? and pusu.id=? and pac.id = pcab.id_paciente and cend.id = con.id_clinica_endereco;";

    private final String listPacientes = "SELECT *FROM paciente pac" +
            "   INNER JOIN paciente_usuario pusu ON (pac.id  			= pusu.id_paciente)" +
            "   INNER JOIN endereco 	    endP ON (endP.id 			= pusu.id_endereco)" +
            "   INNER JOIN login 	    logP ON (logP.id 			= pusu.id_login)" +
            "   INNER JOIN cidade            cid ON (cid.id  			= endP.id_cidade)" +
            "   INEER JOIN estado             es ON (es.id			= cid.id_estado)" +
            "   INNER JOIN consulta          con ON (con.id_paciente		= pac.id)" +
            "   INNER JOIN medico              m ON (m.id			= con.id_medico)" +
            "   where m.id=? AND con.status = 'Marcado'";
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

    public PacienteUsuario PacienteNoMedico(int idMedico, int idPaciente) throws SQLException, ClassNotFoundException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(perfilPaciente);
            stmt.setInt(1, idMedico);
            stmt.setInt(2, idPaciente);
            rs = stmt.executeQuery();
            if (rs.next()) {
                PacienteUsuario pacienteUsuario = new PacienteUsuario();
                Paciente paciente = new Paciente();
                Login login = new Login();
                Endereco endereco = new Endereco();
                Cidade cidade = new Cidade();
                Estado estado = new Estado();
                Consulta consulta = new Consulta();
                Prontuario_cab prontuarioCab = new Prontuario_cab();
                Prontuario_item prontuarioItem = new Prontuario_item();
                
                consulta.setDataHora(rs.getDate("con.datahora"));
                consulta.setId(rs.getInt("con.id"));
                consulta.setIdClinicaEndereco(rs.getInt("con.id_clinica_endereco"));
                consulta.setIdMedico(rs.getInt("con.id_medico"));
                consulta.setIdPaciente(rs.getInt("con.id_paciente"));
                consulta.setObservacao(rs.getString("con.observacao"));
                consulta.setStatus(rs.getString("con.status"));
                
                prontuarioItem.setConsulta(consulta);
                prontuarioItem.setAtestado(rs.getBlob("pitem.atestado"));
                prontuarioItem.setDescricao(rs.getBlob("pitem.descricao"));
                prontuarioItem.setExame(rs.getBlob("pitem.exame"));
                prontuarioItem.setReceita(rs.getBlob("pitem.receita"));
                prontuarioItem.setId(rs.getInt("pitem.id"));
                prontuarioItem.setIdConsulta(rs.getInt("pitem.id_consulta"));
                prontuarioItem.setIdProntuarioCab(rs.getInt("pitem.id_prontuario_cab"));

                
                prontuarioCab.setProntuarioItem(prontuarioItem);                
                prontuarioCab.setId(rs.getInt("pcab.id"));
                prontuarioCab.setIdClinica(rs.getInt("pcab.id_clinica"));
                prontuarioCab.setIdPaciente(rs.getInt("pcab.id_paciente")); 
                
                paciente.setProntuarioCab(prontuarioCab);
                paciente.setCpf(rs.getString("pac.cpf"));
                paciente.setDataNascimento(rs.getDate("pac.data_nascimento"));
                paciente.setId(rs.getInt("pac.id"));
                paciente.setNome(rs.getString("pac.nome"));
                paciente.setSobrenome(rs.getString("pac.sobrenome"));
                paciente.setSexo(rs.getString("pac.sexo"));
                
                login.setEmail(rs.getString("logP.email"));
                login.setId(rs.getInt("logP.id"));
                
                estado.setId(rs.getInt("es.id"));
                estado.setNome(rs.getString("es.nome"));
                estado.setUf(rs.getString("es.uf"));
                
                cidade.setEstado(estado);
                cidade.setId(rs.getInt("cid.id"));
                cidade.setNome(rs.getString("cid.nome"));
                
                endereco.setCidade(cidade);
                endereco.setBairro(rs.getString("endP.bairro"));
                endereco.setCep(rs.getString("endP.cep"));
                endereco.setComplemento(rs.getString("endP.complemento"));
                endereco.setId(rs.getInt("endP.id"));
                endereco.setNumero(rs.getString("endP.numero"));
                endereco.setRua(rs.getString("endP.rua"));
                
                
                pacienteUsuario.setEndereco(endereco);
                pacienteUsuario.setLogin(login);
                pacienteUsuario.setPaciente(paciente);
                
                
                pacienteUsuario.setId(rs.getInt("pusu.id"));
                pacienteUsuario.setTelefone(rs.getString("pusu.telefone"));
                pacienteUsuario.setTelefone2(rs.getString("pusu.telefone2"));
                return pacienteUsuario;
            }
        } finally {
            try {
                con.close();
                stmt.close();
                rs.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
        return null;
    }
    
    public List<PacienteUsuario> ListPacienteNoMedico(int idMedico) throws ClassNotFoundException, SQLException  {
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
                Cidade cidade = new Cidade();
                Estado estado = new Estado();
                Consulta consulta = new Consulta();
                
                consulta.setDataHora(rs.getDate("con.datahora"));
                consulta.setId(rs.getInt("con.id"));
                consulta.setIdClinicaEndereco(rs.getInt("con.id_clinica_endereco"));
                consulta.setIdMedico(rs.getInt("con.id_medico"));
                consulta.setIdPaciente(rs.getInt("con.id_paciente"));
                consulta.setObservacao(rs.getString("con.observacao"));
                consulta.setStatus(rs.getString("con.status"));
                
                paciente.setCpf(rs.getString("pac.cpf"));
                paciente.setDataNascimento(rs.getDate("pac.data_nascimento"));
                paciente.setId(rs.getInt("pac.id"));
                paciente.setNome(rs.getString("pac.nome"));
                paciente.setSobrenome(rs.getString("pac.sobrenome"));
                paciente.setSexo(rs.getString("pac.sexo"));
                
                login.setEmail(rs.getString("logP.email"));
                login.setId(rs.getInt("logP.id"));
                
                estado.setId(rs.getInt("es.id"));
                estado.setNome(rs.getString("es.nome"));
                estado.setUf(rs.getString("es.uf"));
                
                cidade.setEstado(estado);
                cidade.setId(rs.getInt("cid.id"));
                cidade.setNome(rs.getString("cid.nome"));
                
                endereco.setCidade(cidade);
                endereco.setBairro(rs.getString("endP.bairro"));
                endereco.setCep(rs.getString("endP.cep"));
                endereco.setComplemento(rs.getString("endP.complemento"));
                endereco.setId(rs.getInt("endP.id"));
                endereco.setNumero(rs.getString("endP.numero"));
                endereco.setRua(rs.getString("endP.rua"));
                
                
                pacienteUsuario.setEndereco(endereco);
                pacienteUsuario.setLogin(login);
                pacienteUsuario.setPaciente(paciente);
                
                
                pacienteUsuario.setId(rs.getInt("pusu.id"));
                pacienteUsuario.setTelefone(rs.getString("pusu.telefone"));
                pacienteUsuario.setTelefone2(rs.getString("pusu.telefone2"));
                
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
