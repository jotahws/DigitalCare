/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.io.Serializable;
import java.sql.Time;
import java.util.Date;

/**
 *
 * @author JotaWind
 */
public class HorarioDisponivel implements Serializable {

    private int id;
    private int diaSemana;
    private Time horaInicio;
    private Time horaFim;
    private Medico medico;
    private ClinicaEndereco clinicaEndereco;

    public HorarioDisponivel() {
    }

    public HorarioDisponivel(int diaSemana, Time horaInicio, Time horaFim, Medico medico, ClinicaEndereco clinicaEndereco) {
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

    public Time getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(Time horaInicio) {
        this.horaInicio = horaInicio;
    }

    public Time getHoraFim() {
        return horaFim;
    }

    public void setHoraFim(Time horaFim) {
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
