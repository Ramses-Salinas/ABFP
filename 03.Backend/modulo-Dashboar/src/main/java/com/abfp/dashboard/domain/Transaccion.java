package com.abfp.dashboard.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public class Transaccion {
    @JsonProperty("categoria_transaccion")
    private String categoriaTransaccion;

    @JsonProperty("fecha")
    private String fecha;

    @JsonProperty("monto")
    private int monto;

    @JsonProperty("nota")
    private String nota;

    @JsonProperty("tipo_moneda")
    private String tipoMoneda;

    @JsonProperty("tipo_transaccion")
    private String tipoTransaccion;

    // Getters y Setters
    public String getCategoriaTransaccion() {
        return categoriaTransaccion;
    }

    public void setCategoriaTransaccion(String categoriaTransaccion) {
        this.categoriaTransaccion = categoriaTransaccion;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public int getMonto() {
        return monto;
    }

    public void setMonto(int monto) {
        this.monto = monto;
    }

    public String getNota() {
        return nota;
    }

    public void setNota(String nota) {
        this.nota = nota;
    }

    public String getTipoMoneda() {
        return tipoMoneda;
    }

    public void setTipoMoneda(String tipoMoneda) {
        this.tipoMoneda = tipoMoneda;
    }

    public String getTipoTransaccion() {
        return tipoTransaccion;
    }

    public void setTipoTransaccion(String tipoTransaccion) {
        this.tipoTransaccion = tipoTransaccion;
    }
}
