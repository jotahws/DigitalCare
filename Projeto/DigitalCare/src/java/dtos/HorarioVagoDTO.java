/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

import beans.ClinicaEndereco;
import beans.Medico;

/**
 *
 * @author Gabriel
 */
public class HorarioVagoDTO {
    
    private Medico medico;
    private ClinicaEndereco clinicaEndereco;

    public HorarioVagoDTO() {
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
