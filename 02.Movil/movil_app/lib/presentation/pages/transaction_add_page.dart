import 'package:financial_app/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../domain/model/transaction.dart';
import '../../domain/provider/transaction_provider.dart';
import '../themes/app_sizes.dart';

class TransactionAddPage extends StatefulWidget {
  const TransactionAddPage({super.key});

  @override
  _TransactionDetailState createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionAddPage> {
  String? _selectedCategory = Transaction.categoriasDisponibles.first;
  TipoTransaccion _tipoTransaccion = TipoTransaccion.Gasto;
  late TextEditingController _amountController;
  TipoMoneda _tipoMoneda = TipoMoneda.Sol ;
  late TextEditingController _noteController;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _noteController = TextEditingController();
  }

  void _addTransaction() {
    final newTransaction = Transaction(
      id: 4,
      fecha: _selectedDate,
      monto: double.parse(_amountController.text),
      categoria: _selectedCategory ?? Transaction.categoriasDisponibles.first,
      nota: _noteController.text,
      tipoMoneda: _tipoMoneda,
      tipoTransaccion: _tipoTransaccion,
    );

    Provider.of<TransactionProvider>(context, listen: false)
        .addTransaction(newTransaction);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Transacción'),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(AppSizes.customSizeWidth(context, 0.04)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text('Tipo de transacción'),
                trailing: DropdownButton<TipoTransaccion>(
                  value: _tipoTransaccion,
                  onChanged: (TipoTransaccion? newValue) {
                    setState(() {
                      _tipoTransaccion = newValue!;
                    });
                  },
                  items: TipoTransaccion.values.map((TipoTransaccion tipo) {
                    return DropdownMenuItem<TipoTransaccion>(
                      value: tipo,
                      child: Text(tipo.name),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: AppSizes.mediumSpace(context)),

              TextField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: AppSizes.mediumSpace(context)),

              ListTile(
                title: const Text('Tipo de moneda'),
                trailing: DropdownButton<TipoMoneda>(
                  value: _tipoMoneda,
                  onChanged: (TipoMoneda? newValue) {
                    setState(() {
                      _tipoMoneda = newValue!;
                    });
                  },
                  items: TipoMoneda.values.map((TipoMoneda tipo) {
                    return DropdownMenuItem<TipoMoneda>(
                      value: tipo,
                      child: Text(tipo.name),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: AppSizes.mediumSpace(context)),

              ListTile(
                title: const Text('Categoría'),
                trailing: DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  items: Transaction.categoriasDisponibles.map((String categoria) {
                    return DropdownMenuItem<String>(
                      value: categoria,
                      child: Text(categoria),
                    );
                  }).toList(),
                ),
              ),


              SizedBox(height: AppSizes.mediumSpace(context)),

              ListTile(
                title: Row(
                  children: [
                    const Text('Fecha:'),
                    SizedBox(width: AppSizes.customSizeWidth(context, 0.36)),
                    Text(DateFormat('dd/MM/yyyy').format(_selectedDate),
                      style: TextStyle(fontSize: AppSizes.customSizeHeight(context, 0.017), fontWeight:FontWeight.bold),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                ),
              ),


              SizedBox(height: AppSizes.mediumSpace(context)),

              TextField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: 'Notas'),
                maxLines: 3,
              ),

              SizedBox(height: AppSizes.mediumSpace(context)),

              Center(
                child: ElevatedButton(
                  onPressed: _addTransaction,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Guardar Transacción', style: TextStyle(fontWeight:FontWeight.bold),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
