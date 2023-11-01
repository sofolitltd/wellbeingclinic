import 'package:flutter/material.dart';
import 'package:wellbeingclinic/screens/blog/blog_screen.dart';
import 'package:wellbeingclinic/screens/home/home_screen.dart';
import 'package:wellbeingclinic/screens/tests/test_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // bottomNavigationBar: size.width > 1000 ? null : bottomNav(),
      bottomNavigationBar: bottomNav(),
      body: screens.elementAt(_selectedIndex),
    );
  }

  //bottom nav
  BottomNavigationBar bottomNav() {
    return BottomNavigationBar(
      items:  <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: const Icon(Icons.space_dashboard_outlined), label: 'Home'.toUpperCase()),
        BottomNavigationBarItem(
            icon: const Icon(Icons.token_outlined), label: 'Test'.toUpperCase()),
        BottomNavigationBarItem(icon: const Icon(Icons.view_timeline_outlined), label: 'Blog'.toUpperCase()),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor:  Colors.indigo,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 13,
      unselectedFontSize: 13,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });

        // switch (index) {
        //   case 0:
        //     Navigator.pushNamed(context, "/home");
        //     break;
        //   case 1:
        //     Navigator.pushNamed(context, "/test");
        //     break;
        //   case 2:
        //     Navigator.pushNamed(context, "/blog");
        //     break;
        // }
      },
    );
  }
}

List<Widget> screens = [
  const HomeScreen(),
  const TestScreen(),
  const BlogScreen(),
];
