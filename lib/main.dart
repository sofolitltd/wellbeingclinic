import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/screens/landing_screen.dart';
import '/auth/profile.dart';
import '/auth/wrapper.dart';

import 'auth/login.dart';
import 'auth/splash.dart';
import 'firebase_options.dart';
import 'payment/payment.dart';
import 'screens/tests/4/dark_triad.dart';
import 'screens/tests/3/das.dart';
import '/screens/tests/test_details.dart';
import 'screens/tests/test_screen.dart';
import 'screens/tests/6/internet_addiction.dart';
import 'screens/tests/2/self_esteem.dart';
import 'screens/tests/5/social_anxiety.dart';
import '/screens/tests/stress.dart';
import 'screens/tests/1/wellbeing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //todo: add firebase
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
        primarySwatch: Colors.indigo,
        fontFamily: 'hindSiliguri',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white70,
          iconTheme: IconThemeData(
            color: Colors.black87,
          ),
          titleTextStyle: TextStyle(
            fontSize: 16,
            color: Colors.black87,
            // letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            minimumSize: const Size(100, 56),
            side: const BorderSide(color: Colors.indigo, width: 1.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(100, 56),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.indigo.shade500,
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.black,
          indicatorColor: Colors.indigo,
        ),
      ),
      // home: const SplashScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const WrapperScreen(),
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const Login(),
        '/profile': (context) => const Profile(),
        '/main': (context) => const LandingScreen(),
        '/test': (context) => const TestScreen(),
        '/details': (context) => const TestDetails(),
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
