package com.abfp.dashboard.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public class DataPresu {
	
    @JsonProperty("listPrecat")
    private List<Categoria> listPrecat;

    // Getters y Setters
    public List<Categoria> getListPrecat() {
        return listPrecat;
    }

    public void setListPrecat(List<Categoria> listPrecat) {
        this.listPrecat = listPrecat;
    }
}
