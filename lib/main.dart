import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:wellbeingclinic/screens/admin.dart';
import 'package:wellbeingclinic/screens/login_page.dart';
import 'package:wellbeingclinic/screens/test_page.dart';

import '/screens/tests/11/Insomnia.dart';
import 'firebase_options.dart';
import 'screens/tests/1/wellbeing.dart';
import 'screens/tests/2/self_esteem.dart';
import 'screens/tests/3/das.dart';
import 'screens/tests/4/dark_triad.dart';
import 'screens/tests/5/social_anxiety.dart';
import 'screens/tests/6/internet_addiction.dart';
import 'screens/tests/success.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //todo: add firebase
  usePathUrlStrategy();
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
            minimumSize: const Size(100, 48),
            // side: BorderSide(color: Colors.indigoAccent.shade200, width: 1.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            minimumSize: const Size(100, 48),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
        // '/': (context) => const LandingScreen(),
        // '/splash': (context) => const SplashScreen(),
        // '/login': (context) => const Login(),
        // '/profile': (context) => const Profile(),
        // '/emotion-calender': (context) => const EmotionCalender(),
        // '/team': (context) => Team(),
        //
        // '/': (context) => const TestScreen(),
        // '/tests': (context) => const TestDetails(),
        // '/payment': (context) => const Payment(),

        '/': (context) => LoginPage(),
        '/tests': (context) => const TestPage(),

        //tests
        '/tests/social-anxiety': (context) => const SocialAnxiety(),
        '/tests/self-esteem': (context) => const SelfEsteem(),
        '/tests/dark-triad': (context) => const DarkTriad(),
        '/tests/internet-addiction': (context) => const InternetAddiction(),
        '/tests/das': (context) => const DAS(),
        '/tests/wellbeing': (context) => const Wellbeing(),
        '/tests/insomnia': (context) => const Insomnia(),

        '/success': (context) => const SuccessPage(),
        //
        '/admin': (context) => const Admin(),

        //
        // '/tests/stress': (context) => const Stress(),
        // '/tests/hopelessness': (context) => const Hopelessness(),
        // '/tests/depression': (context) => const Depression(),
        // '/tests/love-obsession': (context) => const LoveObsession(),
        // '/tests/gad': (context) => const GAD(),
      },
    );
  }
}
