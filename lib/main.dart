import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '/auth/profile.dart';
import '/screens/landing_screen.dart';
import '/screens/tests/10/gad.dart';
import '/screens/tests/11/Insomnia.dart';
import '/screens/tests/8/depression.dart';
import '/screens/tests/9/love_obsession.dart';
import '/screens/tests/test_details.dart';
import 'auth/login.dart';
import 'auth/splash.dart';
import 'firebase_options.dart';
import 'payment/payment.dart';
import 'screens/tests/1/wellbeing.dart';
import 'screens/tests/12/stress.dart';
import 'screens/tests/2/self_esteem.dart';
import 'screens/tests/3/das.dart';
import 'screens/tests/4/dark_triad.dart';
import 'screens/tests/5/social_anxiety.dart';
import 'screens/tests/6/internet_addiction.dart';
import 'screens/tests/7/hopelessness.dart';
import 'screens/tests/test_screen.dart';

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
            side: BorderSide(color: Colors.indigoAccent.shade200, width: 1.5),
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
            foregroundColor: Colors.white,
            minimumSize: const Size(100, 56),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.indigoAccent.shade200,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          indicatorColor: Colors.indigoAccent.shade200,
        ),
      ),
      // home: const SplashScreen(),
      initialRoute: '/',
      routes: {
        // '/': (context) => const WrapperScreen(),
        '/': (context) => const LandingScreen(),
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const Login(),
        '/profile': (context) => const Profile(),
        '/test': (context) => const TestScreen(),
        '/tests': (context) => const TestDetails(),
        '/payment': (context) => const Payment(),

        //tests
        '/tests/wellbeing': (context) => const Wellbeing(),
        '/tests/self-esteem': (context) => const SelfEsteem(),
        '/tests/stress': (context) => const Stress(),
        '/tests/das': (context) => const DAS(),
        '/tests/dark-triad': (context) => const DarkTriad(),
        '/tests/social-anxiety': (context) => const SocialAnxiety(),
        '/tests/internet-addiction': (context) => const InternetAddiction(),
        '/tests/hopelessness': (context) => const Hopelessness(),
        '/tests/depression': (context) => const Depression(),
        '/tests/love-obsession': (context) => const LoveObsession(),
        '/tests/gad': (context) => const GAD(),
        '/tests/insomnia': (context) => const Insomnia(),
      },
    );
  }
}
