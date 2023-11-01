import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/screens/landing_screen.dart';
import '../screens/tests/test_screen.dart';
import '/auth/login.dart';


class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const LandingScreen();
        } else {
          return const Login();
        }
      },
    );
  }
}
