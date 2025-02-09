import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0e5384),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Bem-vindo'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                'images/Logo.png',
                height: 200,
              ),
            const SizedBox(height: 8),
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 20),
            Text(
              'Login realizado com sucesso!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              'Bem-vindo, $username!',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,),
              label: const Text('Sair'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff0e5384),
                  foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
