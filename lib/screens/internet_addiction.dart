import 'package:flutter/material.dart';

import '/items/items.dart';
import '/screens/internet_addiction_result.dart';
import '../models/result_model.dart';
import '../widgets/question_card.dart';

class InternetAddiction extends StatefulWidget {
  const InternetAddiction({Key? key}) : super(key: key);

  @override
  State<InternetAddiction> createState() => _InternetAddictionState();
}

class _InternetAddictionState extends State<InternetAddiction> {
  Map testAnswer = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Internet Addiction Scale',
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
                Items.internetAddictionInstruction,
                style: const TextStyle(fontFamily: 'tiro'),
              ),

              const SizedBox(height: 16),

              //
              ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Items.internetAddictionItems.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    index: index,
                    testItems: Items.internetAddictionItems,
                    testScale: Items.internetAddictionScale,
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
                    double sum = 0;

                    // get the list of all values of the map
                    List<dynamic> values = testAnswer.values.toList();

                    // calculate the sum with a loop
                    for (var value in values) {
                      sum += value;
                    }

                    // print out the sum
                    print(sum);

                    if ((testAnswer.length !=
                        Items.internetAddictionItems.length)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill all items')));
                    } else {
                      //todo: result
                      if (sum.clamp(18, 35) == sum) {
                        var title = 'Minimal users';
                        var subtitle =
                            ('Minimal users are the average online users who have complete control over their internet usage');

                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InternetAddictionResult(
                              resultModel: ResultModel(
                                  sum: sum, title: title, subtitle: subtitle),
                            ),
                          ),
                        );
                      } else if (sum.clamp(36, 62) == sum) {
                        print('Moderate users');
                        var title = 'Moderate users';
                        var subtitle =
                            ('Moderate users are those experiencing occasional or frequent problems due to internet usage.');

                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InternetAddictionResult(
                                resultModel: ResultModel(
                                    sum: sum,
                                    title: title,
                                    subtitle: subtitle)),
                          ),
                        );

                        //
                      }
                      if (sum.clamp(63, 90) == sum) {
                        print('Excessive users');
                        var title = 'Excessive users';
                        var subtitle =
                            ('Excessive users are those having significant problems caused by internet usage.');

                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InternetAddictionResult(
                                resultModel: ResultModel(
                                    sum: sum,
                                    title: title,
                                    subtitle: subtitle)),
                          ),
                        );
                      }
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
