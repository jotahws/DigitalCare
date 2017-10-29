/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

import com.google.gson.annotations.Expose;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Gabriel
 */
public class DiaDisponivelDTO {
    
    @Expose
    private Date dia;
    @Expose
    private List<HorarioDisponivelDTO> listaHorariosDisponiveis;

    public DiaDisponivelDTO() {
        this.listaHorariosDisponiveis = new ArrayList();
    }

    public Date getDia() {
        return dia;
    }

    public void setDia(Date dia) {
        this.dia = dia;
    }

    public List<HorarioDisponivelDTO> getListaHorariosDisponiveis() {
        return listaHorariosDisponiveis;
    }
    
    public HorarioDisponivelDTO getDtoPorHorario(Date hr){
        for (HorarioDisponivelDTO h : listaHorariosDisponiveis)
            if (h.getHorario().equals(hr))
                return h;
        return null;
    }

    public void setListaHorariosDisponiveis(List<HorarioDisponivelDTO> listaHorariosDisponiveis) {
        this.listaHorariosDisponiveis = listaHorariosDisponiveis;
    }
    
    
}
