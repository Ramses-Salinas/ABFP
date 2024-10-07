class Fecha {
  final DateTime value;


  Fecha(this.value) {
    if (value.isBefore(DateTime.now())) {
      //throw ArgumentError('La fecha no puede ser en el pasado');
    }
  }

  @override
  String toString() => value.toIso8601String();
}
