import '../../domain/Transaction/entities/transaction.dart';
import '../graphql/local_database.dart';

class TransactionRepository {
  final LocalDatabase _localDatabase = LocalDatabase.instance;

  TransactionRepository();

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
