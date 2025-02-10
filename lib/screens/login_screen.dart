import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user_model.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      final usersBox = Hive.box<User>('usersBox');
      final user = usersBox.get(_usernameController.text);

      if (user != null && user.password == _passwordController.text) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(username: user.username),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciais inválidas!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0e5384),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                'images/Logo.png',
                height: 200,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _usernameController,
                cursorColor: Color(0xff0e5384),
                decoration: const InputDecoration(
                  labelText: 'Usuário',
                  prefixIcon: Icon(Icons.person),
                  prefixIconColor: Color(0xff0e5384),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff0e5384), width: 2.0),),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb33028), width: 2.0),),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                cursorColor: Color(0xff0e5384),
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock),
                  prefixIconColor: Color(0xff0e5384),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff0e5384), width: 2.0),),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffb33028), width: 2.0),),
                ),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Entrar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff0e5384),
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text('Criar nova conta'),
                style: TextButton.styleFrom(
                  foregroundColor: Color(0xff0e5384),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
