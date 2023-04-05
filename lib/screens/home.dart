import 'package:flutter/material.dart';
import 'package:wellbeingclinic/screens/dark_triad.dart';
import 'package:wellbeingclinic/screens/internet_addiction.dart';

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
              title: const Text('Internet Addiction Test (IAT)'),
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
              title: const Text('Dark Triad Dirty Dozen (DTDD)'),
              subtitle: const Text('12 items'),
            ),
          ),
        ],
      ),
    );
  }
}
