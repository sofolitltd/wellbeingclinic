import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellbeingclinic/screens/profile/team_details.dart';

import '/screens/auth/login.dart';
import '/services/auth_service.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    var currentUser = FirebaseAuth.instance.currentUser;

    //
    getProfileImage() {
      if (currentUser?.photoURL != null) {
        return Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade400, width: 2),
            color: Colors.grey.shade100,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(currentUser?.photoURL != null
                    ? currentUser!.photoURL!
                    : "")),
          ),
        );
      } else {
        return Icon(
          Icons.account_circle,
          size: 64,
          color: Colors.grey.shade400,
        );
      }
    }

    //
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: currentUser != null

          // profile
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //img
                          getProfileImage(),
                          const SizedBox(width: 16),

                          //name, email
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //name
                              Text(
                                '${currentUser.displayName}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),

                              //email
                              Text(
                                '${currentUser.email}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // emotion calender
                  Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/emotion-calender');
                      },
                      title: const Text('Emotion Calender'),
                      subtitle: const Text('Track your emotional state'),
                      leading: const Icon(
                        Icons.face,
                        size: 40,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // team
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('member')
                        .where('email',
                            isEqualTo: FirebaseAuth.instance.currentUser!.email)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        // User not found in Firestore collection
                        return const SizedBox();
                      } else {
                        // User found in Firestore collection
                        // Check if the user's email matches
                        String team = '';
                        bool emailMatches = false;
                        for (var doc in snapshot.data!.docs) {
                          team = doc['team'];
                          if (doc['email'] ==
                              FirebaseAuth.instance.currentUser!.email) {
                            emailMatches = true;
                            break;
                          }
                        }

                        if (emailMatches) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TeamDetails(
                                              title: team,
                                            )));
                              },
                              title: const Text('Team'),
                              subtitle: const Text('Manage teamwork'),
                              leading: const Icon(
                                Icons.group_add_rounded,
                                size: 40,
                              ),
                            ),
                          );
                        } else {
                          // User's email doesn't match
                          return const SizedBox(); // or any other widget you want to show
                        }
                      }
                    },
                  ),

                  const Spacer(),

                  // log out
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await authService.handleSignOut().then((value) =>
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (route) => false));
                      },
                      icon: const Icon(
                        Icons.exit_to_app_sharp,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Log Out'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )

          // go to login
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Login to unlock more features'),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: Text(
                        'Login'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
