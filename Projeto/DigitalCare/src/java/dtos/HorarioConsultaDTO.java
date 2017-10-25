/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

import beans.Consulta;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Gabriel
 */
public class HorarioConsultaDTO {
    
    private Date dataHora;
    private List<Consulta> listaConsultas;
    private List<HorarioVagoDTO> listaHorariosDisponiveis;

    public HorarioConsultaDTO() {
    }

    public Date getDataHora() {
        return dataHora;
    }

    public void setDataHora(Date dataHora) {
        this.dataHora = dataHora;
    }

    public List<Consulta> getListaConsultas() {
        return listaConsultas;
    }

    public void setListaConsultas(List<Consulta> listaConsultas) {
        this.listaConsultas = listaConsultas;
    }

    public List<HorarioVagoDTO> getListaHorariosDisponiveis() {
        return listaHorariosDisponiveis;
    }

    public void setListaHorariosDisponiveis(List<HorarioVagoDTO> listaHorariosDisponiveis) {
        this.listaHorariosDisponiveis = listaHorariosDisponiveis;
    }
    
    
}
