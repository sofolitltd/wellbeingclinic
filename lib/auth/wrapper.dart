import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/auth/login.dart';

import '../screens/home.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen({super.key});
  static const routeName = '/wrap';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Home();
        } else {
          return const Login();
        }
      },
    );
  }
}
