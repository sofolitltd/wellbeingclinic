import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/utils/constants.dart';
import '/widgets/test_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    getProfileImage() {
      var currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser!.photoURL != null) {
        return Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueAccent.shade100,
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(currentUser.photoURL!)
              )
          ),
        );
      } else {
        return const Icon(
          Icons.account_circle,
          size: 100,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/wellbeing_clinic.png',
          height: 40,
        ),
        actions: [

          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child:  Padding(
                padding:const EdgeInsets.only(right: 16), child: getProfileImage()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 8),
              padding: EdgeInsets.symmetric(
                horizontal: size.width > 1000 ? size.width * .2 : 16,
              ),
              child: Text(
                "Psychological Tests".toUpperCase(),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.blueGrey,
                    ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: size.width > 1000 ? size.width * .2 : 12,
                vertical: 12,
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: testList.length,
              itemBuilder: (context, index) => TestCard(test: testList[index]),
            ),
          ],
        ),
      ),
    );
  }
}

class Tests {
  final String id;
  final String title;
  final String description;
  final String author;
  final Color color;
  final String image;
  final String items;
  final String route;

  Tests({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.color,
    required this.image,
    required this.items,
    required this.route,
  });
}

List<Tests> testList = [
  Tests(
    id: '01',
    title: 'Wellbeing Scale',
    description:
        'Measure of mental well-being focusing entirely on positive aspects of mental health',
    author: 'WHO',
    color: kGreenColor,
    image: '1',
    items: '5',
    route: '/wellbeing',
  ),
  Tests(
    id: '02',
    title: 'Self Esteem',
    description:
        'Measures global self-worth by measuring both positive and negative feelings about the self',
    author: 'N/A',
    color: kPurpleColor,
    image: '2',
    items: '10',
    route: '/self-steam',
  ),
  // Tests(
  //   title: 'Stress Scale',
  //   description: 'Measuring the amount of stress experienced recently',
  //   color: kYellowColor,
  //   image: '',
  //   items: '20',
  //   route: '/stress',
  // ),
  Tests(
    id: '03',
    title: 'Depression, Anxiety & Stress Scale',
    description:
        'Measuring the amount of depression, anxiety and stress experienced recently',
    author: 'N/A',
    color: kMediumBlueColor,
    image: '4',
    items: '20',
    route: '/das',
  ),
  Tests(
    id: '04',
    title: 'Dark Triad Dirty Dozen',
    description:
        'Use to determine whether or not we may embody the dark triad personality traits',
    author: 'N/A',
    color: kPinkColor,
    image: '3',
    items: '12',
    route: '/dark-triad',
  ),
  Tests(
    id: '05',
    title: 'Social Anxiety',
    description:
        'Assess how comfortable when we are interacting with other people',
    author: 'N/A',
    color: kLightBlueColor,
    image: '5',
    items: '28',
    route: '/social-anxiety',
  ),
  Tests(
    id: '06',
    title: 'Internet Addiction Test',
    description: 'Measures the presence and severity of internet addiction',
    author: 'N/A',
    color: kBlueColor,
    image: '6',
    items: '18',
    route: '/internet-addiction',
  ),
];
