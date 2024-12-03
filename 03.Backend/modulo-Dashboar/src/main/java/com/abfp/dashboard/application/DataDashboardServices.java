package com.abfp.dashboard.application;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.abfp.dashboard.ports.in.DataDashboard;
import com.abfp.dashboard.ports.in.GraphQL;
import com.abfp.dashboard.domain.Response;
import com.abfp.dashboard.domain.ResponsePresu;
import com.abfp.dashboard.domain.Transaccion;
import com.abfp.dashboard.domain.Categoria;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class DataDashboardServices implements DataDashboard{
	
	private final GraphQL graphQL;
	private static final Logger logger = LoggerFactory.getLogger(GraphQLServices.class);
	
	public DataDashboardServices(GraphQL graphQL) {
		this.graphQL=graphQL;
	}
	
	@Override
	public ArrayList<HashMap<String, Object>> getPresupuestoVSGasto(String email) throws JsonMappingException, JsonProcessingException{
		String presupuesto = graphQL.getAllPresupuestoCategoria(email);
		String gasto = graphQL.getAllTransaction(email);
		ArrayList<String> categorias = new ArrayList<>();
		HashMap<String, Double> gastoCategoria = new HashMap<>();
		
		ObjectMapper objectMapper = new ObjectMapper();
		Response responseGasto;
		ResponsePresu responsePresu;
		
			responseGasto = objectMapper.readValue(gasto, Response.class);
			for(Transaccion trans: responseGasto.getData().getListTransacciones()) {
				if(!categorias.contains(trans.getCategoriaTransaccion())) {
					categorias.add(trans.getCategoriaTransaccion());
					gastoCategoria.put(trans.getCategoriaTransaccion(), (double) 0);
				}
			}
			for(Transaccion trans: responseGasto.getData().getListTransacciones()) {
				Double montoActual = gastoCategoria.get(trans.getCategoriaTransaccion());
				gastoCategoria.put(trans.getCategoriaTransaccion(), montoActual+trans.getMonto());
			}
			responsePresu = objectMapper.readValue(presupuesto, ResponsePresu.class);
			ArrayList<HashMap<String, Object>> semiResponse = new ArrayList<>();
			HashMap<String, Object> map = new HashMap<>();
			for(Categoria cate: responsePresu.getData().getListPrecat()) {
				map.put("nombre", cate.getNombreCategoria());
				map.put("presupuesto", cate.getCategoriaMensual());
				if(gastoCategoria.containsKey(cate.getNombreCategoria())) {
					map.put("gasto", gastoCategoria.get(cate.getNombreCategoria()));
				}else {
					map.put("gasto", 0);
				}
				semiResponse.add(map);
			}
			return semiResponse;
		
		

	}
}
