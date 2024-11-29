import '../../domain/user_management/entities/user.dart';
import '../../infrastructure/repositories/user_repository.dart';
/*
class AuthService {
  final UsuarioRepository usuarioRepository;

  AuthService({required this.usuarioRepository});

  Future<Usuario> registrarUsuario({
    required String nombre,
    required String email,
    required String password,
  }) async {
    final usuarioExistente = await usuarioRepository.obtenerPorEmail(email);
    if (usuarioExistente != null) {
      throw Exception('El email ya está registrado.');
    }

    final nuevoUsuario = Usuario.registrar(
      nombre: nombre,
      email: email,
      passwordPlano: password,
    );

    await usuarioRepository.guardar(nuevoUsuario);

    return nuevoUsuario;
  }

  Future<Usuario> iniciarSesion({
    required String email,
    required String password,
  }) async {
    final usuario = await usuarioRepository.obtenerPorEmail(email);
    if (usuario == null) {
      throw Exception('Usuario no encontrado.');
    }

    if (!usuario.verificarPassword(password)) {
      throw Exception('Contraseña incorrecta.');
    }

    return usuario;
  }
}

 */

