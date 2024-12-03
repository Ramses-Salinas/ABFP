package com.abfp.dashboard.domain;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Categoria {
    @JsonProperty("Nombre_categoria")
    private String nombreCategoria;

    @JsonProperty("Categoria_mensual")
    private int categoriaMensual;

    @JsonProperty("Categoria_semestral")
    private int categoriaSemestral;

    @JsonProperty("Categoria_anual")
    private int categoriaAnual;

    @JsonProperty("Id_categoria")  // Añadido para deserializar "Id_categoria"
    private int idCategoria;

    @JsonProperty("Gmail")  // Añadido para deserializar "Gmail"
    private String gmail;

    // Getters y Setters
    public String getNombreCategoria() {
        return nombreCategoria;
    }

    public void setNombreCategoria(String nombreCategoria) {
        this.nombreCategoria = nombreCategoria;
    }

    public int getCategoriaMensual() {
        return categoriaMensual;
    }

    public void setCategoriaMensual(int categoriaMensual) {
        this.categoriaMensual = categoriaMensual;
    }

    public int getCategoriaSemestral() {
        return categoriaSemestral;
    }

    public void setCategoriaSemestral(int categoriaSemestral) {
        this.categoriaSemestral = categoriaSemestral;
    }

    public int getCategoriaAnual() {
        return categoriaAnual;
    }

    public void setCategoriaAnual(int categoriaAnual) {
        this.categoriaAnual = categoriaAnual;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public String getGmail() {
        return gmail;
    }

    public void setGmail(String gmail) {
        this.gmail = gmail;
    }
}
