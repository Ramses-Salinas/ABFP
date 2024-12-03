package com.abfp.dashboard.domain;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ResponsePresu {
	
    @JsonProperty("data")
    private DataPresu data;

    // Getters y Setters
    public DataPresu getData() {
        return data;
    }

    public void setData(DataPresu data) {
        this.data = data;
    }
}

