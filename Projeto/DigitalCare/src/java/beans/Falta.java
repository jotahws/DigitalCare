/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.io.Serializable;
import java.util.Calendar;


/**
 *
 * @author joao.wind
 */
public class Falta implements Serializable{
    private int id;
    private Medico medico;
    private Calendar dataInicio;
    private Calendar dataFim;

    public Falta() {
    }

    public Falta(int id, Medico medico, Calendar dataInicio, Calendar dataFim) {
        this.id = id;
        this.medico = medico;
        this.dataInicio = dataInicio;
        this.dataFim = dataFim;
    }

    public Falta(Medico medico, Calendar dataInicio, Calendar dataFim) {
        this.medico = medico;
        this.dataInicio = dataInicio;
        this.dataFim = dataFim;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Medico getMedico() {
        return medico;
    }

    public void setMedico(Medico medico) {
        this.medico = medico;
    }

    public Calendar getDataInicio() {
        return dataInicio;
    }

    public void setDataInicio(Calendar dataInicio) {
        this.dataInicio = dataInicio;
    }

    public Calendar getDataFim() {
        return dataFim;
    }

    public void setDataFim(Calendar dataFim) {
        this.dataFim = dataFim;
    }
    
}
