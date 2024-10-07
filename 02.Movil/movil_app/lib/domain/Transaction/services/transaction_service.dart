import 'package:flutter/cupertino.dart';

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
  final TransactionRepository _transactionRepository = TransactionRepository();

  List<String> getCurrencyTypes() {
    return TipoMoneda.values.map((tipo) => tipo.name).toList();
  }

  List<String> getTransactionTypes() {
    return TipoTransaccion.values.map((tipo) => tipo.name).toList();
  }

  Transaction crearTransaccion({
    required int id,
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
