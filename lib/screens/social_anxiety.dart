import 'package:flutter/material.dart';

import '/items/items.dart';
import '/models/result_model.dart';
import '/screens/social_anxiety_result.dart';
import '../widgets/question_card.dart';

class SocialAnxiety extends StatefulWidget {
  const SocialAnxiety({Key? key}) : super(key: key);

  @override
  State<SocialAnxiety> createState() => _SocialAnxietyState();
}

class _SocialAnxietyState extends State<SocialAnxiety> {
  Map testAnswer = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Social Anxiety',
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
                Items.socialAnxietyInstruction,
                style: const TextStyle(fontFamily: 'tiro'),
              ),

              const SizedBox(height: 16),

              //
              ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Items.socialAnxietyItems.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    index: index,
                    testItems: Items.socialAnxietyItems,
                    testScale: Items.socialAnxietyScale,
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
                        Items.socialAnxietyItems.length)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill all items')));
                    } else {
                      //todo: result
                      var result = sum.round();

                      String title = '';
                      String subtitle = '';
                      if (result.clamp(0, 1) == result) {
                        title = 'Low';
                        subtitle = 'low social anxiety';
                      } else if (result.clamp(2, 11) == result) {
                        title = 'Average';
                        subtitle = 'average/normal social anxiety';
                      } else if (result >= 12) {
                        title = 'High';
                        subtitle = 'high social anxiety';
                      }

                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SocialAnxietyResult(
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
