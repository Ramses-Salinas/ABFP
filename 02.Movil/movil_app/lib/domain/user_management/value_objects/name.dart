class Name {
  final String value;

  Name._(this.value);

  // Constructor de fábrica con validación
  factory Name.crear(String name) {
    // Regex que permite solo letras, espacios y tildes
    final regex = RegExp(r"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$");

    if (!regex.hasMatch(name)) {
      throw ArgumentError("El nombre no debe contener caracteres especiales.");
    }

    return Name._(name);
  }
}
