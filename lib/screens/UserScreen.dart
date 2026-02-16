import 'package:flutter/material.dart';

import 'home_tab.dart';
import 'settings_tab.dart';
import 'wallet_tab.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.grey[200],
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: _buildCurrentTab(),
                        ),
                      ),
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

  Widget _buildActionButton(IconData icon, String label) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF00B8D4),
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 22,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Transaction tx) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
              backgroundImage: AssetImage(tx.icon),
              radius: 20,
              backgroundColor: Colors.transparent),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx.name, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(tx.date,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              ],
            ),
          ),
          Text(
            (tx.amount < 0 ? '- ' : '+ ') +
                'S/ ${tx.amount.abs().toStringAsFixed(2)}',
            style: TextStyle(
                color: tx.amount < 0 ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
