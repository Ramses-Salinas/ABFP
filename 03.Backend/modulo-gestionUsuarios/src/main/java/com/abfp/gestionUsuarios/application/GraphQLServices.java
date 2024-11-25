package com.abfp.gestionUsuarios.application;

import java.util.Map;
//import java.text.MessageFormat;

import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.abfp.gestionUsuarios.ports.out.GraphQLClientPort;
import com.abfp.gestionUsuarios.ports.in.GraphQL;

@Service
public class GraphQLServices implements GraphQL{
	
	private final GraphQLClientPort graphQLClientPort;
	private static final Logger logger = LoggerFactory.getLogger(GraphQLServices.class);

    public GraphQLServices(GraphQLClientPort graphQLClientPort) {
        this.graphQLClientPort = graphQLClientPort;
    }

    @Override
    public Map<String, Object> getAllUsers() {
        String query = """
            query {
	            listUsuarios {
	                App
	                Pasword
	                Correo
	                Nombre
	                Resumen
	            }
	        }
        """;
        return graphQLClientPort.executeQuery(query);
    }
    
    @Override
    public Map<String, Object> createUser(String email, String name, String password) {
    	String query = String.format("""
    	        mutation {
    	          crearUsuario(Gmail: "%s", Nombre: "%s", Pasword: "%s") {
    	            App
    	            Pasword
    	            Correo
    	            Nombre
    	            Resumen
    	          }
    	        }
    	    """, email, name, password);
    	logger.info(query);
        return graphQLClientPort.executeQuery(query);
    }
    
    @Override
    public Map<String, Object> updatePassword(String email, String actualPass, String newPass){
    	String query = String.format("""
    	        mutation {
    	          updateUserPassword(ActualPass: "%s", Gmail: "%s", Pasword: "%s") {
				    App
				    Pasword
				    Correo
				    Nombre
				    Resumen
				  }
    	        }
    	    """, actualPass, email, newPass);
    	logger.info(query);
        return graphQLClientPort.executeQuery(query);
    }
    
    @Override
    public Map<String, Object> deleteUser(String email, String password){
    	String query = String.format("""
    	        mutation {
    	          deleteUser(Gmail: "%s", Password: "%s") {
				    App
				    Pasword
				    Correo
				    Nombre
				    Resumen
				  }
    	        }
    	    """, email, password);
    	logger.info(query);
        return graphQLClientPort.executeQuery(query);
    }
}
