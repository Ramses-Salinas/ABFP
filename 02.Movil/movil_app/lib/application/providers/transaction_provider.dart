import 'package:financial_app/application/providers/user_provider.dart';
import 'package:financial_app/domain/Transaction/value_objects/coin_type.dart';
import 'package:financial_app/domain/Transaction/value_objects/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/Transaction/services/transaction_service.dart';
import '../../domain/Transaction/entities/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];
  bool _isLoading = true;
  final transactionRegister= TransactionRegister();
  final TransactionService transactionService;
  final UserProvider userProvider;
  int _lastGeneratedId = 0;

  bool get isLoading => _isLoading;

  List<Transaction> _filteredTransactions = [];
  List<Transaction> get transactions {
    return _filteredTransactions;
  }

  List<String> get currencyTypes => transactionRegister.getCurrencyTypes();

  List<String> get transactionTypes => transactionRegister.getTransactionTypes();

  TransactionProvider({required this.transactionService, required this.userProvider}) {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    _isLoading = true;

    final String? gmail = userProvider.currentGmail;

    if (gmail == null) {
      print("Usuario no autenticado. No se puede cargar transacciones.");
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      _transactions = await transactionService.obtenerTransacciones(gmail);
      _filteredTransactions = _transactions;
    } catch (e) {
      print("Error al cargar transacciones: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTransaction({

    required double amount,
    required int categoryId,
    required String categoryName,
    required IconData categoryIcon,
    required Color categoryColor,
    required String note,
    required DateTime date,
    required String currencyType,
    required String transactionType,
  }) async {

    int timestamp =  (DateTime.now().millisecondsSinceEpoch ~/ 100000).toInt();
    int newId = timestamp + (++_lastGeneratedId);
    final String? gmail = userProvider.currentGmail;

    if (gmail == null) {
      print("Usuario no autenticado. No se puede agregar transacciones.");
      return;
    }

    final newTransaction = transactionService.crearTransaccion(
      id: newId,
      gmail: gmail,
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

    await transactionService.registrarTransaccion(newTransaction);

    loadTransactions();

  }

  Future<void> updateTransaction(Transaction updatedTransaction) async {

    await transactionService.actualizarTransaccion(updatedTransaction);

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
      _filteredTransactions = _transactions;
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
