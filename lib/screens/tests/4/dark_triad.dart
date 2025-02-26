import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/items/items.dart';
import '../../../widgets/item_card.dart';
import '../../test_page.dart';
import '../1/wellbeing.dart';

class DarkTriad extends StatefulWidget {
  const DarkTriad({super.key});

  @override
  State<DarkTriad> createState() => _DarkTriadState();
}

class _DarkTriadState extends State<DarkTriad> {
  Map testAnswer = {};
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Tests test = args['test']; // Extract test object
    String mobileNo = args['mobile_no'];

    int selectedItemCount = testAnswer.length;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Dark Triad Dirty Dozen($selectedItemCount/${Items.dartTriadItems.length})',
        ),
      ),

      //
      body: SingleChildScrollView(
        child: Padding(
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
                Items.dartTriadInstruction,
                style: const TextStyle(fontFamily: 'tiro'),
              ),

              const SizedBox(height: 16),

              //
              ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Items.dartTriadItems.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                      index: index,
                      testItems: Items.dartTriadItems,
                      testScale: Items.dartTriadScale,
                      testAnswer: testAnswer,
                      onChanged: () {
                        setState(() {
                          selectedItemCount = testAnswer.length;
                        });
                      });
                },
              ),

              //
              const SizedBox(height: 16),

              //
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    //
                    List<int> unselectedItems = [];

                    // Check for unselected items
                    for (int i = 0; i < Items.dartTriadItems.length; i++) {
                      if (!testAnswer.containsKey(Items.dartTriadItems[i].id)) {
                        unselectedItems.add(i +
                            1); // Adding 1 to match the item index starting from 1
                      }
                    }

                    if (unselectedItems.isNotEmpty) {
                      String errorMessage =
                          'Please select items: ${unselectedItems.join(', ')}';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                    } else {
                      //todo: result

                      double sum1 = 0;
                      double sum2 = 0;
                      double sum3 = 0;

                      //
                      final sorted = SplayTreeMap.from(testAnswer);
                      print("testAnswer: $testAnswer");
                      print("sorted: $sorted");

                      //
                      List sortedValues = sorted.values.toList();
                      var s1 = sortedValues.getRange(0, 4);
                      var s2 = sortedValues.getRange(4, 8);
                      var s3 = sortedValues.getRange(8, 12);

                      // calculate the sum with a loop
                      for (var value in s1) {
                        sum1 += value;
                      }
                      for (var value in s2) {
                        sum2 += value;
                      }
                      for (var value in s3) {
                        sum3 += value;
                      }
                      print('sum1: $sum1');
                      print('sum2: $sum2');
                      print('sum3: $sum3');

                      var machiavellianism = '';
                      var psychopathy = '';
                      var narcissism = '';
                      if (sum1 >= 20) {
                        machiavellianism = 'Exist';
                      } else {
                        machiavellianism = 'Not Exist';
                      }

                      if (sum2 >= 20) {
                        psychopathy = 'Exist';
                      } else {
                        psychopathy = 'Not Exist';
                      }

                      if (sum3 >= 20) {
                        narcissism = 'Exist';
                      } else {
                        narcissism = 'Not Exist';
                      }

                      setState(() => _inProgress = true);

                      String title =
                          'Machiavellianism: $machiavellianism; Psychopathy: $psychopathy; Narcissism: $narcissism';

                      //
                      await updateTestResultByMobile(mobileNo, test.id, title);

                      Navigator.pushReplacementNamed(
                        context,
                        '/success',
                        arguments: {'mobile_no': mobileNo},
                      );

                      // await Future.delayed(const Duration(seconds: 1)).then(
                      //   (value) {
                      //     //
                      //     Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => DarkTriadResult(
                      //           machiavellianism: machiavellianism,
                      //           psychopathy: psychopathy,
                      //           narcissism: narcissism,
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // );

                      //
                      setState(() => _inProgress = false);
                    }
                  },
                  child: _inProgress
                      ? const SpinKitThreeBounce(
                          color: Colors.white,
                          size: 50,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text('Submit now'.toUpperCase()),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
