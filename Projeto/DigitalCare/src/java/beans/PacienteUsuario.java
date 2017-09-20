/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.io.Serializable;

/**
 *
 * @author Gabriel
 */
public class PacienteUsuario implements Serializable{
    
    private int id;
    private Paciente paciente;
    private Login login;
    private Endereco endereco;
    private String telefone;
    private String telefone2;

    public PacienteUsuario(Paciente paciente, Login login, Endereco endereco, String telefone, String telefone2) {
        this.paciente = paciente;
        this.login = login;
        this.endereco = endereco;
        this.telefone = telefone;
        this.telefone2 = telefone2;
    }

    public PacienteUsuario() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Paciente getPaciente() {
        return paciente;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    public Login getLogin() {
        return login;
    }

    public void setLogin(Login login) {
        this.login = login;
    }

    public Endereco getEndereco() {
        return endereco;
    }

    public void setEndereco(Endereco endereco) {
        this.endereco = endereco;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getTelefone2() {
        return telefone2;
    }

    public void setTelefone2(String telefone2) {
        this.telefone2 = telefone2;
    }
    
}
