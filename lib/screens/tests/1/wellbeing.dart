import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/items/items.dart';
import '../../../widgets/item_card.dart';
import '../../test_page.dart';

class Wellbeing extends StatefulWidget {
  const Wellbeing({super.key});

  @override
  State<Wellbeing> createState() => _WellbeingState();
}

class _WellbeingState extends State<Wellbeing> {
  Map testAnswer = {};
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    // Get arguments from previous screen
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Tests test = args['test']; // Extract test object
    String mobileNo = args['mobile_no']; // Extract mobile number

    int selectedItemCount = testAnswer.length;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${test.title} ($selectedItemCount/${Items.wellbeingItems.length})',
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > 1000
              ? MediaQuery.of(context).size.width * .2
              : 12,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              Items.wellbeingInstruction,
              style: const TextStyle(fontFamily: 'tiro'),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: Items.wellbeingItems.length,
              itemBuilder: (context, index) => ItemCard(
                index: index,
                testItems: Items.wellbeingItems,
                testScale: Items.wellbeingScale,
                testAnswer: testAnswer,
                onChanged: () {
                  setState(() {
                    selectedItemCount = testAnswer.length;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: _inProgress
                    ? null
                    : () => _calculateResult(mobileNo, test.id),
                child: _inProgress
                    ? const SpinKitThreeBounce(color: Colors.white, size: 50)
                    : Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text('Submit now'.toUpperCase()),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _calculateResult(String mobileNo, String testId) async {
    setState(() => _inProgress = true);
    double sum = testAnswer.values.fold(0, (prev, curr) => prev + curr);

    List<int> unselectedItems = [];

    for (int i = 0; i < Items.wellbeingItems.length; i++) {
      if (!testAnswer.containsKey(Items.wellbeingItems[i].id)) {
        unselectedItems.add(i + 1);
      }
    }

    if (unselectedItems.isNotEmpty) {
      String errorMessage =
          'Please select items: ${unselectedItems.join(', ')}';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } else {
      var result = sum * 4.round();
      String title = result < 50
          ? 'Low'
          : result.clamp(50, 75) == result
              ? 'Moderate'
              : 'High';

      await updateTestResultByMobile(mobileNo, testId, title);

      Navigator.pushReplacementNamed(
        context,
        '/success',
        arguments: {'mobile_no': mobileNo},
      );
    }
    setState(() => _inProgress = false);
  }
}

//
updateTestResultByMobile(String mobileNo, String testId, String result) async {
  try {
    // Find the user document where the mobile_no matches
    var userDocs = await FirebaseFirestore.instance
        .collection('user')
        .where('mobile_no', isEqualTo: mobileNo)
        .get();

    if (userDocs.docs.isNotEmpty) {
      for (var doc in userDocs.docs) {
        // Access the 'tests' array of that user document
        var tests = doc['tests'] as List;

        // Search for the test with the matching ID
        var testToUpdate = tests.firstWhere((test) => test['id'] == testId,
            orElse: () => null);

        if (testToUpdate != null) {
          // Remove the old test and update the result
          await FirebaseFirestore.instance
              .collection('user')
              .doc(doc.id)
              .update({
            'tests':
                FieldValue.arrayRemove([testToUpdate]), // Remove the old test
          });

          // Add the updated test with the new result
          await FirebaseFirestore.instance
              .collection('user')
              .doc(doc.id)
              .update({
            'tests': FieldValue.arrayUnion([
              {
                'id': testId,
                'name': testToUpdate['name'], // Keep the same test name
                'result': result, // Updated result
              },
            ])
          });

          print("Test result updated successfully for mobile_no: $mobileNo");
        } else {
          print("Test with id $testId not found for mobile_no: $mobileNo");
        }
      }
    } else {
      print("No user found with mobile_no: $mobileNo");
    }
  } catch (e) {
    print("Error updating test result: $e");
  }
}
