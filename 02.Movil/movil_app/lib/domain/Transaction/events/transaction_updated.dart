
import '../entities/transaction.dart';
import '../../events/domain_event.dart';

class TransaccionActualizada extends DomainEvent {

  final Transaction newTransaction;
  final Transaction oldTransaction;

  TransaccionActualizada(this.newTransaction, this.oldTransaction);

}
