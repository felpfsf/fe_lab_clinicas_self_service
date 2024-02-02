import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // Após carregar a tela splash sem problemas redireciona o usuário para a tela de login
    // A rota, através do flutterGetIt, concatena a primeira rota '/auth' do module e segue para a rota '/login' no LoginRouter
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed('/auth/login');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo_vertical.png'),
      ),
    );
  }
}
