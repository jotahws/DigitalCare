/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

/**
 *
 * @author Mauricio
 */
public class Prontuario_cab {
    private int id;
    private int idPaciente;
    private int idClinica;
    private Paciente paciente;
    private Clinica clinica;

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the id_paciente
     */
    public int getIdPaciente() {
        return idPaciente;
    }

    /**
     * @param id_paciente the id_paciente to set
     */
    public void setIdPaciente(int id_paciente) {
        this.idPaciente = id_paciente;
    }

    /**
     * @return the id_clinica
     */
    public int getIdClinica() {
        return idClinica;
    }

    /**
     * @param id_clinica the id_clinica to set
     */
    public void setIdClinica(int id_clinica) {
        this.idClinica = id_clinica;
    }

    /**
     * @return the paciente
     */
    public Paciente getPaciente() {
        return paciente;
    }

    /**
     * @param paciente the paciente to set
     */
    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }

    /**
     * @return the clinica
     */
    public Clinica getClinica() {
        return clinica;
    }

    /**
     * @param clinica the clinica to set
     */
    public void setClinica(Clinica clinica) {
        this.clinica = clinica;
    }
}
