import 'package:financial_app/application/providers/user_provider.dart';
import 'package:financial_app/domain/financial_planning/services/planning_service.dart';
import 'package:flutter/material.dart';

import '../../domain/financial_planning/entities/presupuesto.dart';

class PlanningProvider with ChangeNotifier {
  late Presupuesto _presupuesto;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  Presupuesto get presupuesto => _presupuesto;
  final PlanningService planningService;
  final UserProvider userProvider;

  PlanningProvider({required this.planningService, required this.userProvider}) {
    cargarPresupuesto();
  }

  Future<void> cargarPresupuesto() async {
    _isLoading = true;

    final String? gmail = userProvider.currentGmail;
    final presupuesto = await planningService.obtenerPresupuesto(gmail!);

    _presupuesto = presupuesto;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> crearPresupuesto(String gmail) async {

    await planningService.crearPresupuesto(gmail);

    notifyListeners();
  }

  Future<void> actualizarPresupuesto({
    double? mensual,
    double? semestral,
    double? anual,
    Map<String, double>? porCategoria,
    double? meta,
    String? sugerencia,
  }) async {
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

  Future<void> actualizarMetaAhorro(String gmail,double newGoal) async{

    await planningService.actualizarMetaAhorro(gmail, newGoal);
     _presupuesto.metaAhorro = newGoal;
    notifyListeners();
  }

  Future<void> actualizarPresupuestoPlazo(String gmail, double newBudget, String plazo) async {

    await planningService.actualizarPresupuestoPlazo(gmail, newBudget, plazo);

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
