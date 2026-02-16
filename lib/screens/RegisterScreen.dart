import 'package:flutter/material.dart';

import 'IdentityVerificationScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cuenta'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Información
            const Text(
              'Registro de Cuenta',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Complete sus datos para crear una cuenta',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // Campos del formulario
            _buildTextField(
                _nameController, 'Nombres y Apellidos', Icons.person),
            const SizedBox(height: 15),
            _buildTextField(
                _emailController, 'Correo electrónico', Icons.email),
            const SizedBox(height: 15),
            _buildTextField(_phoneController, 'Teléfono', Icons.phone),
            const SizedBox(height: 15),
            _buildTextField(_dniController, 'DNI', Icons.badge),
            const SizedBox(height: 15),
            _buildTextField(_passwordController, 'Contraseña', Icons.lock,
                isPassword: true),
            const SizedBox(height: 15),
            _buildTextField(_confirmPasswordController, 'Confirmar Contraseña',
                Icons.lock_outline,
                isPassword: true),
            const SizedBox(height: 20),
            // Términos y condiciones
            Row(
              children: [
                Checkbox(
                  value: _acceptTerms,
                  onChanged: (value) {
                    setState(() {
                      _acceptTerms = value!;
                    });
                  },
                ),
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'Acepto los '),
                        TextSpan(
                          text: 'términos y condiciones',
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextSpan(text: ' y la '),
                        TextSpan(
                          text: 'política de privacidad',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Botón de Registro
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _acceptTerms ? _register : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2ECC71),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'REGISTRARSE',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Ya tengo cuenta
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _register() {
    if (_validateForm()) {
      // Navegar a verificación de identidad
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const IdentityVerificationScreen(),
        ),
      );
    }
  }

  bool _validateForm() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _dniController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, complete todos los campos'),
        ),
      );
      return false;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Las contraseñas no coinciden'),
        ),
      );
      return false;
    }

    return true;
  }
}
