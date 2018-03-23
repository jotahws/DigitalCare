/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.io.Serializable;
import java.sql.Blob;

/**
 *
 * @author Mauricio
 */
public class Prontuario implements Serializable {
    private int id;
    private int idConsulta;
    private Consulta consulta;
    private Blob atestado;
    private Blob receita;
    private Blob exame;
    private Blob descricao;

    public Prontuario(int id, int idProntuarioCab, int idConsulta, Consulta consulta, Blob atestado, Blob receita, Blob exame, Blob descricao) {
        this.id = id;
        this.idConsulta = idConsulta;
        this.consulta = consulta;
        this.atestado = atestado;
        this.receita = receita;
        this.exame = exame;
        this.descricao = descricao;
    }

    public Prontuario() {
        }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdConsulta() {
        return idConsulta;
    }

    public void setIdConsulta(int idConsulta) {
        this.idConsulta = idConsulta;
    }

    public Consulta getConsulta() {
        return consulta;
    }

    public void setConsulta(Consulta consulta) {
        this.consulta = consulta;
    }

    public Blob getAtestado() {
        return atestado;
    }

    public void setAtestado(Blob atestado) {
        this.atestado = atestado;
    }

    public Blob getReceita() {
        return receita;
    }

    public void setReceita(Blob receita) {
        this.receita = receita;
    }

    public Blob getExame() {
        return exame;
    }

    public void setExame(Blob exame) {
        this.exame = exame;
    }

    public Blob getDescricao() {
        return descricao;
    }

    public void setDescricao(Blob descricao) {
        this.descricao = descricao;
    }
    
    
}
