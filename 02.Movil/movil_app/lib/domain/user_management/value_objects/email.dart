class Email {
  final String value;

  Email._(this.value);

  // Constructor de fábrica con validación
  factory Email.crear(String email) {
    // Regex simple para validar formato de email
    final regex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");

    if (!regex.hasMatch(email)) {
      throw ArgumentError("El correo no tiene un formato válido.");
    }

    return Email._(email);
  }
}
