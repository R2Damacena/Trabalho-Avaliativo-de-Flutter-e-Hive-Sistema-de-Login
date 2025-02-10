import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final usersBox = Hive.box<User>('usersBox');
      final existingUser = usersBox.get(_usernameController.text);

      if (existingUser == null) {
        usersBox.put(
          _usernameController.text,
          User(
            username: _usernameController.text,
            password: _passwordController.text,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário já existe!')),
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
        title: const Text('Registro')),
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
                onPressed: _register,
                child: const Text('Registrar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff0e5384),
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: const Text('Já tem conta? Faça Login'),
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
