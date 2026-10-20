import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase/supabase_client.dart';

class AuthRepository {
  final SupabaseClient _client = SupabaseService.client;

  User? get usuarioActual => _client.auth.currentUser;

  Future<AuthResponse> iniciarSesion({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> registrarse({
    required String email,
    required String password,
    required String nombre,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user != null) {
      await _client.from('perfiles').insert({
        'id': response.user!.id,
        'nombre': nombre,
        'correo': email,
      });
    }

    return response;
  }

  Future<void> cerrarSesion() async {
    await _client.auth.signOut();
  }
}