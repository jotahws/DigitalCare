/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facade;

import beans.Estado;
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
    
}
