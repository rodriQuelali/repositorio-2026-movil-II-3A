import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../chat_list_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nombreController = TextEditingController();
  bool _esRegistro = false;

  void _submit() async {
    final authVM = context.read<AuthViewModel>();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final nombre = _nombreController.text.trim();

    if (email.isEmpty || password.isEmpty || (_esRegistro && nombre.isEmpty)) return;

    final exito = _esRegistro
        ? await authVM.registro(email, password, nombre)
        : await authVM.login(email, password);

    if (exito && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ChatListView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text(_esRegistro ? 'Crear Cuenta' : 'Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_esRegistro)
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre Completo'),
              ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo Electrónico'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (authVM.error != null)
              Text(authVM.error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 10),
            authVM.cargando
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submit,
                    child: Text(_esRegistro ? 'Registrarse' : 'Ingresar'),
                  ),
            TextButton(
              onPressed: () => setState(() => _esRegistro = !_esRegistro),
              child: Text(_esRegistro
                  ? '¿Ya tienes cuenta? Inicia sesión'
                  : '¿No tienes cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}