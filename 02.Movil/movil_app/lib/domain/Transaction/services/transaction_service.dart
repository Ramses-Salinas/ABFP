import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../application/providers/category_provider.dart';
import '../../../infrastructure/repositories/transaction_repository.dart';
import '../aggregates/transaction_aggregate.dart';
import '../entities/category.dart';
import '../entities/transaction.dart';
import '../value_objects/amount.dart';
import '../value_objects/category_color.dart';
import '../value_objects/category_icon.dart';
import '../value_objects/category_name.dart';
import '../value_objects/coin_type.dart';
import '../value_objects/date.dart';
import '../value_objects/transaction_type.dart';

class TransactionRegister {
  final TransactionAggregate _transactionAggregate = TransactionAggregate();
  final TransactionRepository2 _transactionRepository = TransactionRepository2();

  List<String> getCurrencyTypes() {
    return TipoMoneda.values.map((tipo) => tipo.name).toList();
  }

  List<String> getTransactionTypes() {
    return TipoTransaccion.values.map((tipo) => tipo.name).toList();
  }

  Transaction crearTransaccion({
    required int id,
    required String gmail,
    required double amount,
    required int categoryId,
    required String categoryName,
    required IconData categoryIcon,
    required Color categoryColor,
    required String note,
    required DateTime date,
    required String currencyType,
    required String transactionType,
  }) {

    final tipoMoneda = TipoMoneda.values.firstWhere((tipo) => tipo.name == currencyType);
    final tipoTransaccion = TipoTransaccion.values.firstWhere((tipo) => tipo.name == transactionType);
    final category = Category(
      id: categoryId,
      nombre: NombreCategoria(categoryName),
      icono: IconoCategoria(categoryIcon),
      color: ColorCategoria(categoryColor),
    );
    return Transaction(
      id: id,
      gmail: gmail,
      fecha: Fecha(date),
      monto: Monto(amount),
      categoria: category,
      nota: note,
      tipoMoneda: tipoMoneda,
      tipoTransaccion: tipoTransaccion,
    );
  }

  void registrar(Transaction transaction) {
    _transactionAggregate.registrarTransaccion(transaction);
    _transactionRepository.updateTransaction(transaction);
  }

  void actualizar(Transaction updatedTransaction) {
    _transactionAggregate.actualizarTransaccion(updatedTransaction);
    _transactionRepository.updateTransaction(updatedTransaction);
  }

  List<Transaction> getAllTransactions() {
    return _transactionRepository.getAllTransactions();
  }
}




class TransactionService {
  final TransactionRepository transaccionRepository;

  TransactionService({required this.transaccionRepository});


  Transaction crearTransaccion({
    required int id,
    required String gmail,
    required double amount,
    required int categoryId,
    required String categoryName,
    required IconData categoryIcon,
    required Color categoryColor,
    required String note,
    required DateTime date,
    required String currencyType,
    required String transactionType,
  }) {

    final tipoMoneda = TipoMoneda.values.firstWhere((tipo) => tipo.name == currencyType);
    final tipoTransaccion = TipoTransaccion.values.firstWhere((tipo) => tipo.name == transactionType);
    final category = Category(
      id: categoryId,
      nombre: NombreCategoria(categoryName),
      icono: IconoCategoria(categoryIcon),
      color: ColorCategoria(categoryColor),
    );
    return Transaction(
      id: id,
      gmail: gmail,
      fecha: Fecha(date),
      monto: Monto(amount),
      categoria: category,
      nota: note,
      tipoMoneda: tipoMoneda,
      tipoTransaccion: tipoTransaccion,
    );
  }



  Future<void> registrarTransaccion(Transaction transaction) async {
    await transaccionRepository.crearTransaccion(transaction);
  }

  Future<void> actualizarTransaccion(Transaction transaction) async {
    await transaccionRepository.actualizarTransaccion(transaction);
  }

  Future<void> eliminarTransaccion(String gmail, int id) async {
    await transaccionRepository.eliminarTransaccion(gmail, id);
  }

  Future<List<Transaction>>  obtenerTransacciones(String gmail) async {
    try {
    final List<Map<String, dynamic>> transacciones = await transaccionRepository.obtenerTransacciones(gmail);
    return transacciones.map((transaccion) {
      // Buscar categoría basada en el nombre.
      final String categoriaNombre = transaccion['categoria_transaccion'] ?? 'Desconocida';
      final Category categoria = CategoryProvider().getCategoryByName(categoriaNombre);

      // Reconstruir los objetos de valor.
      final Fecha fecha = Fecha(DateTime.parse(transaccion['fecha']));
      final Monto monto = Monto((transaccion['monto'] as num).toDouble());
      final TipoMoneda tipoMoneda = TipoMoneda.values.firstWhere(
            (tipo) => tipo.name == transaccion['tipo_moneda'],
        orElse: () => TipoMoneda.Sol,
      );
      final TipoTransaccion tipoTransaccion = TipoTransaccion.values.firstWhere(
            (tipo) => tipo.name == transaccion['tipo_transaccion'],
        orElse: () => TipoTransaccion.Gasto,
      );

      // Crear la transacción reconstruida.
      return Transaction(
        id: transaccion['transaccion_id'],
        gmail: transaccion['gmail'],
        fecha: fecha,
        monto: monto,
        categoria: categoria,
        nota: transaccion['nota'],
        tipoMoneda: tipoMoneda,
        tipoTransaccion: tipoTransaccion,
      );
    }).toList();

    } catch (e) {
      throw Exception('Error al reconstruir transacciones: $e');
    }
  }

}