import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../application/providers/category_provider.dart';
import '../../application/providers/transaction_provider.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.watch<TransactionProvider>();
    final categoryProvider = Provider.of<CategoryProvider>(context);
    var transactions = transactionProvider.transactions.reversed.toList();

    if (transactionProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    transactions = transactionProvider.transactions.reversed.toList();

    if (transactions.isEmpty) {
      return const Center(
        child: Text('No hay transacciones disponibles.'),
      );
    }

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final category = categoryProvider.getCategoryById(transaction.categoria.id);

        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: category.color.value,
              child: Icon(category.icono.value, color: Colors.white),
            ),
            title: Text(category.nombre.value),
            subtitle: Text(_formatDate(transaction.fecha.value)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${transactionProvider.getCurrencySymbolForTransaction(transaction)}${transaction.monto.value.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: transactionProvider.getTransactionColor(transaction),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 20),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/transaction_detail',
                      arguments: transaction,
                    );
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/transaction_detail',
                arguments: transaction,
              );
            },
          ),
        );
      },
    );
  }

  String _formatDate(DateTime fecha) {
    return DateFormat('dd/MM/yyyy').format(fecha);
  }
}