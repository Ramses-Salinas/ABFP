package com.abfp.gestionUsuarios.ports.out;

import java.util.Map;

public interface GraphQLClientPort {
	Map<String, Object> executeQuery(String query);
}
