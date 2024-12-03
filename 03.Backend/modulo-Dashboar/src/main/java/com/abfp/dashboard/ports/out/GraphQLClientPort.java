package com.abfp.dashboard.ports.out;

import java.util.ArrayList;
import java.util.Map;

public interface GraphQLClientPort {
	Map<String, Object> executeQuery(String query);
	String executeQueryString(String query);
}
