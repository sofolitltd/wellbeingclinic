import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellbeingclinic/services/auth_service.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    var currentUser = FirebaseAuth.instance.currentUser;

    //
    getProfileImage() {
      if (currentUser!.photoURL != null) {
        return Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          color: Colors.blueAccent.shade100,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(currentUser.photoURL!)
            )
          ),
        );
      } else {
        return const Icon(
          Icons.account_circle,
          size: 100,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () async {
                await authService.handleSignOut().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false));
              },
              icon: const Icon(Icons.logout_sharp),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getProfileImage(),
            const SizedBox(height: 32),
            Text('Name: ${currentUser!.displayName}'),
            const SizedBox(height: 4),
            Text('Email: ${currentUser.email}'),
          ],
        ),
      ),
    );
  }
}
