
import 'package:financial_app/infrastructure/repositories/dashboard_repository.dart';

import '../entities/dashboard.dart';

class DashboardService {

  final DashboardRepository dashboardRepository;

  DashboardService({required this.dashboardRepository});

  Future<Dashboard> obtenerDashboard(String tipo) async {
    await Future.delayed(const Duration(milliseconds: 500));

    switch (tipo) {
      case "Presupuesto vs Gasto Actual":
        return Dashboard(
          descripcion: "Compara los presupuestos con los gastos actuales.",
          tipo: tipo,
          inputs: {
            "categorias": [
              {"nombre": "Alimentación", "presupuesto": 500, "gasto": 200},
              {"nombre": "Vestuario", "presupuesto": 300, "gasto": 200},
              {"nombre": "Deporte", "presupuesto": 150, "gasto": 100},
            ]
          },

        );

      case "Gasto Mensual":
        return Dashboard(
          descripcion: 'Visualización de ingresos y gastos totales en el mes seleccionado.',
          tipo: tipo,
          inputs: {
            'meses': {
              'Enero': [
                {'nombre': 'Alimentación', 'ingreso': 800, 'gasto': 500},
                {'nombre': 'Vestuario', 'ingreso': 600, 'gasto': 300},
                {'nombre': 'Transporte', 'ingreso': 400, 'gasto': 450},
              ],
              'Febrero': [
                {'nombre': 'Alimentación', 'ingreso': 900, 'gasto': 550},
                {'nombre': 'Vestuario', 'ingreso': 700, 'gasto': 350},
                {'nombre': 'Transporte', 'ingreso': 500, 'gasto': 400},
              ],
              'Marzo': [
                {'nombre': 'Alimentación', 'ingreso': 850, 'gasto': 600},
                {'nombre': 'Vestuario', 'ingreso': 650, 'gasto': 300},
                {'nombre': 'Transporte', 'ingreso': 450, 'gasto': 450},
              ],
            },
          },
        );

      case "Ahorro vs Objetivo":
        return Dashboard(
          descripcion: 'Progreso hacia el objetivo de ahorro planificado.',
          tipo: tipo,
          inputs: {
            'meta': 5000,
            'saldoActual': 2000,
          },
        );
      default:
        throw Exception("Tipo de dashboard no soportado");
    }
  }


  Future<Dashboard> obtenerDashboard2(String gmail) async {
    try {
      final Map<String, dynamic> dashboard = await dashboardRepository.obtenerDashboard(gmail);
      return Dashboard(
        descripcion: dashboard['Descripcion'],
        tipo: dashboard['Tipo'],
        inputs: dashboard['Inputs'],
      );

    } catch (e) {
      throw Exception('Error al reconstruir useres: $e');
    }
  }


}