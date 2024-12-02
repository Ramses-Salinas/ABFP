import 'package:financial_app/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/providers/planning_provider.dart';
import '../themes/app_sizes.dart';

class EditBudgetScreen extends StatelessWidget {
  const EditBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final presupuestoProvider = Provider.of<PresupuestoProvider>(context);
    final presupuestoPorCategoria = presupuestoProvider.presupuesto.presupuestoPorCategoria;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'EDITAR PRESUPUESTO',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.mediumSpace(context),
            horizontal: AppSizes.mediumWidthSpace(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*
              // Presupuesto Mensual
              Container(
                padding: EdgeInsets.all(AppSizes.mediumSpace(context)),
                decoration: BoxDecoration(
                  color: AppColors.lightPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Presupuesto Mensual',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Row(
                      children: [
                        const Text(
                          'S/ ',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        const Text(
                          '500.00',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: AppSizes.smallWidthSpace(context)),
                        const Icon(Icons.edit, color: Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.largeSpace(context)),
               */
              // Planificación financiera
              Container(
                padding: EdgeInsets.all(AppSizes.mediumSpace(context)),
                decoration: BoxDecoration(
                  color: AppColors.lightPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        'Planificación financiera',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(height: AppSizes.mediumSpace(context)),
                      Column(
                        children: [
                          _buildPlanningButton(context, 'Corto plazo'),
                          _buildPlanningButton(context, 'Mediano plazo'),
                          _buildPlanningButton(context, 'Largo plazo'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppSizes.largeSpace(context)),

              // Ajustar categorías
              Container(
                padding: EdgeInsets.all(AppSizes.mediumSpace(context)),
                decoration: BoxDecoration(
                  color: AppColors.lightPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: AppSizes.customSizeHeight(context, 0.37),
                child: Column(
                  children: [
                    const Text(
                      'Ajustar categorías',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(height: AppSizes.mediumSpace(context)),
                    Expanded(
                      child: presupuestoProvider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView(
                        children: [
                          ...presupuestoPorCategoria.entries.map(
                                (entry) => _buildCategoryRow(
                              context,
                              entry.key,
                              entry.value,
                              presupuestoProvider,
                            ),
                          ),
                          SizedBox(height: AppSizes.smallSpace(context)),
                          Center(
                            child: IconButton(
                              icon: const Icon(Icons.add_circle, color: Colors.blue, size: 40),
                              onPressed: () {
                                _showAddCategoryDialog(context, presupuestoProvider);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Guardar cambios
              SizedBox(height: AppSizes.largeSpace(context)),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizes.customSizeHeight(context, 0.01),
                      horizontal: AppSizes.largeWidthSpace(context),
                    ),
                  ),
                  child: const Text(
                    'Guardar Cambios',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanningButton(BuildContext context, String title) {
    final presupuestoProvider = Provider.of<PresupuestoProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.smallSpace(context)),
      child: SizedBox(
        width: AppSizes.customSizeWidth(context, 0.4),
        child: ElevatedButton.icon(
          onPressed: () {
            _showEditGoalDialog(context, presupuestoProvider, title);
          },
          icon: const Icon(Icons.edit, color: Colors.blue),
          label: Text(title),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.textBlack,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow(
      BuildContext context,
      String category,
      double value,
      PresupuestoProvider provider,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.smallSpace(context)),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              category,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          SizedBox(width: AppSizes.smallWidthSpace(context)),
          Expanded(
            flex: 1,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.textBlack,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintText: value.toString(),
                hintStyle: TextStyle(color: Colors.grey[600]),
              ),
              onSubmitted: (newValue) {
                provider.actualizarPresupuesto(
                  porCategoria: {
                    ...provider.presupuesto.presupuestoPorCategoria,
                    category: double.tryParse(newValue) ?? value,
                  },
                );
              },
            ),
          ),
          SizedBox(width: AppSizes.smallWidthSpace(context)),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              provider.eliminarCategoria(category);
            },
          ),
        ],
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context, PresupuestoProvider provider) {
    final categoryController = TextEditingController();
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar categoría'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Nombre de la categoría'),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Monto'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final category = categoryController.text.trim();
              final amount = double.tryParse(amountController.text.trim()) ?? 0;

              if (category.isNotEmpty) {
                provider.agregarCategoria(category, amount);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  void _showEditGoalDialog(
      BuildContext context, PresupuestoProvider presupuestoProvider, String title) {

    String initialValue = '';
    String dialogTitle = '';

    switch (title) {
      case 'Corto plazo':
        initialValue = presupuestoProvider.presupuesto.presupuestoMensual.toString();
        dialogTitle = 'Editar Presupuesto a corto plazo';
        break;
      case 'Mediano plazo':
        initialValue = presupuestoProvider.presupuesto.presupuestoSemestral.toString();
        dialogTitle = 'Editar Presupuesto a corto plazo';
        break;
      case 'Largo plazo':
        initialValue = presupuestoProvider.presupuesto.presupuestoAnual.toString();
        dialogTitle = 'Editar Presupuesto a corto plazo';
    }

    final controller = TextEditingController(text: initialValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(dialogTitle),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Nuevo presupuesto'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final newGoal = double.tryParse(controller.text);
              if (newGoal != null) {
                presupuestoProvider.actualizarPresupuestoPlazo(newGoal,title);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
