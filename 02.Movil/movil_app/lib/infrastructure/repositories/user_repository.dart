
import '../../domain/user_management/entities/user.dart';

abstract class UserRepository {

  Future<void> crearUsuario(User usuario);
  Future<void> actualizarUsuario(User usuario);
  Future<void> eliminarUsuario(String gmail, int id);
  Future<Map<String, dynamic>> obtenerUsuario(String gmail);
  Future<Map<String, dynamic>> autenticarUsuario(String gmail, String password);
}
