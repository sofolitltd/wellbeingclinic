import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/utils/daily_quote.dart';
import 'counseling_card.dart';
import 'counseling_details.dart';
import 'emotion_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  //
  String greeting() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 20) {
      return 'Good Evening';
    } else if (hour == 24) {
      return 'Good Midnight';
    } else {
      return 'Good Night';
    }
  }

  //pp
  //
  getProfileImage() {
    var currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser?.photoURL != null) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade400, width: 1),
          color: Colors.grey.shade100,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  currentUser?.photoURL != null ? currentUser!.photoURL! : "")),
        ),
      );
    } else {
      return Icon(
        Icons.account_circle,
        size: 40,
        color: Colors.grey.shade400,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),

                        //
                        Text(
                          greeting().toUpperCase(),
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    height: 1.2,
                                  ),
                        ),

                        const SizedBox(height: 4),

                        //
                        Text(
                          FirebaseAuth.instance.currentUser != null
                              ? FirebaseAuth.instance.currentUser!.displayName!
                              : "Friend",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    height: 1.2,
                                  ),
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
                          //todo:image
                          // child: getProfileImage(),
                          child: getProfileImage(),
                        )
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                //
                Text(
                  'How are you feeling today?',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        // letterSpacing: 1,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                ),

                const SizedBox(height: 8),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: emotions
                        .map((Emotion emotion) => emotionCard(context, emotion))
                        .toList(),
                  ),
                ),

                const SizedBox(height: 24),

                //quote
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo,
                        Colors.purple.shade300,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 10, 0, 10),
                          child: Text(
                            getDailyQuote(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                  // letterSpacing: .4,
                                  // fontWeight: FontWeight.w600,
                                  height: 1.4,
                                ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.format_quote_rounded,
                          size: 48,
                          color: Colors.white70,
                        ),
                      )
                    ],
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
                const SizedBox(height: 8),
                //

                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('counseling')
                      .orderBy('order')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: Text('No data available'));
                    }

                    return SizedBox(
                      height: 330,
                      child: ListView.separated(
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        shrinkWrap: true,
                        padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var counselingData = snapshot.data!.docs[index];
                          print(counselingData.id);
                          return CounselingCard(
                            imageUrl: counselingData['imageUrl'],
                            title: counselingData['title'],
                            description: counselingData['description'],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CounselingDetailsPage(
                                    title: counselingData['title'],
                                    description: counselingData['description'],
                                    imageUrl: counselingData['imageUrl'],
                                    causes: counselingData['causes'],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
