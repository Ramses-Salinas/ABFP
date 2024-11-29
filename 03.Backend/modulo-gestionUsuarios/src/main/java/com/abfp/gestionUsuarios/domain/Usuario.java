package com.abfp.gestionUsuarios.domain;

public class Usuario {
	private String email;
	private boolean app;
	private boolean correo;
	private String nombre;
	private String pasword;
	private boolean resumen;
	
	public Usuario(String email, boolean app, boolean correo, String nombre, String pasword, boolean resumen) {
		super();
		this.email = email;
		this.app = app;
		this.correo = correo;
		this.nombre = nombre;
		this.pasword = pasword;
		this.resumen = resumen;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean isApp() {
		return app;
	}

	public void setApp(boolean app) {
		this.app = app;
	}

	public boolean isCorreo() {
		return correo;
	}

	public void setCorreo(boolean correo) {
		this.correo = correo;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getPasword() {
		return pasword;
	}

	public void setPasword(String pasword) {
		this.pasword = pasword;
	}

	public boolean isResumen() {
		return resumen;
	}

	public void setResumen(boolean resumen) {
		this.resumen = resumen;
	}
	
	
}
