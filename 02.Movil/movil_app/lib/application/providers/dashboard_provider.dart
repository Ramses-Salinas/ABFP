import 'package:flutter/material.dart';

import '../../domain/financial_analysis/entities/dashboard.dart';
import '../../domain/financial_analysis/services/dashboard_sevice.dart';

class DashboardProvider extends ChangeNotifier {
  late Dashboard _dashboard;
  bool _isLoading = true;

  Dashboard get dashboard => _dashboard;
  bool get isLoading => _isLoading;

  final DashboardService dashboardService;

  DashboardProvider({required this.dashboardService}) {
    cargarDashboard("Presupuesto vs Gasto Actual");
  }

  Future<void> cargarDashboard(String tipo) async {
    _isLoading = true;
    final dashboard = await dashboardService.obtenerDashboard(tipo);
    _dashboard = dashboard;
    _isLoading = false;
    notifyListeners();
  }

  void actualizarDatos(Map<String, dynamic> nuevosDatos) {
    _dashboard.inputs.addAll(nuevosDatos);
    _dashboard.procesarDatos();
    notifyListeners();
  }
}
