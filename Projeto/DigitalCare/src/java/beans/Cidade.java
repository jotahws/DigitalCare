


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import com.google.gson.annotations.Expose;
import java.io.Serializable;

/**
 *
 * @author Gabriel
 */
public class Cidade implements Serializable{
    
    @Expose
    private int id;
    private Estado estado;
    @Expose
    private String nome;

    public Cidade(int id, Estado estado, String nome) {
        this.id = id;
        this.estado = estado;
        this.nome = nome;
    }

    public Cidade() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Estado getEstado() {
        return estado;
    }

    public void setEstado(Estado estado) {
        this.estado = estado;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
    
}
