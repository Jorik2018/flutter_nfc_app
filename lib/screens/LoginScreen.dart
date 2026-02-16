import 'package:flutter/material.dart';

import 'UserScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _rememberMe = false;

  Widget _socialCircle(String asset) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black12,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Center(
        child: Image.asset(asset, height: 22),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D1B2A),
              Color(0xFF1B263B),
              Color(0xFF415A77),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 25),

              /// LOGO
              Image.asset(
                'assets/logo.png',
                height: 42,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 25),

              /// TITULO SOBRE EL FONDO OSCURO
              const Text(
                "Iniciar Sesión",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 30),

              /// TARJETA BLANCA
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(22, 30, 22, 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF4F6F8),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        /// EMAIL
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Correo Electrónico",
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.email_outlined),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 18),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        /// PASSWORD
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: "Contraseña",
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 18),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// OLVIDASTE CONTRASEÑA
                        Center(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero, // elimina padding extra
                              minimumSize: Size.zero, // evita espacio adicional
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {},
                            child: const Text(
                              "¿Olvidaste tu contraseña?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF1976D2),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),

                        /// BOTON ENTRAR
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 260, // ancho máximo del botón
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1976D2),
                                  foregroundColor:
                                      Colors.white, // 👈 texto blanco
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "ENTRAR",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          "o inicia sesión con",
                          style: TextStyle(color: Colors.black54),
                        ),

                        const SizedBox(height: 16),

                        /// ICONOS SOCIALES
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialCircle("assets/google.png"),
                            const SizedBox(width: 18),
                            _socialCircle("assets/facebook.png"),
                          ],
                        ),

                        const SizedBox(height: 24),

                        /// REGISTRO
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "¿No tienes cuenta? Regístrate.",
                            style: TextStyle(
                              color: Color(0xFF1976D2),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    // Validar credenciales
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, complete todos los campos'),
        ),
      );
      return;
    }

    // Simular login exitoso
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const UserScreen(),
      ),
    );
  }
}
