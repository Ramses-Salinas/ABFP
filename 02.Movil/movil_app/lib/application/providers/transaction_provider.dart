import 'package:financial_app/domain/Transaction/value_objects/coin_type.dart';
import 'package:financial_app/domain/Transaction/value_objects/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/Transaction/services/transaction_service.dart';
import '../../domain/Transaction/entities/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];
  bool _isLoading = true;
  final transactionService = TransactionRegister();
  bool get isLoading => _isLoading;

  List<Transaction> _filteredTransactions = [];
  List<Transaction> get transactions => _filteredTransactions.isNotEmpty ? [..._filteredTransactions] : [..._transactions];
  List<String> get currencyTypes => transactionService.getCurrencyTypes();

  List<String> get transactionTypes => transactionService.getTransactionTypes();

  TransactionProvider() {
    loadTransactions();
  }

  void loadTransactions() {
    _isLoading = true;
    notifyListeners();

    _transactions = transactionService.getAllTransactions();
    _filteredTransactions = [];

    _isLoading = false;
    notifyListeners();
  }

  void addTransaction({
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
    int newId = _transactions.isNotEmpty ? _transactions.last.id + 1 : 1;

    final newTransaction = transactionService.crearTransaccion(
      id: newId,
      amount: amount,
      categoryId: categoryId,
      categoryName: categoryName,
      categoryIcon: categoryIcon,
      categoryColor: categoryColor,
      note: note,
      date: date,
      currencyType: currencyType,
      transactionType: transactionType,
    );

    transactionService.registrar(newTransaction);

    notifyListeners();
    loadTransactions();
  }

  void updateTransaction(Transaction updatedTransaction) {

    transactionService.actualizar(updatedTransaction);

    notifyListeners();
    loadTransactions();
  }


  String getCurrencySymbolForTransaction(Transaction tx) {
    return tx.tipoMoneda.getCurrencySymbol();
  }

  Color getTransactionColor(Transaction tx) {
    return tx.tipoTransaccion.getTransactionColor();
  }

  void searchTransactions(String query) {
    if (query.isEmpty) {
      _filteredTransactions = [];
    } else {
      _filteredTransactions = _transactions.where((tx) {
        final queryLower = query.toLowerCase();
        final montoStr = tx.monto.value.toString();
        final fechaStr = DateFormat('dd/MM/yyyy').format(tx.fecha.value);
        final tipoTransaccionStr = tx.tipoTransaccion.toString().split('.').last;
        final tipoMonedaStr = tx.tipoMoneda.toString().split('.').last;

        return tx.categoria.nombre.value.toLowerCase().contains(queryLower) ||
            tx.nota != null && tx.nota!.toLowerCase().contains(queryLower) ||
            montoStr.contains(queryLower) ||
            fechaStr.contains(queryLower) ||
            tipoTransaccionStr.toLowerCase().contains(queryLower) ||
            tipoMonedaStr.toLowerCase().contains(queryLower);
      }).toList();
    }
    notifyListeners();
  }
}
