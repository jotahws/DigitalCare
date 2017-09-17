/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facade;

import beans.Cidade;
import beans.Estado;
import beans.PacienteUsuario;
import daos.CidadeDAO;
import daos.EstadoDAO;
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


    
}
