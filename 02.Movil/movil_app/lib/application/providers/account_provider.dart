import 'package:financial_app/domain/Transaction/events/transaction_updated.dart';
import 'package:flutter/material.dart';

import '../../domain/Transaction/entities/transaction.dart';
import '../../domain/Transaction/value_objects/transaction_type.dart';
import '../../domain/events/domain_event.dart';
import '../../domain/Transaction/events/transaction_registered.dart';
import '../../domain/user_management/entities/account.dart';
import '../../infrastructure/event_dispatcher/domain_event_publisher.dart';
import 'transaction_provider.dart';


class AccountProvider with ChangeNotifier {
  late final Account _account;

  AccountProvider(Account account, TransactionProvider transactionProvider) {
    _account = account;
    DomainEventPublisher.instance.subscribe(_manejarTransaccion);

  }

  double get saldo => _account.saldo;

  void _manejarTransaccion(DomainEvent event) {
    if (event is TransaccionRegistrada) {
      Transaction transaction = event.transaction;

      if (transaction.tipoTransaccion == TipoTransaccion.Ingreso) {
        _account.saldo += transaction.monto.value;
      } else if (transaction.tipoTransaccion == TipoTransaccion.Gasto) {
        _account.saldo -= transaction.monto.value;
      }

      notifyListeners();
    }
    if (event is TransaccionActualizada) {
      Transaction newTransaction = event.newTransaction;
      Transaction oldTransaction = event.oldTransaction;

      // Revertir el saldo de la transacción anterior
      _account.saldo -= oldTransaction.tipoTransaccion == TipoTransaccion.Ingreso
          ? oldTransaction.monto.value
          : -oldTransaction.monto.value;

      // Aplicar el saldo de la nueva transacción
      _account.saldo += newTransaction.tipoTransaccion == TipoTransaccion.Ingreso
          ? newTransaction.monto.value
          : -newTransaction.monto.value;

      notifyListeners();
    }
  }
}

