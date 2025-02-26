import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellbeingclinic/screens/profile/add_content.dart';
import 'package:wellbeingclinic/screens/profile/team.dart';

import 'add_design.dart';

List statusList = ['Pending', 'In Progress', 'Post'];

class TeamDetails extends StatelessWidget {
  const TeamDetails({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Team()));
                  },
                  child: const Text('Teams')),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              switch (title) {
                case 'Content':
                  return const AddContent();
                default:
                  return const AddDesign();
              }
            }));
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Content'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('member')
                  .where('team', isEqualTo: title)
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
                } else if (snapshot.hasData) {
                  var docs = snapshot.data!.docs;
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Team Members',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 88,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 8),
                            itemCount: docs.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    radius: 25,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    docs[index].get('name'),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('No data available'),
                  );
                }
              },
            ),

            //
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                'Task List',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            //
            TabBar(
              tabs: statusList
                  .map(
                    (status) => Tab(text: status),
                  )
                  .toList(),
            ),

            //
            Expanded(
              child: TabBarView(
                children: ['Pending', 'In Progress', 'Post']
                    .map(
                      (status) => StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('content')
                            .where('status', isEqualTo: status)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (snapshot.hasData) {
                            var docs = snapshot.data!.docs;
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(16),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 8),
                              itemCount: docs.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    if (status == 'Pending') {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text('Task'),
                                                content: const Text(
                                                    'Add to task for in progress mode'),
                                                actions: [
                                                  OutlinedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('No')),
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'content')
                                                            .doc(docs[index].id)
                                                            .update({
                                                          "status":
                                                              "In Progress"
                                                        }).then((value) =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop());
                                                      },
                                                      child: const Text('Add')),
                                                ],
                                              ));
                                    } else {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        switch (title) {
                                          case 'Content':
                                            return const AddContent();
                                          default:
                                            return const AddDesign();
                                        }
                                      }));
                                    }
                                  },
                                  tileColor: Colors.grey.shade100,
                                  title: Text(
                                    docs[index].get('title'),
                                    // style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  subtitle: Text(
                                    docs[index].get('content'),
                                    // style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text('No data available'),
                            );
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
