package com.abfp.dashboard.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public class Data {
    @JsonProperty("listTransacciones")
    private List<Transaccion> listTransacciones;

    // Getters y Setters
    public List<Transaccion> getListTransacciones() {
        return listTransacciones;
    }

    public void setListTransacciones(List<Transaccion> listTransacciones) {
        this.listTransacciones = listTransacciones;
    }
}
