/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

import beans.Medico;
import com.google.gson.annotations.Expose;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Gabriel
 */
public class HorarioDisponivelDTO {
    
    @Expose
    private Date horario;
    @Expose
    private List<ConsultaDisponivelDTO> listaConsultasDisponiveis;

    public HorarioDisponivelDTO() {
        this.listaConsultasDisponiveis = new ArrayList();
    }

    public Date getHorario() {
        return horario;
    }

    public void setHorario(Date horario) {
        this.horario = horario;
    }

    public List<ConsultaDisponivelDTO> getListaConsultasDisponiveis() {
        return listaConsultasDisponiveis;
    }
    
    public ConsultaDisponivelDTO getConsultaDisponivelPorMedico(Medico medico){
        for (ConsultaDisponivelDTO c : listaConsultasDisponiveis)
            if (c.getMedico().equals(medico))
                return c;
        return null;
    }

    public void setListaConsultasDisponiveis(List<ConsultaDisponivelDTO> listaConsultasDisponiveis) {
        this.listaConsultasDisponiveis = listaConsultasDisponiveis;
    }
    
    
}
