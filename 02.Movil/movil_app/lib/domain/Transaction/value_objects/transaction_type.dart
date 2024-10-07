import 'package:flutter/material.dart';

enum TipoTransaccion {
  Gasto,
  Ingreso,
}

extension TipoTransaccionExtension on TipoTransaccion {
  Color getTransactionColor() {
    return this == TipoTransaccion.Ingreso ? Colors.green : Colors.red;
  }
}

