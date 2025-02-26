import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/items/items.dart';
import '../../../widgets/item_card.dart';
import '../../test_page.dart';
import '../1/wellbeing.dart';

class DAS extends StatefulWidget {
  const DAS({super.key});

  @override
  State<DAS> createState() => _DASState();
}

class _DASState extends State<DAS> {
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
          'Depression, Anxiety and Stress($selectedItemCount/${Items.dasItems.length})',
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
                Items.dasInstruction,
                style: const TextStyle(fontFamily: 'tiro'),
              ),

              const SizedBox(height: 16),

              //
              ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Items.dasItems.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    index: index,
                    testItems: Items.dasItems,
                    testScale: Items.dasScale,
                    testAnswer: testAnswer,
                    onChanged: () {
                      setState(() {
                        selectedItemCount = testAnswer.length;
                      });
                    },
                  );
                },
              ),

              const SizedBox(height: 16),
              //
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    List<int> unselectedItems = [];

                    // Check for unselected items
                    for (int i = 0; i < Items.dasItems.length; i++) {
                      if (!testAnswer.containsKey(Items.dasItems[i].id)) {
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
                      //
                    } else {
                      //todo: result
                      int sum1 = 0;
                      int sum2 = 0;
                      int sum3 = 0;

                      //
                      final sorted = SplayTreeMap.from(testAnswer);
                      print("testAnswer: $testAnswer");
                      print("sorted: $sorted");

                      //
                      // List sorted = sorted.values.toList();
                      // print("sorted: $sorted");
                      //dep: 3,5,10,13,16,17,21
                      //anx:2,4,7,9,15,19,20
                      //stress:1,6,8,11,12,14,18

                      var s1 = sorted[3] +
                          sorted[5] +
                          sorted[10] +
                          sorted[13] +
                          sorted[16] +
                          sorted[17] +
                          sorted[21];

                      var s2 = sorted[2] +
                          sorted[4] +
                          sorted[7] +
                          sorted[9] +
                          sorted[15] +
                          sorted[19] +
                          sorted[20];
                      var s3 = sorted[1] +
                          sorted[6] +
                          sorted[8] +
                          sorted[11] +
                          sorted[12] +
                          sorted[14] +
                          sorted[18];

                      sum1 = s1 * 2;
                      sum2 = s2 * 2;
                      sum3 = s3 * 2;

                      print('sum1: $sum1');
                      print('sum2: $sum2');
                      print('sum3: $sum3');

                      //
                      var depression = '';
                      var stress = '';
                      var anxiety = '';

                      //depression
                      if (sum1.clamp(0, 9) == sum1) {
                        depression = 'Normal($sum1)';
                      } else if (sum1.clamp(10, 13) == sum1) {
                        depression = 'Mild($sum1)';
                      } else if (sum1.clamp(14, 20) == sum1) {
                        depression = 'Moderate($sum1)';
                      } else if (sum1.clamp(21, 27) == sum1) {
                        depression = 'Severe($sum1)';
                      } else if (sum1 >= 28) {
                        depression = 'Extremely Severe($sum1)';
                      }

                      //anxiety
                      if (sum2.clamp(0, 7) == sum2) {
                        anxiety = 'Normal($sum2)';
                      } else if (sum2.clamp(8, 9) == sum2) {
                        anxiety = 'Mild($sum2)';
                      } else if (sum2.clamp(10, 14) == sum2) {
                        anxiety = 'Moderate($sum2)';
                      } else if (sum2.clamp(15, 19) == sum2) {
                        anxiety = 'Severe($sum2)';
                      } else if (sum2 >= 20) {
                        anxiety = 'Extremely Severe($sum2)';
                      }

                      //stress
                      if (sum3.clamp(0, 14) == sum3) {
                        stress = 'Normal($sum3)';
                      } else if (sum3.clamp(15, 18) == sum3) {
                        stress = 'Mild($sum3)';
                      } else if (sum3.clamp(19, 25) == sum3) {
                        stress = 'Moderate($sum3)';
                      } else if (sum3.clamp(26, 33) == sum3) {
                        stress = 'Severe($sum3)';
                      } else if (sum3 >= 34) {
                        stress = 'Extremely Severe($sum3)';
                      }

                      //
                      setState(() => _inProgress = true);

                      String title =
                          'Depression: $depression; Anxiety: $anxiety; Stress: $stress';
                      ;

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
                      //         builder: (context) => DASResult(
                      //           depression: depression,
                      //           anxiety: anxiety,
                      //           stress: stress,
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

itemChecker(var items) {
  //n = 7 9 10 11 12
  if (items == 7 || items == 9 || items == 10 || items == 11 || items == 12) {
    return Items.stressScaleN;
  }
  return Items.stressScaleP;
}
