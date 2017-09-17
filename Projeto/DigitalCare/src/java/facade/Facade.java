/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facade;

import beans.Cidade;
import beans.Estado;
import beans.PacienteUsuario;
import daos.EstadoDAO;
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

    public Cidade getCidadePorId(int id) {
//        CidadeDAO dao = new CidadeDAO();
//        return dao.getCidadePorId(id);
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public void inserirPaciente(PacienteUsuario pacienteUsuario) {
//        PacienteUsuarioDAO dao = new PacienteUsuarioDAO();
//        dao.inserirPaciente(pacienteUsuario);
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }


    
}
