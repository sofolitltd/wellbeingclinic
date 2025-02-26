import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/utils/constants.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // Get the passed arguments (mobile number)
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? mobileNo = args['mobile_no'];

    if (mobileNo == null) {
      return Scaffold(
        body: Center(child: Text("No mobile number provided.")),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user')
              .where('mobile_no', isEqualTo: mobileNo)
              .limit(1)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No user found."));
            }

            var userData =
                snapshot.data!.docs.first.data() as Map<String, dynamic>;
            List<dynamic> userTests = userData['tests'] ?? [];

            // Extract test IDs from the user's test list
            List<String> userTestIds =
                userTests.map<String>((test) => test['id'].toString()).toList();

            // Filter testList based on the IDs
            List<Tests> filteredTests = testList
                .where((test) => userTestIds.contains(test.id))
                .toList();

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 8),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width > 1000 ? size.width * .2 : 16,
                    ),
                    child: Text(
                      "Wellbeing Clinic".toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            height: 1.2,
                          ),
                    ),
                  ),

                  // Show filtered tests
                  filteredTests.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text("No tests found."),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                size.width > 1000 ? size.width * .2 : 12,
                            vertical: 12,
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemCount: filteredTests.length,
                          itemBuilder: (context, index) => TestCard(
                            test: filteredTests[index],
                            mobileNo: mobileNo,
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

//
class TestCard extends StatelessWidget {
  final Tests test;
  final String mobileNo; // Pass mobile number

  const TestCard({
    super.key,
    required this.test,
    required this.mobileNo, // Include mobileNo
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          test.route,
          arguments: {
            'test': test,
            'mobile_no': mobileNo, // Pass mobileNo to next screen
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: test.color,
              ),
              padding: const EdgeInsets.all(4),
              child: Image.asset('assets/images/${test.image}.png'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "${test.id}. ${test.title}",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: .4,
                            height: 1.2,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        test.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  wordSpacing: 1.2,
                                  height: 1.3,
                                  letterSpacing: .2,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueGrey,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//
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

//
List<Tests> testList = [
  Tests(
    id: '1',
    title: 'Social Anxiety',
    description:
        "Social anxiety, also known as social phobia, is a mental health condition characterized by a significant and persistent fear of social situations. People with social anxiety disorder experience intense anxiety and distress in situations where they may be judged by others, such as giving a presentation, meeting new people, or eating in public. This fear can be so severe that it interferes with their daily lives, making it difficult to go to work or school, maintain relationships, and engage in social activities.",
    author: 'N/A',
    color: kLightBlueColor,
    image: '5',
    items: '28',
    route: '/tests/social-anxiety',
  ),
  Tests(
    id: '2',
    title: 'Self Esteem Test',
    description:
        "Self-esteem is a person's overall subjective evaluation of their worth or value. It is a complex concept that is influenced by a variety of factors, including genetics, personality, life experiences, and social relationships. Self-esteem is important because it can have a significant impact on our thoughts, behaviors, and overall well-being.",
    author: 'N/A',
    color: kPurpleColor,
    image: '2',
    items: '10',
    route: '/tests/self-esteem',
  ),
  Tests(
    id: '3',
    title: 'Dark Triad Dirty Dozen',
    description:
        "The Dark Triad Dirty Dozen is a set of 12 personality traits that are associated with the Dark Triad personality types of Machiavellianism, Narcissism, and Psychopathy. These traits are often described as 'dirty'' because they are associated with negative and harmful behaviors. For example, people who are high in Machiavellianism are more likely to engage in manipulative and exploitative behaviors. People who are high in narcissism are more likely to be arrogant and entitled. And people who are high in psychopathy are more likely to engage in impulsive and antisocial behaviors.",
    author: 'N/A',
    color: kPinkColor,
    image: '3',
    items: '12',
    route: '/tests/dark-triad',
  ),
  Tests(
    id: '4',
    title: 'Internet Addiction Test',
    description:
        "Internet addiction is a behavioral addiction that is characterized by excessive use of the internet, to the point where it interferes with daily life. People with internet addiction may spend hours online each day, neglecting their work, studies, relationships, and other important activities. They may also experience withdrawal symptoms when they are not able to use the internet, such as anxiety, irritability, and difficulty concentrating.",
    author: 'N/A',
    color: kBlueColor,
    image: '6',
    items: '18',
    route: '/tests/internet-addiction',
  ),
  Tests(
    id: '5',
    title: 'Depression, Anxiety & Stress Test',
    description:
        "Depression, anxiety, and stress are the three most common mental health conditions in the world. They are all characterized by changes in mood, thinking, and behavior. Depression, anxiety, and stress can co-occur, and they can all have a significant impact on a person's life. For example, people with depression may have difficulty getting out of bed, going to work, or socializing. People with anxiety may avoid social situations or activities that they enjoy. And people with stress may have difficulty concentrating, making decisions, and coping with everyday challenges.",
    author: 'N/A',
    color: kMediumBlueColor,
    image: '4',
    items: '20',
    route: '/tests/das',
  ),
  Tests(
    id: '6',
    title: 'Wellbeing Test',
    description:
        'Wellbeing refers to a state of positive mental and emotional health. It is characterized by feelings of happiness, satisfaction, and contentment. Wellbeing is also associated with a sense of purpose and meaning in life, as well as strong social relationships.',
    author: 'WHO',
    color: kGreenColor,
    image: '1',
    items: '5',
    route: '/tests/wellbeing',
  ),
  Tests(
    id: '7',
    title: 'Insomnia',
    description:
        'Insomnia is a sleep disorder in which you have trouble falling and/or staying asleep. The condition can be short-term (acute) or can last a long time (chronic). It may also come and go. Acute insomnia lasts from 1 night to a few weeks. Insomnia is chronic when it happens at least 3 nights a week for 3 months or more.',
    author: 'N/A',
    color: kMediumBlueColor,
    image: '11',
    items: '7',
    route: '/tests/insomnia',
  ),
];
