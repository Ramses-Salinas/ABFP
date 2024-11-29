package com.abfp.gestionUsuarios.ports.in;

import java.util.Map;

public interface GraphQL {
	Map<String, Object> getAllUsers();
	Map<String, Object> createUser(String email, String name, String password);
	Map<String, Object> updatePassword(String email, String actualPass, String newPass);
	Map<String, Object> deleteUser(String email, String password);
}
