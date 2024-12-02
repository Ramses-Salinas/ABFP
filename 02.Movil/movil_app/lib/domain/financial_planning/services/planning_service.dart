
import '../../../infrastructure/repositories/planning_respository.dart';
import '../entities/presupuesto.dart';

class PlanningService {
  final PlanningRepository planningRepository;

  PlanningService({required this.planningRepository});


  Future<Presupuesto> obtenerPresupuesto() async {
    await Future.delayed(Duration(milliseconds: 500));
    return Presupuesto(
      presupuestoMensual: 1500,
      presupuestoSemestral: 9000,
      presupuestoAnual: 18000,
      presupuestoPorCategoria: {"alimentación": 500, "salud": 300},
      metaAhorro: 2000,
      sugerencia: 'Ahorra 20% de tu ingreso mensual.',
    );
  }
}
