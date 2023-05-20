import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:wellbeingclinic/screens/das.dart';

import '/auth/splash.dart';
import '/screens/dark_triad.dart';
import '/screens/home.dart';
import '/screens/internet_addiction.dart';
import '/screens/self_esteem.dart';
import '/screens/social_anxiety.dart';
import '/screens/stress.dart';
import '/screens/wellbeing.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
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
        '/das': (context) => const DAS(),
        '/dark-triad': (context) => const DarkTriad(),
        '/social-anxiety': (context) => const SocialAnxiety(),
        '/internet-addiction': (context) => const InternetAddiction(),
      },
    );
  }
}
