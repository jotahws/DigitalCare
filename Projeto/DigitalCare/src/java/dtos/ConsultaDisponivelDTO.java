/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

import beans.ClinicaEndereco;
import beans.Medico;
import com.google.gson.annotations.Expose;
import java.util.Date;

/**
 *
 * @author Gabriel
 */
public class ConsultaDisponivelDTO {
    
    @Expose
    private Medico medico;
    @Expose
    private ClinicaEndereco clinica;

    public ConsultaDisponivelDTO() {
    }

    public Medico getMedico() {
        return medico;
    }

    public void setMedico(Medico medico) {
        this.medico = medico;
    }

    public ClinicaEndereco getClinica() {
        return clinica;
    }

    public void setClinica(ClinicaEndereco clinica) {
        this.clinica = clinica;
    }
    
}
