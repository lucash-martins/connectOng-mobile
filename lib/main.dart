import 'package:flutter/material.dart';
import 'doador/home_doador_screen.dart';
import 'receptor/home_receptor_screen.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connect Ong',
      theme: ThemeData(
        primaryColor: const Color(0xFF0a8449),
        scaffoldBackgroundColor: const Color(0xFFa8dbc1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0a8449),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0a8449),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        fontFamily: 'Poppins',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0a8449),
          primary: const Color(0xFF0a8449),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),      
        '/login': (context) => const LoginPage(),
        '/home_doador': (context) => const HomeDoadorScreen(),
        '/home_receptor': (context) => const HomeReceptorScreen(),
      },
    );
  }
}
