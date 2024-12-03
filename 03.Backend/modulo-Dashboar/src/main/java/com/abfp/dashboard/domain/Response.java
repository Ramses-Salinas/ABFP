package com.abfp.dashboard.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public class Response {
    @JsonProperty("data")
    private Data data;

    // Getters y Setters
    public Data getData() {
        return data;
    }

    public void setData(Data data) {
        this.data = data;
    }
}
