import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour <= 12) {
      return ('Good Morning');
    } else if ((hour > 12) && (hour <= 16)) {
      return ('Good Afternoon');
    } else if ((hour > 16) && (hour < 20)) {
      return ('Good Evening');
    } else {
      return ('Good Night');
    }
  }

  //pp
  getProfileImage() {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser!.photoURL != null) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.blueGrey),
            image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(currentUser.photoURL!))),
      );
    } else {
      return const Icon(
        Icons.account_circle,
        size: 100,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
//
    List quotes = [
      "It's okay not to be okay",
      "You are not your mental illness",
      "Your struggles do not define you",
      "Healing is not linear, but it is possible",
      "You are stronger than you realize",
      "Your mental health journey is unique to you",
      "Self-care is not selfish, it's necessary for good mental health",
      "Small steps can lead to big progress in mental health",
      "It's okay to ask for help",
      "You are not alone",
      "Your mental health matters",
      "You are worthy of love and happiness",
      "There is no shame in seeking help for your mental health",
      "You are capable of great things",
      "You are not your thoughts",
      "You are not your feelings",
    ];

    final DateTime today = DateTime.now();
    final int randomIndex = Random().nextInt(quotes.length);
    final String quote = quotes[randomIndex];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.only(top: 24, bottom: 8),
            padding: EdgeInsets.symmetric(
              horizontal: size.width > 1000 ? size.width * .2 : 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          greeting().toUpperCase(),
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    height: 1.2,
                                  ),
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser!.displayName!,
                          style: const TextStyle(height: 1.4),
                        ),
                      ],
                    ),

                    //
                    Row(
                      children: [
                        //notification
                        // Stack(
                        //   children: [
                        //     IconButton(
                        //       onPressed: () {},
                        //       icon: const Icon(
                        //         Icons.notifications_outlined,
                        //         size: 26,
                        //       ),
                        //     ),
                        //     Positioned(
                        //       top: 6,
                        //       right: 6,
                        //       child: Container(
                        //         height: 16,
                        //         width: 16,
                        //         alignment: Alignment.center,
                        //         decoration: const BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           color: Colors.red,
                        //         ),
                        //         child: const Text(
                        //           '2',
                        //           style: TextStyle(
                        //             fontSize: 10,
                        //             color: Colors.white,
                        //             letterSpacing: .4,
                        //             height: 1.4,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        const SizedBox(width: 8),

                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/profile');
                          },
                          child: getProfileImage(),
                        )
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                //
                Text(
                  'How are you feeling today?',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        // letterSpacing: 1,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                ),

                const SizedBox(height: 8),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      greetingCard(context, title: 'Happy', image: '1'),
                      greetingCard(context, title: 'Sad', image: '2'),
                      greetingCard(context, title: 'Angry', image: '3'),
                      greetingCard(context, title: 'Anxiety', image: '5'),
                      greetingCard(context, title: 'Fear', image: '4'),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                //quote
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient:  LinearGradient(
                      colors: [
                        Colors.indigo,
                        Colors.purple.shade300,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 8,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                           '" $quote "',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                  // letterSpacing: .4,
                                  // fontWeight: FontWeight.w600,
                                  height: 1.2,
                                ),
                          ),
                        ),

                        const Icon(
                          Icons.format_quote_rounded,
                          size: 64,
                          color: Colors.white70,
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                //counseling
                Text(
                  'Counseling',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        // letterSpacing: 1,
                        color: Colors.black87,
                      ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    counselingCard(context, title: 'Student\nCounseling'),
                    const SizedBox(width: 16),
                    counselingCard(context, title: 'Individual\nCounseling'),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    counselingCard(context, title: 'Couple\nCounseling'),
                    const SizedBox(width: 16),
                    counselingCard(context, title: 'Family\nCounseling'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
Widget greetingCard(BuildContext context, {required title, required image}) {
  return GestureDetector(
    onTap: () async {
      var felling = '';
      if (title == 'Happy') {
        felling =
            "You are glowing with joy today! Keep radiating and shining bright, your happiness is contagious and lifts up the people around you. Keep up the good work.";
      } else if (title == 'Sad') {
        felling =
            "It's okay to feel sad sometimes. Remember that you are loved and supported, and that you are strong enough to get through this. Take some time for yourself and do something you enjoy, you'll be okay.";
      } else if (title == 'Angry'){
        felling =
            "It's okay to feel angry sometimes. Take a deep breath and find a healthy way to express your anger, don't let it control you. Talk to someone you trust about how you're feeling, and you'll feel better. I hope this helps!";
      }else if (title == 'Anxiety'){
     felling =  "Take a deep breath and remember that you are not alone. Anxiety is a normal human emotion, and it is okay to feel it sometimes. But you are stronger than your anxiety, and you will get through this.";
      }else{
        felling = "Fear is a normal emotion, but it shouldn't hold you back. Face your fears head-on, and you'll be stronger for it.Don't let fear stop you from living your life to the fullest.";
      }

      showDialog(
        context: context,
        builder: (context) =>
            //
            AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          titlePadding: const EdgeInsets.only(left: 16, top: 4),
          contentPadding:
              const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 24),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                ),
                icon: const Icon(Icons.close_rounded),
                onPressed: () {
                  // Dismiss the alert dialog.
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          content: Text(
            felling,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
        ),
      );

      //
      var uid = FirebaseAuth.instance.currentUser!.uid;
      var date =
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
      await FirebaseFirestore.instance
          .collection('feeling')
          .doc(uid)
          .collection('date')
          .doc(date)
          .set({
        "uid": uid,
        "time": DateTime.now(),
        "felling": title,
      });
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.only(
        right: 8,
        top: 8,
        bottom: 8,
        left: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(4, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 4),
          Image.asset(
            'assets/images/$image.png',
            width: 72,
            height: 72,
          ),
          const SizedBox(height: 12),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Colors.black87,
              height: 1.2,
              letterSpacing: .5,
            ),
          ),
        ],
      ),
    ),
  );
}

//
Widget counselingCard(context, {required title}) {
  return Expanded(
    child: InkWell(
      onTap: () async {
        const url = kContact;

        if (!await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        )) {
          throw Exception('Could not launch $url');
        }
      },
      child: Container(
        height: 100,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white70,
            border: Border.all(color: Colors.white30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(4, 1),
              ),
            ]),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                letterSpacing: 1,
                height: 1.2,
                color: Colors.blueGrey,
              ),
        ),
      ),
    ),
  );
}
