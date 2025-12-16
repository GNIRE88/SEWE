import 'package:flutter/material.dart';
import 'transactions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool validEmail(String v) =>
      RegExp(r'^[\w.+-]+@[\w.-]+\.[a-zA-Z]{2,}$').hasMatch(v);

  bool validPassword(String v) =>
      v.length >= 8 &&
      RegExp(r'[A-Z]').hasMatch(v) &&
      RegExp(r'[a-z]').hasMatch(v) &&
      RegExp(r'\d').hasMatch(v);

  List<String> namesFromEmail(String e) {
    final base = e.split('@')[0].replaceAll(RegExp(r'\d'), '');
    final parts = base.split('.');
    return [parts[0], parts.length > 1 ? parts[1] : ''];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 127, 96, 160), Color.fromARGB(255, 61, 108, 187)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Connexion",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 30),

                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (v) =>
                          validEmail(v ?? '') ? null : "Email invalide",
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Mot de passe",
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (v) => validPassword(v ?? '')
                          ? null
                          : "8 caractères, majuscule, minuscule et chiffre",
                    ),
                    const SizedBox(height: 30),

                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 400),
                      builder: (_, v, child) => Transform.scale(
                        scale: v,
                        child: child,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            final n = namesFromEmail(email.text.trim());
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TransactionsPage(
                                  firstName: n[0],
                                  lastName: n[1],
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text("Se connecter"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
