import 'package:flutter/material.dart';

import '/utils/constants.dart';
import '/widgets/test_card.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/wellbeing_clinic.png',
          height: 40,
        ),
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
                "Psychological Tests",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
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
  final String title;
  final String description;
  final Color color;
  final String image;
  final String items;
  final String route;

  Tests({
    required this.title,
    required this.description,
    required this.color,
    required this.image,
    required this.items,
    required this.route,
  });
}

List<Tests> testList = [
  Tests(
    title: 'Wellbeing Scale',
    description:
        'Measure of mental well-being focusing entirely on positive aspects of mental health',
    color: kGreenColor,
    image: '1',
    items: '5',
    route: '/wellbeing',
  ),
  Tests(
    title: 'Self Esteem',
    description:
        'Measures global self-worth by measuring both positive and negative feelings about the self',
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
    title: 'Depression, Anxiety & Stress Scale',
    description:
        'Measuring the amount of depression, anxiety and stress experienced recently',
    color: kMediumBlueColor,
    image: '4',
    items: '20',
    route: '/das',
  ),
  Tests(
    title: 'Dark Triad Dirty Dozen',
    description:
        'Use to determine whether or not we may embody the dark triad personality traits',
    color: kPinkColor,
    image: '3',
    items: '12',
    route: '/dark-triad',
  ),
  Tests(
    title: 'Social Anxiety',
    description:
        'Assess how comfortable when we are interacting with other people',
    color: kLightBlueColor,
    image: '5',
    items: '28',
    route: '/social-anxiety',
  ),
  Tests(
    title: 'Internet Addiction Test',
    description: 'Measures the presence and severity of internet addiction',
    color: kBlueColor,
    image: '6',
    items: '18',
    route: '/internet-addiction',
  ),
];
