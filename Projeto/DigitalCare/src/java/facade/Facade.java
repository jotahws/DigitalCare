/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facade;

import beans.Cidade;
import beans.Clinica;
import beans.ClinicaEndereco;
import beans.Endereco;
import beans.Estado;
import beans.Login;
import beans.Medico;
import beans.MedicoEspecialidade;
import beans.Paciente;
import beans.PacienteUsuario;
import daos.CidadeDAO;
import daos.ClinicaDAO;
import daos.ClinicaEnderecoDAO;
import daos.EnderecoDAO;
import daos.EstadoDAO;
import daos.LoginDAO;
import daos.MedicoDAO;
import daos.PacienteDAO;
import daos.PacienteUsuarioDAO;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author JotaWind
 */
public class Facade {

    public List<Estado> listarEstados() throws ClassNotFoundException, SQLException {
        EstadoDAO dao = new EstadoDAO();
        return dao.listarEstados();
    }

    public Cidade getCidadePorId(int id) throws ClassNotFoundException, SQLException {
        CidadeDAO dao = new CidadeDAO();
        return dao.buscarCidade(id);
    }

    public Cidade getCidadePorNome(String nome) throws ClassNotFoundException, SQLException {
        CidadeDAO dao = new CidadeDAO();
        return dao.buscarCidadeNome(nome);
    }
    public void inserirPacienteUsuario(PacienteUsuario pacienteUsuario) throws ClassNotFoundException, SQLException {
        PacienteUsuarioDAO dao = new PacienteUsuarioDAO();
        dao.inserirPacienteUsuario(pacienteUsuario);
    }

    public static int inserirEndereco(Endereco endereco) throws ClassNotFoundException, SQLException {
        EnderecoDAO enderecoDAO = new EnderecoDAO();
        return enderecoDAO.inserirEndereco(endereco);
    }

    public static int inserirPaciente(Paciente paciente) throws ClassNotFoundException, SQLException {
        PacienteDAO pacienteDAO = new PacienteDAO();
        return pacienteDAO.inserirPaciente(paciente);
    }

    public static int inserirLogin(Login login) throws ClassNotFoundException, SQLException {
        LoginDAO loginDAO = new LoginDAO();
        return loginDAO.inserirLogin(login);
    }
    
    public static int inserirClinica(Clinica clinica) throws ClassNotFoundException, SQLException{
        ClinicaDAO clinicaDAO = new ClinicaDAO();
        return clinicaDAO.inserirClinica(clinica);
    }
    
    public void inserirClinicaEndereco(ClinicaEndereco clinicaEndereco) throws ClassNotFoundException, SQLException {
        ClinicaEnderecoDAO clinicaEnderecoDAO = new ClinicaEnderecoDAO();
        clinicaEnderecoDAO.inserirClinicaEndereco(clinicaEndereco);
    }

    public Login verificaLogin(Login login) throws ClassNotFoundException, SQLException {
        LoginDAO loginDAO = new LoginDAO();
        return loginDAO.buscarLogin(login);
    }
    public PacienteUsuario getPacientePorIdLogin(int id) throws ClassNotFoundException, SQLException {
        PacienteUsuarioDAO pacUsuarioDAO = new PacienteUsuarioDAO();
        return pacUsuarioDAO.buscaPacientePorIdLogin(id);
    }

    
    public static Estado buscarEstadoPorId(int id) throws ClassNotFoundException, SQLException {
        EstadoDAO estadoDAO = new EstadoDAO();
        return estadoDAO.buscarEstadoPorId(id);
    }
    
    public static int inserirMedico(Medico medico) throws ClassNotFoundException, SQLException{
        MedicoDAO medicoDAO = new MedicoDAO();
        return medicoDAO.inserirMedico(medico);
    }
    
    public static int BuscarIdMedicoPorLogin(int idLogin) throws ClassNotFoundException, SQLException{
        MedicoDAO medicoDAO = new MedicoDAO();
        return medicoDAO.buscarIdMedicoPorLogin(idLogin);
    }
    
    public static void atualizarMedico(Medico medico) throws ClassNotFoundException, SQLException{
        MedicoDAO medicoDAO = new MedicoDAO();
        medicoDAO.atualizarMedico(medico);
    }
    
    public static List<MedicoEspecialidade> buscarMedicoEspecialidade(int idMedico) throws ClassNotFoundException, SQLException{
        MedicoDAO medicoDAO = new MedicoDAO();
        return medicoDAO.buscarMedicoEspecialidade(idMedico);
    }
    
    public static void deletarMedicoEspecialidade(int idEspecialidade, int idMedico) throws ClassNotFoundException, SQLException{
        MedicoDAO medicoDAO = new MedicoDAO();
        medicoDAO.deletarMedicoEspecialidade(idEspecialidade, idMedico);
    }
    
    public static void inserirMedicoEspecialidade(int idEspecialidade, int idMedico) throws SQLException, ClassNotFoundException{
        MedicoDAO medicoDAO = new MedicoDAO();
        medicoDAO.inserirMedicoEspecialidade(idEspecialidade, idMedico);
    }
}
