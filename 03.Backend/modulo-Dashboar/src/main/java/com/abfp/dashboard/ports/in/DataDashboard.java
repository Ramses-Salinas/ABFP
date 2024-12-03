package com.abfp.dashboard.ports.in;

import java.util.ArrayList;
import java.util.HashMap;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

public interface DataDashboard {
	public ArrayList<HashMap<String, Object>> getPresupuestoVSGasto(String email) throws JsonMappingException, JsonProcessingException;
}
