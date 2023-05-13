import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:wellbeingclinic/auth/splash.dart';
import 'package:wellbeingclinic/screens/dark_triad.dart';
import 'package:wellbeingclinic/screens/home.dart';
import 'package:wellbeingclinic/screens/internet_addiction.dart';
import 'package:wellbeingclinic/screens/self_esteem.dart';
import 'package:wellbeingclinic/screens/social_anxiety.dart';
import 'package:wellbeingclinic/screens/stress.dart';
import 'package:wellbeingclinic/screens/wellbeing.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xff72dfc1),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(minimumSize: const Size(100, 48)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(100, 48),
            backgroundColor: const Color(0xff4fd0a1),
          ),
        ),
      ),
      // home: const SplashScreen(),
      initialRoute: '/',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/': (context) => const Home(),
        '/wellbeing': (context) => const Wellbeing(),
        '/self-steam': (context) => const SelfEsteem(),
        '/stress': (context) => const Stress(),
        '/internet-addiction': (context) => const InternetAddiction(),
        '/dark-triad': (context) => const DarkTriad(),
        '/social-anxiety': (context) => const SocialAnxiety(),
      },
    );
  }
}
