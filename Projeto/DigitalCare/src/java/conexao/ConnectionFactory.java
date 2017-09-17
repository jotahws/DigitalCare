/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conexao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 *
 * @author MauMau
 */
public class ConnectionFactory {

    public Connection getConnection() throws ClassNotFoundException {
        try {
            //quem chamou o metodo terá que tratar a exception
            Properties prop = new Properties();
            prop.load(getClass().getResourceAsStream("/conecao/bancoDados.properties"));
            String url = prop.getProperty("url");
            String usuario = prop.getProperty("usuario");
            String senha = prop.getProperty("senha");
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, usuario, senha);
            return con;
        } catch (IOException ex) {
            throw new RuntimeException("Problemas no arquivo .properties: \n" + ex.getMessage());
        } catch (SQLException ex) {
            throw new RuntimeException("Problemas no Banco de Dados: \n" + ex.getMessage());
        }
    }
}

