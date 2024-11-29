package com.abfp.gestionUsuarios.adapters.in;

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

import com.abfp.gestionUsuarios.ports.in.GraphQL;

@RestController
@CrossOrigin
@RequestMapping("/users")
public class UserController {
	
	private final GraphQL graphQL;
	
	public UserController(GraphQL graphQL) {
		this.graphQL = graphQL;
	}
	
	@GetMapping("/allUsers")
	public ResponseEntity<?> getAllUsers() {
		Map<String, Object> response = graphQL.getAllUsers();
		return new ResponseEntity<>(response,HttpStatus.OK);
	}
	
	@PostMapping("/createUser")
	public ResponseEntity<?> postCreateUser(@RequestBody Map<String, String> request) {	
		String email = request.get("email");
		String name = request.get("name");
		String password = request.get("password");
		Map<String, Object> response = graphQL.createUser(email,name,password);
		return new ResponseEntity<>(response,HttpStatus.OK);
	}
	
	@PutMapping("/updatePassword")
	public ResponseEntity<?> updatePassword(@RequestBody Map<String, String> request) {	
		String email = request.get("email");
		String actual = request.get("actual");
		String newP = request.get("new");
		Map<String, Object> response = graphQL.updatePassword(email,actual,newP);
		return new ResponseEntity<>(response,HttpStatus.OK);
	}
	
	@DeleteMapping("/deleteUser")
	public ResponseEntity<?> deleteUser(@RequestBody Map<String, String> request) {	
		String email = request.get("email");
		String pass = request.get("password");
		Map<String, Object> response = graphQL.deleteUser(email,pass);
		return new ResponseEntity<>(response,HttpStatus.OK);
	}
}
