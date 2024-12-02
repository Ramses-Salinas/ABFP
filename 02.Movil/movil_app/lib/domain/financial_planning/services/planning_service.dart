
import 'dart:ffi';

import '../../../infrastructure/repositories/planning_respository.dart';
import '../entities/presupuesto.dart';

class PlanningService {
  final PlanningRepository planningRepository;

  PlanningService({required this.planningRepository});

  Future<void> crearPresupuesto(String gmail) async {
    await planningRepository.crearPresupuesto(gmail);
    await planningRepository.crearPreCat(gmail);
  }

  Future<Presupuesto> obtenerPresupuesto(String gmail) async {

    final Map<String, dynamic> presupuesto = await planningRepository.obtenerPresupuesto(gmail);
    final Map<String, dynamic> precat = await planningRepository.obtenerPreCat(gmail);


    return Presupuesto(
      balance: (presupuesto['Balanza_actual_real'] as num?)?.toDouble() ?? 0.0,
      presupuestoMensual: (precat['Categoria_mensual'] as num?)?.toDouble() ?? 0.0,
      presupuestoSemestral: (precat['Categoria_semestral'] as num?)?.toDouble() ?? 0.0,
      presupuestoAnual: (precat['Categoria_anual'] as num?)?.toDouble() ?? 0.0,
      presupuestoPorCategoria: {"alimentación": 500.0, "salud": 300.0},
      metaAhorro: (presupuesto['Meta_ahorro'] as num?)?.toDouble() ?? 0.0,
      sugerencia: presupuesto['Sugerencia'] ?? 'Sin sugerencia',
    );


  }



  Future<void> actualizarMetaAhorro(String gmail, double nuevaMeta) async {
    await planningRepository.actualizarMetaAhorro(gmail, nuevaMeta);
  }
  Future<void> actualizarPresupuestoPlazo(String gmail, double nuevaMeta, String plazo) async {
    await planningRepository.actualizarPresupuestoPlazo(gmail, nuevaMeta, plazo);
  }
}
