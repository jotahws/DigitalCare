/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import com.google.gson.annotations.Expose;
import java.util.List;

/**
 *
 * @author Gabriel
 */
public class Clinica {
    
    @Expose    
    private int id;
    private Login login;
    private String cnpj;
    private String razaoSocial;
    @Expose
    private String nomeFantasia;
    @Expose
    private String site;
    private Double avaliacao;
    private List<ClinicaEndereco> listaEnderecos;

    public Clinica() {
    }

    public Clinica(Login login, String cnpj, String razaoSocial, String nomeFantasia, String site) {
        this.login = login;
        this.cnpj = cnpj;
        this.razaoSocial = razaoSocial;
        this.nomeFantasia = nomeFantasia;
        this.site = site;
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

    public String getCnpj() {
        return cnpj;
    }

    public void setCnpj(String cnpj) {
        this.cnpj = cnpj;
    }

    public String getRazaoSocial() {
        return razaoSocial;
    }

    public void setRazaoSocial(String razaoSocial) {
        this.razaoSocial = razaoSocial;
    }

    public String getNomeFantasia() {
        return nomeFantasia;
    }

    public void setNomeFantasia(String nomeFantasia) {
        this.nomeFantasia = nomeFantasia;
    }

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site;
    }

    public Double getAvaliacao() {
        return avaliacao;
    }

    public void setAvaliacao(Double avaliacao) {
        this.avaliacao = avaliacao;
    }

    public List<ClinicaEndereco> getListaEnderecos() {
        return listaEnderecos;
    }

    public void setListaEnderecos(List<ClinicaEndereco> listaEnderecos) {
        this.listaEnderecos = listaEnderecos;
    }    
}
