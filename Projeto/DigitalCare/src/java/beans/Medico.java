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
public class Medico implements Serializable {

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
    private List<Especialidade> listaEspecialidades;
    private List<Convenio> listaConvenios;
    private List<ClinicaEndereco> listaClinicaEndereco;
    private List<HorarioDisponivel> listaHorarios;
    private String idade;
    private Consulta consulta;

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

    public Medico(int id, String nome, String sobrenome, Double precoConsulta, Date dataNascimento, String telefone1, String telefone2) {
        this.id = id;
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.precoConsulta = precoConsulta;
        this.dataNascimento = dataNascimento;
        this.telefone1 = telefone1;
        this.telefone2 = telefone2;
    }

    public Medico(String nome, String cpf, String idade) {
        this.nome = nome;
        this.cpf = cpf;
        this.idade = idade;
    }

    public Medico(String nome, String cpf, String idade, Consulta consulta, Login login) {
        this.nome = nome;
        this.idade = idade;
        this.consulta = consulta;
        this.login = login;
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

    public List<Especialidade> getListaEspecialidades() {
        return listaEspecialidades;
    }

    public void setListaEspecialidades(List<Especialidade> listaEspecialidades) {
        this.listaEspecialidades = listaEspecialidades;
    }

    public List<Convenio> getListaConvenios() {
        return listaConvenios;
    }

    public void setListaConvenios(List<Convenio> listaConvenios) {
        this.listaConvenios = listaConvenios;
    }

    public void setIdade(String idade) {
        this.idade = idade;
    }

    public void setConsulta(Consulta consulta) {
        this.consulta = consulta;
    }

    public List<ClinicaEndereco> getListaClinicaEndereco() {
        return listaClinicaEndereco;
    }

    public void setListaClinicaEndereco(List<ClinicaEndereco> listaClinicaEndereco) {
        this.listaClinicaEndereco = listaClinicaEndereco;
    }

    public List<HorarioDisponivel> getListaHorarios() {
        return listaHorarios;
    }

    public void setListaHorarios(List<HorarioDisponivel> listaHorarios) {
        this.listaHorarios = listaHorarios;
    }

}
