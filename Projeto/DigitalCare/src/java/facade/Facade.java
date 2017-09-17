/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facade;

import beans.Cidade;
import beans.Endereco;
import beans.Estado;
import beans.Paciente;
import beans.PacienteUsuario;
import daos.CidadeDAO;
import daos.EnderecoDAO;
import daos.EstadoDAO;
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

    
}
