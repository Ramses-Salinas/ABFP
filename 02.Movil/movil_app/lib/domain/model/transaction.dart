import 'package:flutter/material.dart';

// Enumeración para el tipo de transacción
enum TipoTransaccion {
  Gasto,
  Ingreso,
}

// Enumeración para el tipo de moneda
enum TipoMoneda {
  Sol,
  Dolar,
  Euro,
}


// Clase principal del modelo Transaction
class Transaction {
  final int id;
  final DateTime fecha;
  final double monto;
  final String categoria;
  final String? nota;
  final TipoMoneda tipoMoneda;
  final TipoTransaccion tipoTransaccion;

  Transaction({
    required this.id,
    required this.fecha,
    required this.monto,
    required this.categoria,
    this.nota,
    required this.tipoMoneda,
    required this.tipoTransaccion,
  });

  // Lista estática de categorías disponibles
  static const List<String> categoriasDisponibles = [
    'Alimentación',
    'Transporte',
    'Entretenimiento',
    'Salud',
    'Salario',
    'Otros',
  ];

  // Método para devolver el símbolo de la moneda según el tipo
  String getCurrencySymbol() {
    switch (tipoMoneda) {
      case TipoMoneda.Sol:
        return 'S/';
      case TipoMoneda.Dolar:
        return '\$';
      case TipoMoneda.Euro:
        return '€';
      default:
        return '';
    }
  }

  // Método para devolver el color del monto dependiendo del tipo de transacción
  Color getTransactionColor() {
    return tipoTransaccion == TipoTransaccion.Ingreso ? Colors.green : Colors.red;
  }

  // Método para devolver un ícono específico dependiendo de la categoría
  // Método para devolver un ícono específico dependiendo de la categoría
  IconData getCategoryIcon() {
    switch (categoria.toLowerCase()) {
      case 'alimentación':
        return Icons.fastfood;
      case 'transporte':
        return Icons.directions_car;
      case 'entretenimiento':
        return Icons.movie;
      case 'salud':
        return Icons.local_hospital;
      case 'otros':
        return Icons.miscellaneous_services;
      default:
        return Icons.category; // Icono por defecto si no está registrada
    }
  }

  // Método para devolver un color específico según la categoría
  Color getCategoryColor() {
    switch (categoria.toLowerCase()) {
      case 'alimentación':
        return Colors.orange;
      case 'transporte':
        return Colors.blue;
      case 'entretenimiento':
        return Colors.purple;
      case 'salud':
        return Colors.redAccent;
      case 'otros':
        return Colors.grey;
      default:
        return Colors.grey; // Color por defecto si no está registrada
    }
  }
}
