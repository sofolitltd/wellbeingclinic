import 'package:flutter/material.dart';

import '/utils/constants.dart';
import '/widgets/test_card.dart';
import '/widgets/test_card_grid.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool isListView = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    //

    return Scaffold(
      //body
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 24, bottom: 8),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width > 1000 ? size.width * .2 : 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Test".toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            height: 1.2,
                          ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isListView = true;
                              });
                            },
                            icon: Icon(
                              Icons.list_alt_rounded,
                              color: isListView ? Colors.black : Colors.grey,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isListView = false;
                              });
                            },
                            icon: Icon(
                              Icons.grid_view_rounded,
                              color: isListView ? Colors.grey : Colors.black,
                            )),
                      ],
                    ),
                  ],
                ),
              ),

              //
              isListView
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width > 1000 ? size.width * .2 : 12,
                        vertical: 12,
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemCount: testList.length,
                      itemBuilder: (context, index) =>
                          TestCard(test: testList[index]),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width > 1000 ? size.width * .2 : 12,
                        vertical: 12,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: size.width > 960
                            ? 5
                            : size.width > 600
                                ? 4
                                : 3,
                        childAspectRatio: .8,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: testList.length,
                      itemBuilder: (context, index) =>
                          TestCardGrid(test: testList[index]),
                    ),
            ],
          ),
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
        'Wellbeing refers to a state of positive mental and emotional health. It is characterized by feelings of happiness, satisfaction, and contentment. Wellbeing is also associated with a sense of purpose and meaning in life, as well as strong social relationships.',
    author: 'WHO',
    color: kGreenColor,
    image: '1',
    items: '5',
    route: '/tests/wellbeing',
  ),
  Tests(
    id: '02',
    title: 'Self Esteem',
    description:
        "Self-esteem in psychology is a person's overall subjective evaluation of their worth or value. It is a complex concept that is influenced by a variety of factors, including genetics, personality, life experiences, and social relationships. Self-esteem is important because it can have a significant impact on our thoughts, behaviors, and overall well-being.",
    author: 'N/A',
    color: kPurpleColor,
    image: '2',
    items: '10',
    route: '/tests/self-esteem',
  ),
  Tests(
    id: '03',
    title: 'Depression, Anxiety & Stress Scale',
    description:
        "Depression, anxiety, and stress are the three most common mental health conditions in the world. They are all characterized by changes in mood, thinking, and behavior. Depression, anxiety, and stress can co-occur, and they can all have a significant impact on a person's life. For example, people with depression may have difficulty getting out of bed, going to work, or socializing. People with anxiety may avoid social situations or activities that they enjoy. And people with stress may have difficulty concentrating, making decisions, and coping with everyday challenges.",
    author: 'N/A',
    color: kMediumBlueColor,
    image: '4',
    items: '20',
    route: '/tests/das',
  ),
  Tests(
    id: '04',
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
    id: '05',
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
    id: '06',
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
    id: '07',
    title: 'Hopelessness Scale(Beck)',
    description: 'Hopelessness ',
    author: 'N/A',
    color: kYellowColor,
    image: '6',
    items: '20',
    route: '/tests/hopelessness',
  ),
  Tests(
    id: '08',
    title: 'Depression',
    description: 'Measure Depression ',
    author: 'N/A',
    color: kYellowColor,
    image: '6',
    items: '9',
    route: '/tests/depression',
  ),
  Tests(
    id: '09',
    title: 'Love Obsession',
    description: 'Love Obsession',
    author: 'N/A',
    color: kYellowColor,
    image: '6',
    items: '13',
    route: '/tests/love-obsession',
  ),
  Tests(
    id: '10',
    title: 'General Anxiety Disorder',
    description: 'General Anxiety Disorder',
    author: 'N/A',
    color: kYellowColor,
    image: '6',
    items: '7',
    route: '/tests/gad',
  ),
  Tests(
    id: '11',
    title: 'Insomnia',
    description: 'Insomnia',
    author: 'N/A',
    color: kYellowColor,
    image: '6',
    items: '7',
    route: '/tests/insomnia',
  ),
  // Tests(
  //   id: '12',
  //   title: 'Stress Scale',
  //   description: 'Measuring the amount of stress experienced recently',
  //   author: '',
  //   color: kYellowColor,
  //   image: '5',
  //   items: '20',
  //   route: '/stress',
  // ),
];
