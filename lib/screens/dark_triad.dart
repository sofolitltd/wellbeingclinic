import 'dart:collection';

import 'package:flutter/material.dart';

import '/items/items.dart';
import '../widgets/item_card.dart';
import '../widgets/loading.dart';
import 'dark_triad_result.dart';

class DarkTriad extends StatefulWidget {
  const DarkTriad({Key? key}) : super(key: key);

  @override
  State<DarkTriad> createState() => _DarkTriadState();
}

class _DarkTriadState extends State<DarkTriad> {
  Map testAnswer = {};
  bool _inProgress = false;

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
      body: _inProgress
          ? const Loading()
          : SingleChildScrollView(
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
                        onPressed: () async {
                          //
                          if ((testAnswer.length !=
                              Items.dartTriadItems.length)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill all items')));
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

                            await Future.delayed(const Duration(seconds: 3))
                                .then(
                              (value) {
                                //
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DarkTriadResult(
                                      machiavellianism: machiavellianism,
                                      psychopathy: psychopathy,
                                      narcissism: narcissism,
                                    ),
                                  ),
                                );
                              },
                            );

                            //
                            setState(() => _inProgress = false);
                          }
                        },
                        child: Padding(
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
