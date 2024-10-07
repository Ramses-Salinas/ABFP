import '../value_objects/account.dart';

class Usuario {
  final int idUsuario;
  final String nombre;
  final String email;
  final String contrasenia;
  final Cuenta cuenta;

  Usuario({
    required this.idUsuario,
    required this.nombre,
    required this.email,
    required this.contrasenia,
    required this.cuenta,
  });
}
