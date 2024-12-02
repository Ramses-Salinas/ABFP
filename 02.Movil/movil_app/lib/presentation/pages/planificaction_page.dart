import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/providers/planning_provider.dart';
import '../themes/app_colors.dart';
import '../themes/app_sizes.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class PlanningPage extends StatefulWidget {
  const PlanningPage({super.key});

  @override
  State<PlanningPage> createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final presupuestoProvider = Provider.of<PresupuestoProvider>(context);

    if (presupuestoProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Planificación',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.customSizeWidth(context, 0.03)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSizes.mediumSpace(context)),
            _buildBudgetCard(context, presupuestoProvider),
            SizedBox(height: AppSizes.mediumSpace(context)),
            _buildSavingsGoalCard(context, presupuestoProvider),
            SizedBox(height: AppSizes.mediumSpace(context)),
            _buildSuggestions(context, presupuestoProvider),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildBudgetCard(
      BuildContext context, PresupuestoProvider presupuestoProvider) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(AppSizes.customSizeWidth(context, 0.03)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Presupuesto Mensual',
                style: TextStyle(
                  fontSize: AppSizes.customSizeHeight(context, 0.02),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(width: AppSizes.customSizeWidth(context, 0.2)),
              Text(
                'S/ ${presupuestoProvider.presupuesto.presupuestoMensual}',
                style: TextStyle(
                  fontSize: AppSizes.customSizeHeight(context, 0.024),
                  color: AppColors.textBlack,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.customSizeHeight(context, 0.008)),
          LinearProgressIndicator(
            value: 0.7,
            minHeight: AppSizes.customSizeHeight(context, 0.01),
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          SizedBox(height: AppSizes.customSizeHeight(context, 0.008)),
          Text(
            'S/ 350.00',
            style: TextStyle(
              fontSize: AppSizes.customSizeHeight(context, 0.018),
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: AppSizes.customSizeHeight(context, 0.016)),
          Center(
            child: SizedBox(
              width: AppSizes.customSizeHeight(context, 0.2),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/edit_budget');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Editar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsGoalCard(
      BuildContext context, PresupuestoProvider presupuestoProvider) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(AppSizes.customSizeWidth(context, 0.03)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Meta de ahorro',
                style: TextStyle(
                  fontSize: AppSizes.customSizeHeight(context, 0.02),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(width: AppSizes.customSizeWidth(context, 0.34)),
              Text(
                'S/ ${presupuestoProvider.presupuesto.metaAhorro}',
                style: TextStyle(
                  fontSize: AppSizes.customSizeHeight(context, 0.024),
                  color: AppColors.textBlack,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.customSizeHeight(context, 0.008)),
          LinearProgressIndicator(
            value: 0.35,
            minHeight: AppSizes.customSizeHeight(context, 0.01),
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          SizedBox(height: AppSizes.customSizeHeight(context, 0.016)),
          Center(
            child: SizedBox(
              width: AppSizes.customSizeHeight(context, 0.2),
              child: ElevatedButton(
                onPressed: () {
                  _showEditGoalDialog(context, presupuestoProvider);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Ajustar meta',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditGoalDialog(
      BuildContext context, PresupuestoProvider presupuestoProvider) {
    final controller = TextEditingController(
        text: presupuestoProvider.presupuesto.metaAhorro.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Meta de Ahorro'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Nueva meta'),
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
                presupuestoProvider.actualizarMetaAhorro(newGoal);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestions(
      BuildContext context, PresupuestoProvider presupuestoProvider) {
    return Container(
      width: AppSizes.customSizeWidth(context, 1),
      decoration: BoxDecoration(
        color: AppColors.lightPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(AppSizes.customSizeWidth(context, 0.03)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sugerencias',
            style: TextStyle(
              fontSize: AppSizes.customSizeHeight(context, 0.02),
              fontWeight: FontWeight.bold,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: AppSizes.customSizeHeight(context, 0.008)),
          Text(
            presupuestoProvider.presupuesto.sugerencia,
            style: TextStyle(
              fontSize: AppSizes.customSizeHeight(context, 0.016),
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: AppSizes.customSizeHeight(context, 0.016)),
        ],
      ),
    );
  }
}
