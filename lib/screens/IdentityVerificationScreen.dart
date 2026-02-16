import 'package:flutter/material.dart';

import 'UserScreen.dart';

class IdentityVerificationScreen extends StatefulWidget {
  const IdentityVerificationScreen({super.key});

  @override
  State<IdentityVerificationScreen> createState() =>
      _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState
    extends State<IdentityVerificationScreen> {
  int _currentStep = 0;
  final List<Map<String, dynamic>> _verificationSteps = [
    {
      'title': 'Verificación de DNI',
      'description': 'Toma una foto frontal de tu DNI',
      'icon': Icons.card_membership,
    },
    {
      'title': 'Selfie de Confirmación',
      'description': 'Toma una selfie para verificar tu identidad',
      'icon': Icons.face,
    },
    {
      'title': 'Confirmación Final',
      'description': 'Revisa y confirma tu información',
      'icon': Icons.verified,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificación de Identidad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progreso
            LinearProgressIndicator(
              value: (_currentStep + 1) / _verificationSteps.length,
              backgroundColor: Colors.grey[300],
              color: const Color(0xFF3498DB),
            ),
            const SizedBox(height: 30),
            // Paso actual
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Icon(
                    _verificationSteps[_currentStep]['icon'],
                    size: 60,
                    color: const Color(0xFF3498DB),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _verificationSteps[_currentStep]['title'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _verificationSteps[_currentStep]['description'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Instrucciones
            if (_currentStep == 0)
              _buildStep1Content()
            else if (_currentStep == 1)
              _buildStep2Content()
            else
              _buildStep3Content(),
            const Spacer(),
            // Botones de navegación
            Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _currentStep--;
                        });
                      },
                      child: const Text('ATRÁS'),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentStep < _verificationSteps.length - 1) {
                        setState(() {
                          _currentStep++;
                        });
                      } else {
                        // Finalizar verificación
                        _completeVerification();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3498DB),
                    ),
                    child: Text(
                      _currentStep < _verificationSteps.length - 1
                          ? 'CONTINUAR'
                          : 'FINALIZAR',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep1Content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Instrucciones:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildInstruction('1. Asegúrate de estar en un lugar bien iluminado'),
        _buildInstruction('2. Coloca tu DNI sobre una superficie plana'),
        _buildInstruction('3. Toma una foto nítida del frente de tu DNI'),
        _buildInstruction('4. Evita reflejos y sombras'),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton.icon(
            onPressed: () {
              // Tomar foto del DNI
            },
            icon: const Icon(Icons.camera_alt),
            label: const Text('TOMAR FOTO DEL DNI'),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2Content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Instrucciones:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildInstruction('1. Asegúrate de tener buena iluminación'),
        _buildInstruction('2. Mira directamente a la cámara'),
        _buildInstruction('3. Retira accesorios que cubran tu rostro'),
        _buildInstruction('4. Mantén una expresión neutral'),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton.icon(
            onPressed: () {
              // Tomar selfie
            },
            icon: const Icon(Icons.face),
            label: const Text('TOMAR SELFIE'),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3Content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Información para confirmar:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        _buildInfoItem('Nombre completo', 'Juan Pérez Rodríguez'),
        _buildInfoItem('DNI', '12345678'),
        _buildInfoItem('Email', 'juan.perez@email.com'),
        _buildInfoItem('Teléfono', '+51 987 654 321'),
        const SizedBox(height: 20),
        Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 10),
            Expanded(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: 'Acepto que mis datos sean verificados '),
                    TextSpan(
                      text: 'según la política de privacidad',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'La verificación puede tardar hasta 24 horas. '
          'Recibirás una notificación cuando sea completada.',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildInstruction(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text('• $text'),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  void _completeVerification() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verificación enviada para revisión'),
      ),
    );
    /*Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const UserScreen()),
      (route) => false,
    );*/
  }
}
