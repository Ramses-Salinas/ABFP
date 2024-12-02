import 'package:financial_app/domain/financial_planning/services/planning_service.dart';
import 'package:flutter/material.dart';

import '../../domain/financial_planning/entities/presupuesto.dart';

class PresupuestoProvider with ChangeNotifier {
  late Presupuesto _presupuesto = Presupuesto(
    presupuestoMensual: 0,
    presupuestoSemestral: 0,
    presupuestoAnual: 0,
    presupuestoPorCategoria: {},
    metaAhorro: 0,
    sugerencia: '',
  );

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  Presupuesto get presupuesto => _presupuesto;
  final PlanningService planningService;

  PresupuestoProvider({required this.planningService}) {
    cargarPresupuesto();
  }

  Future<void> cargarPresupuesto() async {
    _isLoading = true;
    final presupuesto = await planningService.obtenerPresupuesto();

    _presupuesto = presupuesto;
    _isLoading = false;
    notifyListeners();
  }

  void actualizarPresupuesto({
    double? mensual,
    double? semestral,
    double? anual,
    Map<String, double>? porCategoria,
    double? meta,
    String? sugerencia,
  }) {
    if (mensual != null) _presupuesto.presupuestoMensual = mensual;
    if (semestral != null) _presupuesto.presupuestoSemestral = semestral;
    if (anual != null) _presupuesto.presupuestoAnual = anual;
    if (porCategoria != null) _presupuesto.presupuestoPorCategoria = porCategoria;
    if (meta != null) _presupuesto.metaAhorro = meta;
    if (sugerencia != null) _presupuesto.sugerencia = sugerencia;

    notifyListeners();
  }

  void agregarCategoria(String categoria, double monto) {
    _presupuesto.presupuestoPorCategoria[categoria] = monto;
    notifyListeners();
  }

  void eliminarCategoria(String categoria) {
    _presupuesto.presupuestoPorCategoria.remove(categoria);
    notifyListeners();
  }

  void actualizarMetaAhorro(double newGoal) {

    _presupuesto.metaAhorro = newGoal;
    notifyListeners();
  }

  void actualizarPresupuestoPlazo(double newBudget, String plazo) {

    switch(plazo){
      case "Corto plazo":
        _presupuesto.presupuestoMensual = newBudget;
        break;
      case "Mediano plazo":
        _presupuesto.presupuestoSemestral = newBudget;
        break;
      case "Largo plazo":
        _presupuesto.presupuestoAnual = newBudget;
        break;
    }

    notifyListeners();
  }
  
}
