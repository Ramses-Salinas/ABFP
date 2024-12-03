package com.abfp.dashboard.ports.in;

import java.util.ArrayList;
import java.util.Map;

public interface GraphQL {
	String getAllPresupuestoCategoria(String email);
	String getAllTransaction(String email);
}
