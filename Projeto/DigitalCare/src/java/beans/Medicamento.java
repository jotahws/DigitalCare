/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.io.Serializable;

/**
 *
 * @author JotaWind
 */
public class Medicamento implements Serializable{
    private int id;
    private String nome;
    private String principioAtivo;
    private String ean;

    public Medicamento() {
    }

    public Medicamento(int id, String nome, String principioAtivo, String ean) {
        this.id = id;
        this.nome = nome;
        this.principioAtivo = principioAtivo;
        this.ean = ean;
    }

    public Medicamento(int id, String nome) {
        this.id = id;
        this.nome = nome;
    }

    public Medicamento(String nome) {
        this.nome = nome;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getPrincipioAtivo() {
        return principioAtivo;
    }

    public void setPrincipioAtivo(String principioAtivo) {
        this.principioAtivo = principioAtivo;
    }

    public String getEan() {
        return ean;
    }

    public void setEan(String ean) {
        this.ean = ean;
    }
    
    
}
