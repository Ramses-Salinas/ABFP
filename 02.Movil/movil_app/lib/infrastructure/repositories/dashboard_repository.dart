

abstract class DashboardRepository {

  //Future<void> crearTransaccion(Transaction transaccion);
  //Future<void> actualizarTransaccion(Transaction transaccion);
  //Future<void> eliminarTransaccion(String gmail, int id);
  Future<Map<String, dynamic>> obtenerDashboard(String gmail);

}
