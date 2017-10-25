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
 * @author JotaWind
 */
public class MedicoHorario implements Serializable {

    private int id;
    private int diaSemana;
    private Date horaInicio;
    private Date horaFim;
    private Medico medico;
    private ClinicaEndereco clinicaEndereco;

    public MedicoHorario() {
    }

    public MedicoHorario(int diaSemana, Date horaInicio, Date horaFim, Medico medico, ClinicaEndereco clinicaEndereco) {
        this.diaSemana = diaSemana;
        this.horaInicio = horaInicio;
        this.horaFim = horaFim;
        this.medico = medico;
        this.clinicaEndereco = clinicaEndereco;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getDiaSemana() {
        return diaSemana;
    }

    public void setDiaSemana(int diaSemana) {
        this.diaSemana = diaSemana;
    }

    public Date getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(Date horaInicio) {
        this.horaInicio = horaInicio;
    }

    public Date getHoraFim() {
        return horaFim;
    }

    public void setHoraFim(Date horaFim) {
        this.horaFim = horaFim;
    }

    public Medico getMedico() {
        return medico;
    }

    public void setMedico(Medico medico) {
        this.medico = medico;
    }

    public ClinicaEndereco getClinicaEndereco() {
        return clinicaEndereco;
    }

    public void setClinicaEndereco(ClinicaEndereco clinicaEndereco) {
        this.clinicaEndereco = clinicaEndereco;
    }

}
