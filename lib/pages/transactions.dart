import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'details.dart';

class TransactionsPage extends StatelessWidget {
  final String firstName, lastName;

  TransactionsPage({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  final List<Transaction> transactions = [
    Transaction("Restaurant", 8500, DateTime.now(), "Déjeuner"),
    Transaction("Internet", 25000,
        DateTime.now().subtract(const Duration(days: 1)), "Abonnement"),
    Transaction("Transport", 3000,
        DateTime.now().subtract(const Duration(days: 2)), "Taxi"),
    Transaction("Shopping", 45000,
        DateTime.now().subtract(const Duration(days: 3)), "Vêtements"),
    Transaction("Électricité", 18000,
        DateTime.now().subtract(const Duration(days: 4)), "Facture"),
    Transaction("Cinéma", 5000,
        DateTime.now().subtract(const Duration(days: 5)), "Sortie"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2575FC), Color(0xFF6A11CB)],
            ),
          ),
        ),
        title: const Text("Transactions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bonjour ${firstName}${lastName.isNotEmpty ? ' $lastName' : ''} 👋",
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (_, i) => TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(milliseconds: 300 + i * 100),
                  builder: (_, v, child) => Opacity(
                    opacity: v,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - v)),
                      child: child,
                    ),
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      title: Text(transactions[i].title),
                      subtitle:
                          Text("${transactions[i].amount} FCFA"),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TransactionDetailsPage(
                            transaction: transactions[i],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
