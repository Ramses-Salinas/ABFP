import '../../domain/Transaction/entities/transaction.dart';
import '../graphql/local_database.dart';

abstract class TransactionRepository {

  Future<void> crearTransaccion(Transaction transaccion);
  Future<void> actualizarTransaccion(Transaction transaccion);
  Future<void> eliminarTransaccion(String gmail, int id);
  Future<List<Map<String, dynamic>>> obtenerTransacciones(String gmail);

}

class TransactionRepository2 {

  final LocalDatabase _localDatabase = LocalDatabase.instance;

  TransactionRepository2();

  List<Transaction> getAllTransactions() {
    return _localDatabase.getAllTransactions();
  }

  void addTransaction(Transaction transaction) {
    _localDatabase.addTransaction(transaction);

  }

  void updateTransaction(Transaction updatedTransaction) {
    _localDatabase.updateTransaction(updatedTransaction);
  }

  Transaction? getTransactionById(int id) {
    return _localDatabase.getAllTransactions().firstWhere((tx) => tx.id == id);
  }


}