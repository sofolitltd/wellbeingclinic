import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wellbeingclinic/services/auth_service.dart';

import '../utils/constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static const routeName = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Please login to continue our app',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/login.png',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const Spacer(),

              // login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isLoading ? null:  () async {
                    setState(() => isLoading = true);
                    await authService.handleSignIn().then((value) {
                      setState(() => isLoading = false);
                    });
                  },
                  icon: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        height: 40,
                        width: 40,
                      ),
                      if (isLoading)
                        const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                    ],
                  ),
                  label: Text(isLoading ? '' : 'Login with Google'.toUpperCase()),
                ),
              ),


              const SizedBox(height: 40),

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      const url = kFacebook;

                      if (!await launchUrl(
                        Uri.parse(url),
                        mode: LaunchMode.externalApplication,
                      )) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    icon: Image.asset(
                      'assets/images/facebook.png',
                      height: 32,
                      width: 32,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      const url = kInstagram;

                      if (!await launchUrl(
                        Uri.parse(url),
                        mode: LaunchMode.externalApplication,
                      )) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    icon: Image.asset(
                      'assets/images/instagram.png',
                      height: 32,
                      width: 32,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      const url = kYoutube;

                      if (!await launchUrl(
                        Uri.parse(url),
                        mode: LaunchMode.externalApplication,
                      )) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    icon: Image.asset(
                      'assets/images/youtube.png',
                      height: 32,
                      width: 32,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      const url = kContact;

                      if (!await launchUrl(
                        Uri.parse(url),
                        mode: LaunchMode.externalApplication,
                      )) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    icon: const Icon(Icons.language),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
