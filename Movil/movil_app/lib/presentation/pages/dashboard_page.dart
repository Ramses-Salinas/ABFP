import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../themes/app_colors.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Dashboard',style: Theme.of(context).textTheme.displayLarge,)),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              hint: const Text('Presupuesto', style: TextStyle(color: AppColors.textSecondary)),
              items: <String>['Presupuesto', 'Gasto Mensual', 'Resumen General']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(color: AppColors.textPrimary)),
                );
              }).toList(),
              onChanged: (String? value) {},
              dropdownColor: AppColors.secondary,
            ),
            SizedBox(height: 20),
            const Text('Presupuesto vs Gasto Actual', style: TextStyle(color: AppColors.textPrimary, fontSize: 20)),
            SizedBox(height: 10),
            Container(
              height: 250,
              child: BarChart(
                BarChartData(
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(showTitles: true),
                    bottomTitles: SideTitles(showTitles: true, reservedSize: 38),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(
                        y: 300,
                        colors: [Colors.greenAccent],
                      ),
                      BarChartRodData(
                        y: 500,
                        colors: [Colors.redAccent],
                      ),
                    ]),
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(
                        y: 200,
                        colors: [Colors.greenAccent],
                      ),
                      BarChartRodData(
                        y: 400,
                        colors: [Colors.redAccent],
                      ),
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(
                        y: 500,
                        colors: [Colors.greenAccent],
                      ),
                      BarChartRodData(
                        y: 600,
                        colors: [Colors.redAccent],
                      ),
                    ]),
                    BarChartGroupData(x: 3, barRods: [
                      BarChartRodData(
                        y: 150,
                        colors: [Colors.greenAccent],
                      ),
                      BarChartRodData(
                        y: 300,
                        colors: [Colors.redAccent],
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Gastos por categoría', style: TextStyle(color: AppColors.textPrimary, fontSize: 20)),
            SizedBox(height: 10),
            expenseCategory('Alimentación', 50, 100),
            expenseCategory('Vestuario', 50, 100),
            expenseCategory('Deporte', 50, 100),
            expenseCategory('Medicina', 50, 100),
            expenseCategory('Otros', 50, 100),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget expenseCategory(String title, double spent, double total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title', style: TextStyle(color: AppColors.textPrimary)),
        SizedBox(height: 5),
        Container(
          height: 10,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.lightPrimary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            widthFactor: spent / total,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Text('S/ $spent / S/ $total', style: TextStyle(color: AppColors.textSecondary)),
        SizedBox(height: 15),
      ],
    );
  }
}


