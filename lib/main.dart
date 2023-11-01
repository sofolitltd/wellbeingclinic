import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import '/auth/profile.dart';
import '/auth/wrapper.dart';
import '/screens/das.dart';
import '/screens/details.dart';

import '/auth/splash.dart';
import '/screens/dark_triad.dart';
import '/screens/home.dart';
import '/screens/internet_addiction.dart';
import '/screens/self_esteem.dart';
import '/screens/social_anxiety.dart';
import '/screens/stress.dart';
import '/screens/wellbeing.dart';
import 'auth/login.dart';
import 'firebase_options.dart';
import 'payment/payment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //todo: add firebase
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellbeing Clinic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'hindSiliguri',
        appBarTheme:  AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.green.shade200,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(minimumSize: const Size(100, 48)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(100, 48),
            backgroundColor:  Colors.green.shade200,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1,)
          ),
        ),
      ),
      // home: const SplashScreen(),
      initialRoute: '/wrap',
      routes: {
        '/wrap': (context) => const WrapperScreen(),
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const Login(),
        '/profile': (context) => const Profile(),
        '/home': (context) => const Home(),
        '/details': (context) => const Details(),
        '/payment': (context) => const Payment(),

        '/wellbeing': (context) => const Wellbeing(),
        '/self-steam': (context) => const SelfEsteem(),
        '/stress': (context) => const Stress(),
        '/das': (context) => const DAS(),
        '/dark-triad': (context) => const DarkTriad(),
        '/social-anxiety': (context) => const SocialAnxiety(),
        '/internet-addiction': (context) => const InternetAddiction(),
      },
    );
  }
}
