import 'package:examplo_mvvm/models/User.dart';
import 'package:examplo_mvvm/repository/auth_repository.dart';
import 'package:flutter/material.dart';


class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Lógica de Login
  Future<bool> login(String correo, String contrasena) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final user = await _repository.login(correo, contrasena);
      if (user != null) {
        _currentUser = user;
        _setLoading(false);
        return true; // Login exitoso
      } else {
        _errorMessage = 'Correo o contraseña incorrectos';
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error al iniciar sesión: $e';
      _setLoading(false);
      return false;
    }
  }

  // Lógica de Registro
  Future<bool> register(UserModel user) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      await _repository.registerUser(user);
      _setLoading(false);
      return true; // Registro exitoso
    } catch (e) {
      // Si el correo ya existe, SQLite lanza una excepción por la regla UNIQUE
      if (e.toString().contains('UNIQUE constraint failed')) {
        _errorMessage = 'Este correo ya está registrado';
      } else {
        _errorMessage = 'Error al registrar: $e';
      }
      _setLoading(false);
      return false;
    }
  }

  // Lógica de Cerrar Sesión
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}