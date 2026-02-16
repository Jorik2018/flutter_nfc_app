import 'package:flutter/material.dart';
import 'package:flutter_nfc_app/screens/home_tab.dart';
import 'package:flutter_nfc_app/screens/wallet_tab.dart';
import 'package:flutter_nfc_app/screens/settings_tab.dart';

import 'screens/LoginScreen.dart';
import 'screens/UserScreen.dart';

void main() {
  runApp(const TransporteApp());
}

class TransporteApp extends StatelessWidget {
  const TransporteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transporte Chimbote NFC',
      /*theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),*/
      theme: ThemeData(
        primaryColor: Color(0xFF00B8D4), // Color principal similar al logo
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// 3. PANTALLA DE VERIFICACIÓN DE IDENTIDAD
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
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const UserScreen()),
      (route) => false,
    );
  }
}

class UserScreen2 extends StatefulWidget {
  const UserScreen2({super.key});

  @override
  State<UserScreen2> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen2> {
  final double balance = 1250.50;

  final List<Transaction> transactions = [
    Transaction('Starbucks', -125.00, '202 / 0.213', 'assets/starbucks.png'),
    Transaction(
        'Supermercado Plz.', -125.00, '201 / 1M', 'assets/supermarket.png'),
    Transaction(
        'Supermercado Plaza', -125.00, '201 / 0.229', 'assets/supermarket.png'),
    Transaction('Recarga Transporte', 15.00, '201 / 0.190', 'assets/bus.png'),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo principal
      body: Stack(
        children: [
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 40), // espacio para centrar logo
                      Image.asset(
                        'assets/logo.png',
                        height: 42, // ajusta según el diseño
                        fit: BoxFit.contain,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/user.png'),
                        radius: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Hola, [Nombre Usuario]',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                //todo eso debe ser scrolable, no la lista de ListView.builder
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: _buildCurrentTab(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 64,
          decoration: const BoxDecoration(
            color: Colors.white,
            /*
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      */
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navIcon(Icons.home, 0),
              _navIcon(Icons.account_balance_wallet, 1),
              _navIcon(Icons.settings, 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentTab() {
    switch (_currentIndex) {
      case 0:
        return HomeTab(
          balance: balance,
          transactions: transactions,
        );
      case 1:
        return const WalletTab();
      case 2:
        return const SettingsTab();
      default:
        return const SizedBox();
    }
  }

  Widget _navIcon(IconData icon, int index) {
    final bool selected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF00B8D4).withOpacity(0.15)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 26,
          color: selected ? const Color(0xFF00B8D4) : Colors.grey,
        ),
      ),
    );
  }
}
