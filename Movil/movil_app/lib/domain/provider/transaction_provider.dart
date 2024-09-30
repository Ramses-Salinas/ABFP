import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionProvider with ChangeNotifier {
  final List<Transaction> _transactions = [
    Transaction(
      id: 1,
      fecha: DateTime.now().subtract(const Duration(days: 2)),
      monto: 50.75,
      categoria: 'Alimentación',
      nota: 'Cena en restaurante',
      tipoMoneda: TipoMoneda.Sol,
      tipoTransaccion: TipoTransaccion.Gasto,
    ),
    Transaction(
      id: 2,
      fecha: DateTime.now().subtract(const Duration(days: 1)),
      monto: 150.00,
      categoria: 'Transporte',
      nota: 'Combustible',
      tipoMoneda: TipoMoneda.Sol,
      tipoTransaccion: TipoTransaccion.Gasto,
    ),
    Transaction(
      id: 3,
      fecha: DateTime.now(),
      monto: 1000.00,
      categoria: 'Salario',
      nota: 'Pago mensual',
      tipoMoneda: TipoMoneda.Dolar,
      tipoTransaccion: TipoTransaccion.Ingreso,
    ),
  ];

  List<Transaction> _filteredTransactions = [];
  List<Transaction> get transactions => _filteredTransactions.isNotEmpty ? [..._filteredTransactions] : [..._transactions];

  // Método para añadir una nueva transacción
  void addTransaction(Transaction transaction) {
    final int newId = _transactions.isNotEmpty
        ? _transactions.last.id + 1
        : 1;

    final newTransaction = Transaction(
      id: newId,
      fecha: transaction.fecha,
      monto: transaction.monto,
      categoria: transaction.categoria,
      nota: transaction.nota,
      tipoMoneda: transaction.tipoMoneda,
      tipoTransaccion: transaction.tipoTransaccion,
    );

    _transactions.add(newTransaction);
    notifyListeners();
  }

  // Método para eliminar una transacción por ID
  void removeTransaction(String id) {
    _transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }

  // Método para actualizar una transacción existente
  void updateTransaction(Transaction updatedTransaction) {
    final index = _transactions.indexWhere((tx) => tx.id == updatedTransaction.id);
    if (index >= 0) {
      _transactions[index] = updatedTransaction;
      notifyListeners();
    }
  }

  // Método para obtener transacciones por categoría
  List<Transaction> getTransactionsByCategory(String categoria) {
    return _transactions.where((tx) => tx.categoria.toLowerCase() == categoria.toLowerCase()).toList();
  }

  // Método para obtener el total de ingresos
  double getTotalIngresos() {
    return _transactions
        .where((tx) => tx.tipoTransaccion == TipoTransaccion.Ingreso)
        .fold(0.0, (sum, tx) => sum + tx.monto);
  }

  // Método para obtener el total de gastos
  double getTotalGastos() {
    return _transactions
        .where((tx) => tx.tipoTransaccion == TipoTransaccion.Gasto)
        .fold(0.0, (sum, tx) => sum + tx.monto);
  }

  // Método de búsqueda que busca similitudes en cualquier atributo
  void searchTransactions(String query) {
    if (query.isEmpty) {
      _filteredTransactions = [];
    } else {
      _filteredTransactions = _transactions.where((tx) {
        final queryLower = query.toLowerCase();

        // Convertir monto a string para búsqueda
        final montoStr = tx.monto.toString();

        // Convertir fecha a string para búsqueda
        final fechaStr = DateFormat('dd/MM/yyyy').format(tx.fecha);

        // Convertir tipo de transacción y tipo de moneda a string para búsqueda
        final tipoTransaccionStr = tx.tipoTransaccion.toString().split('.').last;
        final tipoMonedaStr = tx.tipoMoneda.toString().split('.').last;

        return tx.categoria.toLowerCase().contains(queryLower) ||
            tx.nota!.toLowerCase().contains(queryLower) ||
            montoStr.contains(queryLower) ||
            fechaStr.contains(queryLower) ||
            tipoTransaccionStr.toLowerCase().contains(queryLower) ||
            tipoMonedaStr.toLowerCase().contains(queryLower);
      }).toList();
    }
    notifyListeners();
  }
}
