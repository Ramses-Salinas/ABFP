package com.abfp.dashboard.application;

import java.util.ArrayList;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.abfp.dashboard.ports.in.GraphQL;
import com.abfp.dashboard.ports.out.GraphQLClientPort;

@Service
public class GraphQLServices implements GraphQL{
	
	private final GraphQLClientPort graphQLClientPort;
	private static final Logger logger = LoggerFactory.getLogger(GraphQLServices.class);

    public GraphQLServices(GraphQLClientPort graphQLClientPort) {
        this.graphQLClientPort = graphQLClientPort;
    }
	
	@Override
	public String getAllPresupuestoCategoria(String email){
		String query = String.format("""
    	        query {
				  listPrecat(Gmail: "%s") {
				    Nombre_categoria
				    Categoria_mensual
				    Categoria_semestral
				    Categoria_anual
				    Id_categoria
				    Gmail
				  }
				}
    	    """, email);
    	logger.info(query);
    	logger.info(graphQLClientPort.executeQueryString(query));
        return graphQLClientPort.executeQueryString(query);
	}
	
	@Override
	public String getAllTransaction(String email){
		String query = String.format("""
    	        query {
				    listTransacciones(gmail: "%s") {
				        categoria_transaccion
				        fecha
				        monto
				        nota
				        tipo_moneda
				        tipo_transaccion
				    }
				}
    	    """, email);
    	logger.info(query);
    	logger.info(graphQLClientPort.executeQueryString(query));
        return graphQLClientPort.executeQueryString(query);
	}
}
