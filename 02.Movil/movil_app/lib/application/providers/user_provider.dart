import 'package:flutter/material.dart';

import '../../domain/user_management/services/user_service.dart';
import '../../domain/user_management/entities/user.dart';


class UserProvider with ChangeNotifier {
  bool _isLoading = true;
  final UserService userService;
  bool get isLoading => _isLoading;
  User? _currentUser;

  User? get currentUser => _currentUser;
  String? get currentGmail => _currentUser?.gmail;

  UserProvider({required this.userService});

  Future<void> loadUser(String gmail) async {

    _isLoading = true;
    try {
      _currentUser = await userService.obtenerUsuario(gmail);
      print("Usuario cargado: $_currentUser");
    } catch (e) {
      print("Error al cargar el usuario: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addUser({
    required String gmail,
    required String name,
    required String password,
  }) async {
    final newUser = userService.crearUsuario(
      gmail: gmail,
      nombre: name,
      password: password
    );

    await userService.registrarUsuario(newUser);
    loadUser(gmail);

  }

  Future<void> updateUser(User updatedUser) async {

    await userService.actualizarUsuario(updatedUser);

    loadUser(updatedUser.gmail);

  }

  Future<void> authUser(String gmail, String password) async {

    try {
      final user = await userService.autenticarUsuario(gmail, password);
      _currentUser = user;
      loadUser(gmail);
    } catch (e) {
      print("Error al cargar el usuario: $e");
    }
  }



}
