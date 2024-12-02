
import 'package:financial_app/infrastructure/repositories/user_repository.dart';

import '../entities/user.dart';

class UserService {
  final UserRepository userRepository;

  UserService({required this.userRepository});


  User crearUsuario({
    required String nombre,
    required String gmail,
    required String password,

  }) {

    return User(
      gmail: gmail,
      nombre: nombre,
      contrasenia: password,

    );
  }



  Future<void> registrarUsuario(User user) async {
    await userRepository.crearUsuario(user);
  }

  Future<void> actualizarUsuario(User user) async {
    await userRepository.actualizarUsuario(user);
  }

  Future<void> eliminarUsuario(String gmail, int id) async {
    await userRepository.eliminarUsuario(gmail, id);
  }

  Future<User> obtenerUsuario(String gmail) async {
    try {
      final Map<String, dynamic> user = await userRepository.obtenerUsuario(gmail);
        return User(
          gmail: user['Gmail'],
          nombre: user['Nombre'],
          contrasenia: user['Pasword'],
        );

    } catch (e) {
      throw Exception('Error al reconstruir useres: $e');
    }
  }

  Future<User> autenticarUsuario(String gmail, String password) async {
    try {
      final Map<String, dynamic> user = await userRepository.autenticarUsuario(gmail,password);
      return User(
        gmail: user['Gmail'],
        nombre: user['Nombre'],
        contrasenia: user['Pasword'],
      );

    } catch (e) {
      throw Exception('Error al reconstruir useres: $e');
    }
  }

}