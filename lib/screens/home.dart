import 'package:flutter/material.dart';
import 'package:wellbeingclinic/screens/dark_triad.dart';
import 'package:wellbeingclinic/screens/internet_addiction.dart';
import 'package:wellbeingclinic/screens/self_esteem.dart';
import 'package:wellbeingclinic/screens/wellbeing.dart';

import 'social_anxiety.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellbeing Clinic'),
      ),

      //
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > 1000
              ? MediaQuery.of(context).size.width * .2
              : 12,
          vertical: 12,
        ),
        children: [
          // wellbeing
          Card(
            elevation: 3,
            child: ListTile(
              onTap: () {
                // to
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Wellbeing(),
                  ),
                );
              },
              title: const Text('Wellbeing Scale'),
              subtitle: const Text('5 items'),
            ),
          ),

          // self esteem
          Card(
            elevation: 3,
            child: ListTile(
              onTap: () {
                // to
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelfEsteem(),
                  ),
                );
              },
              title: const Text('Self Esteem'),
              subtitle: const Text('10 items'),
            ),
          ),

          //todo: // stress
          // Card(
          //   elevation: 3,
          //   child: ListTile(
          //     onTap: () {
          //       // to
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const Stress(),
          //         ),
          //       );
          //     },
          //     title: const Text('Stress Scale'),
          //     subtitle: const Text('20 items'),
          //   ),
          // ),

          // internet addiction
          Card(
            elevation: 3,
            child: ListTile(
              onTap: () {
                // to
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InternetAddiction(),
                  ),
                );
              },
              title: const Text('Internet Addiction Test'),
              subtitle: const Text('18 items'),
            ),
          ),

          // dart triad
          Card(
            elevation: 3,
            child: ListTile(
              onTap: () {
                // to
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DarkTriad(),
                  ),
                );
              },
              title: const Text('Dark Triad Dirty Dozen'),
              subtitle: const Text('12 items'),
            ),
          ),

          // social anxiety
          Card(
            elevation: 3,
            child: ListTile(
              onTap: () {
                // to
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SocialAnxiety(),
                  ),
                );
              },
              title: const Text('Social Anxiety'),
              subtitle: const Text('28 items'),
            ),
          ),
        ],
      ),
    );
  }
}
