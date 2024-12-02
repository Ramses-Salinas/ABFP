import 'package:financial_app/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../application/providers/category_provider.dart';
import '../../application/providers/planning_provider.dart';
import '../../application/providers/transaction_provider.dart';
import '../../application/providers/user_provider.dart';
import '../../domain/Transaction/entities/category.dart';
import '../../infrastructure/graphql/graphql_client.dart';
import '../themes/app_sizes.dart';

class TransactionAddPage extends StatefulWidget {
  const TransactionAddPage({super.key});

  @override
  _TransactionDetailState createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionAddPage> {

  late Category? _selectedCategory;
  late String _selectedTransactionType;
  late TextEditingController _amountController;
  late String _selectedCurrencyType;
  late TextEditingController _noteController;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = true;
  final myGraphQLClient = GraphQLClientProvider.getClient();


  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _noteController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
      _selectedCategory = categoryProvider.categories.first;
      final transactionProvider = Provider.of<TransactionProvider>(context, listen: false);
      _selectedTransactionType = transactionProvider.transactionTypes.first;
      _selectedCurrencyType = transactionProvider.currencyTypes.first;
      print(_selectedCategory);


      setState(() {
        _isLoading = false;
      });

    });

  }

  Future<void> _addTransaction() async {

    if (_selectedCategory == null) return;

    try {
      await Provider.of<TransactionProvider>(context, listen: false).addTransaction(
        amount: double.parse(_amountController.text),
        categoryId: _selectedCategory!.id,
        categoryName: _selectedCategory!.nombre.value,
        categoryIcon: _selectedCategory!.icono.value,
        categoryColor: _selectedCategory!.color.value,
        note: _noteController.text,
        date: _selectedDate,
        currencyType: _selectedCurrencyType,
        transactionType:  _selectedTransactionType,
      );

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final planningProvider = Provider.of<PlanningProvider>(context, listen: false);
      var newBalance = double.parse(_amountController.text);
      if(_selectedTransactionType=="Gasto") {
        newBalance *= -1;
      }

      newBalance += planningProvider.presupuesto.balance;

      await planningProvider.actualizarBalance(userProvider.currentUser!.gmail, newBalance);

      print('Transacción registrada con éxito');
    } catch (e) {
      print('Error al registrar transacción: $e');
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Añadir Transacción'),
          backgroundColor: AppColors.backgroundColor,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final categoryProvider = Provider.of<CategoryProvider>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);
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
                trailing: DropdownButton<String>(
                  value: _selectedTransactionType,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTransactionType = newValue!;
                    });
                  },
                  items: transactionProvider.transactionTypes.map((String tipo) {
                    return DropdownMenuItem<String>(
                      value: tipo,
                      child: Text(tipo),
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
                trailing: DropdownButton<String>(
                  value: _selectedCurrencyType,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCurrencyType = newValue!;
                    });
                  },
                  items: transactionProvider.currencyTypes.map((String tipo) {
                    return DropdownMenuItem<String>(
                      value: tipo,
                      child: Text(tipo),
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
                      _selectedCategory = newValue;
                    });
                  },
                  items: categoryProvider.isLoading
                      ? [const DropdownMenuItem<Category>(value: null, child: Text('Cargando...'))]
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
