class Monto {
  final double value;

  Monto(this.value) {
    if (value < 0) {
      throw ArgumentError('El monto no puede ser negativo');
    }
  }

  @override
  String toString() => value.toStringAsFixed(2);
  double toDouble() => value;

}
