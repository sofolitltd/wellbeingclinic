import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellbeingclinic/auth/login.dart';
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
      if (currentUser?.photoURL != null) {
        return Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blueGrey.shade50, width: 5),
            color: Colors.grey.shade50,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(currentUser?.photoURL != null
                    ? currentUser!.photoURL!
                    : "")),
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
      ),
      body: currentUser != null
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          getProfileImage(),
                          const SizedBox(height: 24),
                          Text(
                            '${currentUser.displayName}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${currentUser.email}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  // log out
                  ElevatedButton.icon(
                    onPressed: () async {
                      await authService.handleSignOut().then((value) =>
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => false));
                    },
                    icon: const Icon(
                      Icons.exit_to_app_sharp,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Log Out'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Login to unlock more features'),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: Text(
                        'Login'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
