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
public class MedicoEspecialidade implements Serializable {
    private int id;
    private int idMedico;
    private int idEspecialidade;

    public MedicoEspecialidade() {
    }

    public MedicoEspecialidade(int id, int idMedico, int idEspecialidade) {
        this.id = id;
        this.idMedico = idMedico;
        this.idEspecialidade = idEspecialidade;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdMedico() {
        return idMedico;
    }

    public void setIdMedico(int idMedico) {
        this.idMedico = idMedico;
    }

    public int getIdEspecialidade() {
        return idEspecialidade;
    }

    public void setIdEspecialidade(int idEspecialidade) {
        this.idEspecialidade = idEspecialidade;
    }
}
