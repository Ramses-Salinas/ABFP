import 'package:flutter/cupertino.dart';

class Dashboard {
  final String tipo;
  final String descripcion;
  final Map<String, dynamic> inputs;

  Dashboard({
    required this.tipo,
    required this.descripcion,
    required this.inputs,

  });

  void procesarDatos() {
  }

  Widget generarGrafica() {
    return const SizedBox.shrink();
  }
}