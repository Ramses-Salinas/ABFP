class NombreCategoria {
  final String value;

  NombreCategoria(this.value) {
    if (value.isEmpty) {
      throw ArgumentError('El nombre de la categoría no puede estar vacío');
    }
  }

  @override
  String toString() => value;
}
