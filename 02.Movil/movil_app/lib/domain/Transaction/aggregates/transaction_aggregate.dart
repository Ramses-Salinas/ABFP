import '../../../infrastructure/event_dispatcher/domain_event_publisher.dart';
import '../../../infrastructure/repositories/transaction_repository.dart';
import '../events/transaction_registered.dart';
import '../events/transaction_updated.dart';
import '../entities/transaction.dart';


class TransactionAggregate {
  //final Transaction _transaction;
  final TransactionRepository2 _transactionRepository = TransactionRepository2();

  TransactionAggregate();

  void registrarTransaccion(Transaction transaction) {
    if (_esValida()) {
      // Se asegura de que la transacción sea válida
      _transactionRepository.addTransaction(transaction);
      final evento = TransaccionRegistrada(transaction);
      DomainEventPublisher.instance.publish(evento);
    } else {
      throw Exception("La transacción no es válida.");
    }
  }

  void actualizarTransaccion(Transaction updatedTransaction) {


    // Reglas de negocio para actualizaciones
    if (_esValidaParaActualizar(updatedTransaction)) {

      Transaction? oldTransaction = _transactionRepository.getTransactionById(updatedTransaction.id);
      if (oldTransaction == null) {
        throw Exception('Transacción no encontrada');
      }

      _transactionRepository.updateTransaction(updatedTransaction);
      final evento = TransaccionActualizada(updatedTransaction, oldTransaction);
      DomainEventPublisher.instance.publish(evento);

    } else {
      throw Exception("Actualización no válida.");
    }
  }

  bool _esValida() {
    // Reglas de validación
    return true;
  }

  bool _esValidaParaActualizar(Transaction nuevaTransaccion) {
    return true;
  }


}
