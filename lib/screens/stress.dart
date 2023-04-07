import 'package:flutter/material.dart';

import '/items/items.dart';
import '/models/result_model.dart';
import '/screens/self_esteem_result.dart';
import '../widgets/question_card.dart';

class Stress extends StatefulWidget {
  const Stress({Key? key}) : super(key: key);

  @override
  State<Stress> createState() => _StressState();
}

class _StressState extends State<Stress> {
  Map testAnswer = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Stress Scale',
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
                Items.stressInstruction,
                style: const TextStyle(fontFamily: 'tiro'),
              ),

              const SizedBox(height: 16),

              //
              ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Items.stressItems.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    index: index,
                    testItems: Items.stressItems,
                    testScale: Items.stressScale,
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

                    if ((testAnswer.length != Items.selfEsteemItems.length)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill all items')));
                    } else {
                      //todo: result
                      //1,2,4,6,7 +
                      //3,5,8,9,10 -
                      var result = sum.round();

                      String title = '';
                      String subtitle = '';
                      if (result < 15) {
                        title = 'Low';
                        subtitle = 'low self esteem';
                      } else if (result.clamp(15, 20) == result) {
                        title = 'LOW';
                        subtitle = 'low self esteem';
                      } else if (result > 25) {
                        title = 'High';
                        subtitle = 'high self esteem';
                      }

                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelfEsteemResult(
                            resultModel: ResultModel(
                              sum: result.toDouble(),
                              title: title,
                              subtitle: subtitle,
                            ),
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
