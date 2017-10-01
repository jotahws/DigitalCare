/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author Gabriel
 */
public class Medico implements Serializable{
    
    private int id;
    private Login login;
    private Estado estadoCrm;
    private String numeroCrm;
    private String nome;
    private String sobrenome;
    private String cpf;
    private Double precoConsulta;
    private Date dataNascimento;
    private String telefone1;
    private String telefone2;
    private Double avaliacao;

    public Medico() {
    }

    public Medico(Login login, Estado estadoCrm, String numeroCrm, String nome, String sobrenome, String cpf, Date dataNascimento) {
        this.login = login;
        this.estadoCrm = estadoCrm;
        this.numeroCrm = numeroCrm;
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.cpf = cpf;
        this.dataNascimento = dataNascimento;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Login getLogin() {
        return login;
    }

    public void setLogin(Login login) {
        this.login = login;
    }

    public Estado getEstadoCrm() {
        return estadoCrm;
    }

    public void setEstadoCrm(Estado estadoCrm) {
        this.estadoCrm = estadoCrm;
    }

    public String getNumeroCrm() {
        return numeroCrm;
    }

    public void setNumeroCrm(String numeroCrm) {
        this.numeroCrm = numeroCrm;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSobrenome() {
        return sobrenome;
    }

    public void setSobrenome(String sobrenome) {
        this.sobrenome = sobrenome;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public Double getPrecoConsulta() {
        return precoConsulta;
    }

    public void setPrecoConsulta(Double precoConsulta) {
        this.precoConsulta = precoConsulta;
    }

    public Date getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(Date dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    public String getTelefone1() {
        return telefone1;
    }

    public void setTelefone1(String telefone1) {
        this.telefone1 = telefone1;
    }

    public String getTelefone2() {
        return telefone2;
    }

    public void setTelefone2(String telefone2) {
        this.telefone2 = telefone2;
    }

    public Double getAvaliacao() {
        return avaliacao;
    }

    public void setAvaliacao(Double avaliacao) {
        this.avaliacao = avaliacao;
    }
    
}
