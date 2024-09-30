import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Planificación',style: Theme.of(context).textTheme.displayLarge,)),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.customSizeWidth(context, 0.03)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSizes.mediumSpace(context)),
            _buildBudgetCard(),
            SizedBox(height: AppSizes.mediumSpace(context)),
            _buildSavingsGoalCard(),
            SizedBox(height: AppSizes.mediumSpace(context)),
            _buildSuggestions(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildBudgetCard() {
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

              Text('\$ 500.00',
                  style: TextStyle(
                      fontSize: AppSizes.customSizeHeight(context, 0.024),
                    color: AppColors.textBlack,
                  )
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

          Text('S/ 350.00',
              style: TextStyle(
                fontSize: AppSizes.customSizeHeight(context, 0.018),
                color: AppColors.textBlack,
              )
          ),

          SizedBox(height: AppSizes.customSizeHeight(context, 0.004)),

          Text('GASTOS: S/150',
              style: TextStyle(
                fontSize: AppSizes.customSizeHeight(context, 0.016),
                color: AppColors.textBlack,
              )
          ),

          Text('GASTOS estimados: S/250',
              style: TextStyle(
                fontSize: AppSizes.customSizeHeight(context, 0.016),
                color: AppColors.textBlack,
              )
          ),

          SizedBox(height: AppSizes.customSizeHeight(context, 0.016)),

          Center(
            child: SizedBox(
              width: AppSizes.customSizeHeight(context, 0.2),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Editar', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary,),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsGoalCard() {
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

              Text('\$ 100.00',
                  style: TextStyle(
                    fontSize: AppSizes.customSizeHeight(context, 0.024),
                    color: AppColors.textBlack,
                  )
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

          SizedBox(height: AppSizes.customSizeHeight(context, 0.008)),

          Text('S/ 350.00',
            style: TextStyle(
              fontSize: AppSizes.customSizeHeight(context, 0.016),
              color: AppColors.textBlack,
            )
          ),

          SizedBox(height: AppSizes.customSizeHeight(context, 0.016)),

          Center(
            child: SizedBox(
              width: AppSizes.customSizeHeight(context, 0.2),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Ajustar meta', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary,),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
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
            'Considera reducir el gasto en alimentación',
              style: TextStyle(
                fontSize: AppSizes.customSizeHeight(context, 0.016),
                color: AppColors.textBlack,
              )
          ),
          SizedBox(height: AppSizes.customSizeHeight(context, 0.016)),
          Text(
            'Acción reomendada: Ajustar Presupuesto',
              style: TextStyle(
                fontSize: AppSizes.customSizeHeight(context, 0.016),
                color: AppColors.textBlack,
              )
          ),
        ],
      ),
    );

  }
}