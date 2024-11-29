import 'package:financial_app/domain/Transaction/services/transaction_service.dart';
import 'package:financial_app/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../application/providers/category_provider.dart';
import '../../domain/Transaction/entities/category.dart';
import '../../domain/Transaction/entities/transaction.dart';
import '../../application/providers/transaction_provider.dart';
import '../../domain/Transaction/value_objects/amount.dart';
import '../../domain/Transaction/value_objects/coin_type.dart';
import '../../domain/Transaction/value_objects/date.dart';
import '../../domain/Transaction/value_objects/transaction_type.dart';
import '../themes/app_sizes.dart';

class TransactionDetailPage extends StatefulWidget {
  final Transaction transaction;

  const TransactionDetailPage({super.key, required this.transaction});

  @override
  _TransactionDetailState createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetailPage> {
  late TextEditingController _amountController;
  late TextEditingController _noteController;
  late Category _selectedCategory;
  late Fecha _selectedDate;
  late TipoMoneda _tipoMoneda;
  TipoTransaccion _tipoTransaccion = TipoTransaccion.Gasto;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    _amountController = TextEditingController(text: widget.transaction.monto.value.toString());
    _noteController = TextEditingController(text: widget.transaction.nota);
    _selectedDate = widget.transaction.fecha;
    _tipoMoneda = widget.transaction.tipoMoneda;
    _tipoTransaccion = widget.transaction.tipoTransaccion;
    _selectedCategory = categoryProvider.categories.firstWhere(
            (category) => category.id == widget.transaction.categoria.id,
        orElse: () => categoryProvider.categories.first
    );

    setState(() {
      _isLoading = false;
    });
  }

  void _updateTransaction() {
    final updatedTransaction = Transaction(
      id: widget.transaction.id,
      gmail: widget.transaction.gmail,
      fecha: Fecha(_selectedDate.value),
      monto: Monto(double.parse(_amountController.text)),
      categoria: _selectedCategory,
      nota: _noteController.text,
      tipoMoneda: _tipoMoneda,
      tipoTransaccion: _tipoTransaccion,
    );


    Provider.of<TransactionProvider>(context, listen: false)
        .updateTransaction(updatedTransaction);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    final categoryProvider = Provider.of<CategoryProvider>(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detalle de transacción'),
          backgroundColor: AppColors.backgroundColor,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Transacción'),
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
                trailing: DropdownButton<Category>(
                  value: _selectedCategory,
                  onChanged: (Category? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  items: categoryProvider.isLoading
                      ? [] // Show an empty list while loading
                      : categoryProvider.categories.map((Category categoria) {
                    return DropdownMenuItem<Category>(
                      value: categoria,
                      child: Text(categoria.nombre.value),
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
                    Text(DateFormat('dd/MM/yyyy').format(_selectedDate.value),
                      style: TextStyle(
                          fontSize: AppSizes.customSizeHeight(context, 0.017),
                          fontWeight:FontWeight.bold
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate.value,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked as Fecha;
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
                  onPressed: _updateTransaction,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Editar Transacción', style: TextStyle(fontWeight:FontWeight.bold),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
