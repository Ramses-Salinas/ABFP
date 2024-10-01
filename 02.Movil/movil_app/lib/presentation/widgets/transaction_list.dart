import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../domain/provider/transaction_provider.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    final transactions = transactionProvider.transactions.reversed.toList();

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];

        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: tx.getCategoryColor(),
              child: Icon(tx.getCategoryIcon(), color: Colors.white),
            ),
            title: Text(tx.categoria),
            subtitle: Text(_formatDate(tx.fecha)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${tx.getCurrencySymbol()}${tx.monto.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: tx.getTransactionColor(),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 20,),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/transaction_detail',
                      arguments: tx,
                    );
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/transaction_detail',
                arguments: tx,
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
