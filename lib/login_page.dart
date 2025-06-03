// lib/pages/login_page.dart
import 'package:flutter/material.dart';
import 'doador/home_doador_screen.dart';
import 'receptor/home_receptor_screen.dart';
import '../fake_users.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  String? erroLogin;

  void _fazerLogin() {
    final email = emailController.text.trim();
    final senha = senhaController.text;

    final usuarioLogado = usuariosCadastrados.where(
      (user) => user.email == email && user.senha == senha,
    ).isNotEmpty
        ? usuariosCadastrados.firstWhere(
            (user) => user.email == email && user.senha == senha,
          )
        : null;

    if (usuarioLogado != null) {
      if (usuarioLogado.tipo == 'doador') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeDoadorScreen()),
        );
      } else if (usuarioLogado.tipo == 'receptor') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeReceptorScreen()),
        );
      }
    } else {
      setState(() {
        erroLogin = "Email ou senha inválidos!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = const Color(0xFF0a8449);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Container com sombra e borda arredondada para a imagem
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/integrador.jpg',
                    height: 280,
                    width: 280,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Text(
                'Connect Ong',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: baseColor,
                  shadows: [
                    Shadow(
                      color: baseColor.withOpacity(0.4),
                      offset: const Offset(2, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Caixa branca com sombra, bordas arredondadas para os campos
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: const Icon(Icons.email, color: Color(0xFF0a8449)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: baseColor, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelStyle: TextStyle(color: Colors.grey.shade600),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: baseColor,
                    ),
                    const SizedBox(height: 20),

                    TextField(
                      controller: senhaController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: const Icon(Icons.lock, color: Color(0xFF0a8449)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: baseColor, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelStyle: TextStyle(color: Colors.grey.shade600),
                      ),
                      cursorColor: baseColor,
                    ),
                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: baseColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 8,
                          shadowColor: baseColor.withOpacity(0.6),
                        ),
                        onPressed: _fazerLogin,
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ),

                    if (erroLogin != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          erroLogin!,
                          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
