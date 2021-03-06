/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Gabriel
 */
public class Paciente implements Serializable {

    private int id;
    private String cpf;
    private String nome;
    private String sobrenome;
    private Date dataNascimento;
    private String sexo;
    private List<ConvenioPaciente> listaConvenios;
    private Prontuario_cab prontuarioCab;

    public Paciente() {
    }

    public Paciente(String cpf, String nome, String sobrenome, Date dataNascimento, String sexo) {
        this.cpf = cpf;
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.dataNascimento = dataNascimento;
        this.sexo = sexo;
    }

    public Paciente(int id, String cpf, String nome, String sobrenome, Date dataNascimento, String sexo) {
        this.id = id;
        this.cpf = cpf;
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.dataNascimento = dataNascimento;
        this.sexo = sexo;
    }
    public Paciente(int id, String cpf, String nome, String sobrenome, Date dataNascimento, String sexo, Prontuario_cab prontuarioCab) {
        this.id = id;
        this.cpf = cpf;
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.dataNascimento = dataNascimento;
        this.sexo = sexo;
        this.prontuarioCab = prontuarioCab;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
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

    public Date getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(Date dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public List<ConvenioPaciente> getListaConvenios() {
        return listaConvenios;
    }

    public void setListaConvenios(List<ConvenioPaciente> listaConvenios) {
        this.listaConvenios = listaConvenios;
    }
    
    public Prontuario_cab getProntuarioCab() {
        return prontuarioCab;
    }

    public void setProntuarioCab(Prontuario_cab prontuarioCab) {
        this.prontuarioCab = prontuarioCab;
    }

}
