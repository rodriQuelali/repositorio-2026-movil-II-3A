import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _passwordVisible = false;

  void _toggleRememberMe() {
    setState(() {
      _rememberMe = !_rememberMe;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _signIn() {
    // Aquí va la lógica de inicio de sesión o el llamado al ViewModel.
  }

  void _register() {
    // Navegar a la pantalla de registro.
  }

  void _forgotPassword() {
    // Navegar a la pantalla de recuperación de contraseña.
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7EFE0),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                const _LoginHeader(),
                const SizedBox(height: 24),
                _LoginCard(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  rememberMe: _rememberMe,
                  passwordVisible: _passwordVisible,
                  onRememberMeChanged: _toggleRememberMe,
                  onPasswordVisibilityChanged: _togglePasswordVisibility,
                  onSignIn: _signIn,
                  onForgotPassword: _forgotPassword,
                  onGoogleSignIn: () {},
                ),
                const SizedBox(height: 20),
                _FooterLink(
                  onRegister: _register,
                  theme: theme,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Icon(
          Icons.shield,
          size: 48,
          color: Color(0xFF2B7A69),
        ),
        SizedBox(height: 16),
        Text(
          'Quietly Confident',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E3931),
          ),
        ),
      ],
    );
  }
}

class _LoginCard extends StatelessWidget {
  const _LoginCard({
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.passwordVisible,
    required this.onRememberMeChanged,
    required this.onPasswordVisibilityChanged,
    required this.onSignIn,
    required this.onForgotPassword,
    required this.onGoogleSignIn,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final bool passwordVisible;
  final VoidCallback onRememberMeChanged;
  final VoidCallback onPasswordVisibilityChanged;
  final VoidCallback onSignIn;
  final VoidCallback onForgotPassword;
  final VoidCallback onGoogleSignIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bienvenido',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3931),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Inicia sesión para continuar',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF6B7D77),
            ),
          ),
          const SizedBox(height: 24),
          _AuthTextField(
            controller: emailController,
            label: 'Correo Electrónico',
            hintText: 'ejemplo@correo.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _AuthTextField(
            controller: passwordController,
            label: 'Contraseña',
            hintText: '********',
            prefixIcon: Icons.lock_outline,
            obscureText: !passwordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                passwordVisible ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFF6B7D77),
              ),
              onPressed: onPasswordVisibilityChanged,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                onTap: onRememberMeChanged,
                child: Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (_) => onRememberMeChanged(),
                      activeColor: const Color(0xFF2B7A69),
                    ),
                    const Text(
                      'Recordar contraseña',
                      style: TextStyle(
                        color: Color(0xFF1E3931),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onForgotPassword,
                child: const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    color: Color(0xFFDE5F4B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _PrimaryButton(
            text: 'Iniciar Sesión',
            onPressed: onSignIn,
          ),
          const SizedBox(height: 24),
          const _DividerWithText(text: 'O continúa con'),
          const SizedBox(height: 20),
          _SocialButton(
            icon: Icons.g_mobiledata,
            text: 'Registrarse con Google',
            onPressed: onGoogleSignIn,
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFEBE4D7)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿No tienes una cuenta? '),
              GestureDetector(
                onTap: onSignIn,
                child: const Text(
                  'Regístrate',
                  style: TextStyle(
                    color: Color(0xFFDE5F4B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Políticas de Privacidad',
                style: TextStyle(color: Color(0xFF9AA9A1)),
              ),
              SizedBox(width: 6),
              Text('·', style: TextStyle(color: Color(0xFF9AA9A1))),
              SizedBox(width: 6),
              Text(
                'Términos',
                style: TextStyle(color: Color(0xFF9AA9A1)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              '© 2024 Quietly Confident. All rights reserved.',
              style: TextStyle(
                color: Color(0xFF9AA9A1),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
    required this.controller,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E3931),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(prefixIcon, color: const Color(0xFF6B7D77)),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: const Color(0xFFF8F4EA),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2B7A69),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 26, color: const Color(0xFF2B7A69)),
        label: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF2B7A69),
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: Color(0xFFE2D8C7)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: const Color(0xFFF8F4EA),
        ),
      ),
    );
  }
}

class _DividerWithText extends StatelessWidget {
  const _DividerWithText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE2D8C7), thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            text,
            style: const TextStyle(color: Color(0xFF6B7D77)),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE2D8C7), thickness: 1)),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({
    required this.onRegister,
    required this.theme,
  });

  final VoidCallback onRegister;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onRegister,
          child: RichText(
            text: TextSpan(
              text: '¿No tienes una cuenta? ',
              style: theme.textTheme.bodyMedium?.copyWith(color: const Color(0xFF6B7D77)),
              children: const [
                TextSpan(
                  text: 'Regístrate',
                  style: TextStyle(
                    color: Color(0xFFDE5F4B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
