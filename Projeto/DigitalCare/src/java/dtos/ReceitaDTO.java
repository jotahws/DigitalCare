/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dtos;

/**
 *
 * @author joao.wind
 */
public class ReceitaDTO {
    private String dose;
    private String via;
    private String quantidade;
    private String medicamento;

    public ReceitaDTO() {
    }

    public ReceitaDTO(String dose, String via, String quantidade, String medicamento) {
        this.dose = dose;
        this.via = via;
        this.quantidade = quantidade;
        this.medicamento = medicamento;
    }

    public String getDose() {
        return dose;
    }

    public void setDose(String dose) {
        this.dose = dose;
    }

    public String getVia() {
        return via;
    }

    public void setVia(String via) {
        this.via = via;
    }

    public String getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(String quantidade) {
        this.quantidade = quantidade;
    }

    public String getMedicamento() {
        return medicamento;
    }

    public void setMedicamento(String medicamento) {
        this.medicamento = medicamento;
    }
    
}
