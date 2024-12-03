package com.abfp.dashboard.adapters.in;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.abfp.dashboard.ports.in.GraphQL;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.abfp.dashboard.ports.in.DataDashboard;

@RestController
@CrossOrigin
@RequestMapping("/dashboard")
public class DashboardController {
	private final DataDashboard dataD;
		
	public DashboardController(GraphQL graphQL, DataDashboard dataD) {
		this.dataD = dataD;
	}
	
	@GetMapping("/presuVSGasto")
	public ResponseEntity<?> getPresupuestoVSGasto(@RequestBody Map<String, String> request) {
		String email = request.get("email");
		ArrayList<HashMap<String, Object>> response;
		try {
			response = dataD.getPresupuestoVSGasto(email);
			return new ResponseEntity<>(response,HttpStatus.OK);
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ResponseEntity<>("Error",HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
