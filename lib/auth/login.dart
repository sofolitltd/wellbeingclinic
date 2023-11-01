import 'package:flutter/material.dart';
import 'package:wellbeingclinic/services/auth_service.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  static const routeName = '/login';


  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            authService.handleSignIn();
          },
          child: const Text('Login with Google'),
        ),
      ),
    );
  }
}
