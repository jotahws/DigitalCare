/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author Gabriel
 */
public class Login implements Serializable {

    private int id;
    private String email;
    private String senha;
    private int perfil;  //1 - Paciente; 2 - Clinica; 3 - Médico

    public Login(String email, String senha, int perfil) {
        this.email = email;
        this.senha = senha;
        this.perfil = perfil;
    }

    public Login() {
    }

    public Login(String email) {
        this.email = email;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public int getPerfil() {
        return perfil;
    }

    public void setPerfil(int perfil) {
        this.perfil = perfil;
    }

    public String criptografa(String senha) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        
        MessageDigest algorithm = MessageDigest.getInstance("SHA-256");
        byte messageDigest[] = algorithm.digest(senha.getBytes("UTF-8"));

        StringBuilder hexString = new StringBuilder();
        for (byte b : messageDigest) {
            hexString.append(String.format("%02X", 0xFF & b));
        }
        senha = hexString.toString();
        
        return senha;
    }
    
    public boolean verificaLogado (int perfil){
        return true;
    }
}
