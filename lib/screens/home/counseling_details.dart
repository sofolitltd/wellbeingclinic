//
import 'package:flutter/material.dart';

class CounselingDetailsPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final List causes;

  CounselingDetailsPage({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.causes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'সেবা নিতে পারেন নিন্মোক্ত সমস্যায়:',
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: causes.map((cause) {
                  return Text('- $cause');
                }).toList(),
              ),
            ),

            //
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
