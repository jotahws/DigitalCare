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
 * @author Mauricio
 */
public class Consulta implements Serializable {

    private int id;
    private int idMedico;
    private int idPaciente;
    private int idClinicaEndereco;
    private Date dataHora;
    private String status;
    private String observacao;
    private Medico medico;
    private Paciente paciente;
    private PacienteUsuario pacienteUsuario;
    private ClinicaEndereco clinicaEndereco;

    public Consulta(int id, int idMedico, int idPaciente, int idClinicaEndereco, Date dataHora, String status, String observacao, Medico medico, Paciente paciente) {
        this.id = id;
        this.idMedico = idMedico;
        this.idPaciente = idPaciente;
        this.idClinicaEndereco = idClinicaEndereco;
        this.dataHora = dataHora;
        this.status = status;
        this.observacao = observacao;
        this.medico = medico;
        this.paciente = paciente;
    }

    public Consulta(int id, Date dataHora, String status, Medico medico, Paciente paciente, ClinicaEndereco clinicaEndereco) {
        this.id = id;
        this.dataHora = dataHora;
        this.status = status;
        this.medico = medico;
        this.paciente = paciente;
        this.clinicaEndereco = clinicaEndereco;
    }

    public Consulta(Date dataHora, String status, Medico medico, Paciente paciente, ClinicaEndereco clinicaEndereco) {
        this.dataHora = dataHora;
        this.status = status;
        this.medico = medico;
        this.paciente = paciente;
        this.clinicaEndereco = clinicaEndereco;
    }
    
    public ClinicaEndereco getClinicaEndereco() {
        return clinicaEndereco;
    }

    public void setClinicaEndereco(ClinicaEndereco clinicaEndereco) {
        this.clinicaEndereco = clinicaEndereco;
    }

    public Consulta(String status) {
        this.status = status;
    }

    public Consulta() {}

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

    public int getIdPaciente() {
        return idPaciente;
    }

    public void setIdPaciente(int idPaciente) {
        this.idPaciente = idPaciente;
    }

    public int getIdClinicaEndereco() {
        return idClinicaEndereco;
    }

    public void setIdClinicaEndereco(int idClinicaEndereco) {
        this.idClinicaEndereco = idClinicaEndereco;
    }

    public Date getDataHora() {
        return dataHora;
    }

    public void setDataHora(Date dataHora) {
        this.dataHora = dataHora;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    public Medico getMedico() {
        return medico;
    }

    public void setMedico(Medico medico) {
        this.medico = medico;
    }

    public Paciente getPaciente() {
        return paciente;
    }

    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    public PacienteUsuario getPacienteUsuario() {
        return pacienteUsuario;
    }

    public void setPacienteUsuario(PacienteUsuario pacienteUsuario) {
        this.pacienteUsuario = pacienteUsuario;
    }

}
