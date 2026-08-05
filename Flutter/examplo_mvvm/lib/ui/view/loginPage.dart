import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';

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

  void _toggleRememberMe() => setState(() => _rememberMe = !_rememberMe);
  void _togglePasswordVisibility() => setState(() => _passwordVisible = !_passwordVisible);

  void _signIn() {}
  void _register() {}
  void _forgotPassword() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
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
                _FooterLink(onRegister: _register, theme: theme),
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
      children: [
        Icon(Icons.shield, size: 48, color: AppColors.primary),
        const SizedBox(height: 16),
        Text('Quietly Confident', style: AppTypography.headline),
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
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 18, offset: const Offset(0, 10)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bienvenido', style: AppTypography.title),
          const SizedBox(height: 8),
          Text('Inicia sesión para continuar', style: AppTypography.body),
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
              icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility, color: AppColors.muted),
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
                    Checkbox(value: rememberMe, onChanged: (_) => onRememberMeChanged(), activeColor: AppColors.primary),
                    Text('Recordar contraseña', style: AppTypography.label),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(onTap: onForgotPassword, child: Text('¿Olvidaste tu contraseña?', style: AppTypography.link)),
            ],
          ),
          const SizedBox(height: 24),
          _PrimaryButton(text: 'Iniciar Sesión', onPressed: onSignIn),
          const SizedBox(height: 24),
          const _DividerWithText(text: 'O continúa con'),
          const SizedBox(height: 20),
          _SocialButton(icon: Icons.g_mobiledata, text: 'Registrarse con Google', onPressed: onGoogleSignIn),
          const SizedBox(height: 16),
          Divider(color: AppColors.divider),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('¿No tienes una cuenta? ', style: AppTypography.body.copyWith(color: AppColors.muted)),
            GestureDetector(onTap: onSignIn, child: Text('Regístrate', style: AppTypography.link.copyWith(fontWeight: FontWeight.bold))),
          ]),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Políticas de Privacidad', style: AppTypography.caption),
            const SizedBox(width: 6),
            Text('·', style: AppTypography.caption),
            const SizedBox(width: 6),
            Text('Términos', style: AppTypography.caption),
          ]),
          const SizedBox(height: 12),
          Center(child: Text('© 2024 Quietly Confident. All rights reserved.', style: AppTypography.caption)),
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
        Text(label, style: AppTypography.label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(prefixIcon, color: AppColors.muted),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.fill,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), padding: const EdgeInsets.symmetric(vertical: 16)),
        child: Text(text, style: AppTypography.button),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.icon, required this.text, required this.onPressed});
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 26, color: AppColors.primary),
        label: Text(text, style: AppTypography.button.copyWith(color: AppColors.primary)),
        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), side: BorderSide(color: AppColors.border), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), backgroundColor: AppColors.fill),
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
        Expanded(child: Divider(color: AppColors.border, thickness: 1)),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: Text(text, style: AppTypography.muted)),
        Expanded(child: Divider(color: AppColors.border, thickness: 1)),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.onRegister, required this.theme});
  final VoidCallback onRegister;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onRegister,
          child: RichText(
            text: TextSpan(text: '¿No tienes una cuenta? ', style: AppTypography.body.copyWith(color: AppColors.muted), children: [TextSpan(text: 'Regístrate', style: AppTypography.link.copyWith(fontWeight: FontWeight.bold))]),
          ),
        ),
      ],
    );
  }
}
