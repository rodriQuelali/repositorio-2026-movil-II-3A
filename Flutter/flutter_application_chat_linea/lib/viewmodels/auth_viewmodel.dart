import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();

  bool _cargando = false;
  bool get cargando => _cargando;

  String? _error;
  String? get error => _error;

  User? get usuario => _repository.usuarioActual;

  Future<bool> login(String email, String password) async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.iniciarSesion(email: email, password: password);
      _cargando = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _cargando = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> registro(String email, String password, String nombre) async {
    _cargando = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.registrarse(email: email, password: password, nombre: nombre);
      _cargando = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _cargando = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _repository.cerrarSesion();
    notifyListeners();
  }
}