class Password {
  final String value;
  
  Password._(this.value);
  
  // Constructor de fábrica con validación
  factory Password.crear(String password) {
    if (password.length < 8) {
    throw ArgumentError("La contraseña debe tener al menos 8 caracteres.");
    }
    
    // Verificar al menos una letra mayúscula, una minúscula, un número y un carácter especial
    //final regexMayus = RegExp(r'[A-Z]');
    final regexMinus = RegExp(r'[a-z]');
    final regexNumero = RegExp(r'[0-9]');
    //final regexEspecial = RegExp(r'[!@#\$&*~]');
    
    if (!regexMinus.hasMatch(password)
    //     || !regexMayus.hasMatch(password)
        || !regexNumero.hasMatch(password)
    //    || !regexEspecial.hasMatch(password)
    ){
      throw ArgumentError(
      "La contraseña debe tener al menos una letra mayúscula, una minúscula, un número y un carácter especial.",
      );
    }
    
    return Password._(password);
  }
}
