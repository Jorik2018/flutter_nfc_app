import 'package:flutter/material.dart';


class HomeTab extends StatelessWidget {
  final double balance;
  final List transactions;

  const HomeTab({
    super.key,
    required this.balance,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ===== BALANCE =====
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Saldo Disponible',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                const SizedBox(height: 6),
                Text(
                  'S/ ${balance.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text('Moneda Preferida',
                    style: TextStyle(color: Colors.grey[600], fontSize: 10)),
              ],
            ),
          ),

          // ===== BOTONES =====
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(Icons.send, 'Enviar'),
                _buildActionButton(Icons.call_received, 'Recibir'),
                _buildActionButton(Icons.refresh, 'Recargar'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ===== TÍTULO =====
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Text(
              'Pagos Recientes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 8),

          // ===== LISTA SIN SCROLL =====
          Column(
            children: transactions
                .map((tx) => _buildTransactionItem(tx))
                .toList(),
          ),

          const SizedBox(height: 24),
        ],
      );
  }

  Widget _buildTransactionItem(Transaction tx) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: AssetImage(tx.icon), radius: 20, backgroundColor: Colors.transparent),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx.name, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(tx.date, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              ],
            ),
          ),
          Text(
            (tx.amount < 0 ? '- ' : '+ ') + 'S/ ${tx.amount.abs().toStringAsFixed(2)}',
            style: TextStyle(color: tx.amount < 0 ? Colors.red : Colors.green, fontWeight: FontWeight.bold),
          ),
        ],
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

}

class Transaction {
  final String name;
  final double amount;
  final String date;
  final String icon;

  Transaction(this.name, this.amount, this.date, this.icon);
}
