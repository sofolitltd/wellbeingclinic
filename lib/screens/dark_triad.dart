import 'dart:collection';

import 'package:flutter/material.dart';

import '/items/items.dart';
import '/screens/dark_triad_result.dart';
import '../widgets/question_card.dart';

class DarkTriad extends StatefulWidget {
  const DarkTriad({Key? key}) : super(key: key);

  @override
  State<DarkTriad> createState() => _DarkTriadState();
}

class _DarkTriadState extends State<DarkTriad> {
  Map testAnswer = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Dark Triad Dirty Dozen',
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
                  );
                },
              ),

              //

              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: ElevatedButton(
                  onPressed: () {
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

                    //
                    if ((testAnswer.length != Items.dartTriadItems.length)) {
                      print(
                          '${testAnswer.length} => ${Items.dartTriadItems.length}');
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill all items')));
                    } else {
                      //todo: result
                      print('result');

                      var result1 = '';
                      var result2 = '';
                      var result3 = '';
                      if (sum1 >= 20) {
                        result1 = 'Exist (score: $sum1)';
                      } else {
                        result1 = 'Not Exist  (score: $sum1)';
                      }

                      if (sum2 >= 20) {
                        result2 = 'Exist (score: $sum2)';
                      } else {
                        result2 = 'Not Exist  (score: $sum2)';
                      }

                      if (sum3 >= 20) {
                        result3 = 'Exist (score: $sum3)';
                      } else {
                        result3 = 'Not Exist  (score: $sum3)';
                      }

                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DarkTriadResult(
                            machiavellianism: result1,
                            psychopathy: result2,
                            narcissism: result3,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Submit now'),
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
