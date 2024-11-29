import 'package:flutter/material.dart';

import '../../domain/Transaction/entities/category.dart';
import '../../domain/Transaction/value_objects/amount.dart';
import '../../domain/Transaction/value_objects/category_color.dart';
import '../../domain/Transaction/value_objects/category_icon.dart';
import '../../domain/Transaction/value_objects/category_name.dart';
import '../../domain/Transaction/entities/transaction.dart';
import '../../domain/Transaction/value_objects/coin_type.dart';
import '../../domain/Transaction/value_objects/date.dart';
import '../../domain/Transaction/value_objects/transaction_type.dart';


class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();

  List<Transaction> _transactions = [];
  List<Category> _categories = [];

  LocalDatabase._init() {
    // Precargar datos de prueba
    _categories = [
      Category(
        id: 1,
        nombre: NombreCategoria('Alimentación'),
        icono: IconoCategoria(Icons.fastfood),
        color: ColorCategoria(Colors.orange),
      ),
      Category(
        id: 2,
        nombre: NombreCategoria('Transporte'),
        icono: IconoCategoria(Icons.directions_car),
        color: ColorCategoria(Colors.blue),
      ),
      Category(
        id: 3,
        nombre: NombreCategoria('Entretenimiento'),
        icono: IconoCategoria(Icons.movie),
        color: ColorCategoria(Colors.purple),
      ),
      Category(
        id: 4,
        nombre: NombreCategoria('Salud'),
        icono: IconoCategoria(Icons.local_hospital),
        color: ColorCategoria(Colors.redAccent),
      ),
      Category(
        id: 5,
        nombre: NombreCategoria('Trabajo'),
        icono: IconoCategoria(Icons.work),
        color: ColorCategoria(Colors.grey),
      ),
      Category(
        id: 6,
        nombre: NombreCategoria('Otros'),
        icono: IconoCategoria(Icons.miscellaneous_services),
        color: ColorCategoria(Colors.pink),
      ),
    ];

    _transactions = [
      Transaction(
        id: 1,
        gmail: 'yosmar.tejeda@unmsm.edu.pe',
        fecha: Fecha(DateTime.now().subtract(const Duration(days: 2)),),
        monto: Monto( 50),
        categoria: _categories[0], // Comida
        nota: 'Cena en restaurante',
        tipoMoneda: TipoMoneda.Sol,
        tipoTransaccion: TipoTransaccion.Gasto,
      ),
      Transaction(
        id: 2,
        gmail: 'yosmar.tejeda@unmsm.edu.pe',
        fecha: Fecha(DateTime.now().subtract(const Duration(days: 1)),),
        monto: Monto(75),
        categoria: _categories[1], // Transporte
        nota: 'Taxi',
        tipoMoneda: TipoMoneda.Sol,
        tipoTransaccion: TipoTransaccion.Gasto,
      ),
      Transaction(
        id: 3,
        gmail: 'yosmar.tejeda@unmsm.edu.pe',
        fecha: Fecha(DateTime.now()),
        monto: Monto(1000),
        categoria: _categories[4], // Transporte
        nota: 'Pago mensual',
        tipoMoneda: TipoMoneda.Sol,
        tipoTransaccion: TipoTransaccion.Ingreso,
      ),
    ];
  }

  List<Transaction> getAllTransactions() {
    return _transactions;
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
  }

  List<Category> getAllCategories() {
    return _categories;
  }

  void addCategory(Category category) {
    _categories.add(category);
  }

  void updateTransaction(Transaction updatedTransaction) {
    final index = _transactions.indexWhere((tx) => tx.id == updatedTransaction.id);
    if (index >= 0) {
      _transactions[index] = updatedTransaction;
    } else {
      throw ArgumentError('Transacción no encontrada');
    }
  }

}