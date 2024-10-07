
import '../entities/transaction.dart';
import '../../events/domain_event.dart';

class TransaccionRegistrada extends DomainEvent {

  final Transaction transaction;

  TransaccionRegistrada(this.transaction);

}
