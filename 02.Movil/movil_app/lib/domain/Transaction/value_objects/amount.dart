class Monto {
  final double value;

  Monto(this.value) {
    if (value < 0) {
      throw ArgumentError('El monto no puede ser negativo');
    }
  }
}
