import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget emotionCard(
  BuildContext context,
  Emotion emotion,
) {
  return GestureDetector(
    onTap: () async {
      //
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
                '${emotion.title} ${emotion.image}',
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
            emotion.description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
        ),
      );

      //
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        var uid = FirebaseAuth.instance.currentUser!.uid;
        var date =
            "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('emotion')
            .doc(date)
            .set({
          "time": DateTime.now(),
          "emotion": emotion.title,
        });
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      constraints: const BoxConstraints(minWidth: 80),
      margin: const EdgeInsets.only(
        right: 12,
        top: 8,
        bottom: 8,
        left: 0,
      ),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(10),
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
          Text(
            emotion.image,
            style: const TextStyle(fontSize: 32),
          ),
          // Image.asset(
          //   'assets/images/$image.png',
          //   width: 72,
          //   height: 72,
          // ),
          const SizedBox(height: 4),
          Text(
            emotion.title,
            style: const TextStyle(
              color: Colors.black54,
              height: 1.2,
              letterSpacing: .5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

//
class Emotion {
  final String title;
  final String description;
  final String image;

  Emotion({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<Emotion> emotions = [
  Emotion(
    title: 'Happy',
    description:
        "You are glowing with joy today! Keep radiating and shining bright, your happiness is contagious and lifts up the people around you. Keep up the good work.",
    image: '😊',
  ),
  Emotion(
    title: 'Sad',
    description:
        "It's okay to feel sad sometimes. Remember that you are loved and supported, and that you are strong enough to get through this. Take some time for yourself and do something you enjoy, you'll be okay.",
    image: '😔',
  ),
  Emotion(
    title: 'Angry',
    description:
        "It's okay to feel angry sometimes. Take a deep breath and find a healthy way to express your anger, don't let it control you. Talk to someone you trust about how you're feeling, and you'll feel better. I hope this helps!",
    image: '😠',
  ),
  Emotion(
    title: 'Anxiety',
    description:
        "Take a deep breath and remember that you are not alone. Anxiety is a normal human emotion, and it is okay to feel it sometimes. But you are stronger than your anxiety, and you will get through this.",
    image: '😟',
  ),
  Emotion(
    title: 'Fear',
    description:
        "Fear is a normal emotion, but it shouldn't hold you back. Face your fears head-on, and you'll be stronger for it. Don't let fear stop you from living your life to the fullest.",
    image: '😨',
  ),
];
