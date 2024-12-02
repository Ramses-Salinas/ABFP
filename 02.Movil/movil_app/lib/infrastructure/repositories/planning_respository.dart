
abstract class PlanningRepository {

  Future<void> crearPresupuesto(String gmail);
  Future<void> crearPreCat(String gmail);

  Future<Map<String, dynamic>> obtenerPresupuesto(String gmail);
  Future<Map<String, dynamic>> obtenerPreCat(String gmail);

  Future<void> actualizarBalance(String gmail, double nuevoBalance);
  Future<void> actualizarMetaAhorro(String gmail, double nuevaMeta);
  Future<void> actualizarPresupuestoPlazo(String gmail, double nuevoPresupuesto, String plazo);

//Future<void> eliminarTransaccion(String gmail, int id);


}
