import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/models/blog_model.dart';
import '/widgets/blog_card.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      // floatingActionButton:
      //     FirebaseAuth.instance.currentUser!.email! != "asifreyad1@gmail.com"
      //         ? null :
      //     FloatingActionButton(
      //             onPressed: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (_) => const AddBlog(),
      //                 ),
      //               );
      //             },
      //             child: const Icon(Icons.add),
      //           ),
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
                child: Text(
                  "Blog".toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        height: 1.2,
                      ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('blog')
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data!.size == 0) {
                    return const Center(child: Text('No blog Found!'));
                  }

                  var data = snapshot.data!.docs;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width > 1000 ? size.width * .2 : 12,
                      vertical: 12,
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      BlogModel blog = BlogModel.fromJson(
                          data[index].data() as Map<String, dynamic>);
                      return BlogCard(blog: blog);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
