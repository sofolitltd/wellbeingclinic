import 'package:flutter/material.dart';
import 'package:wellbeingclinic/screens/stree_result.dart';

import '/items/items.dart';
import '/models/result_model.dart';
import '../widgets/loading.dart';
import '../widgets/question_card.dart';

class Stress extends StatefulWidget {
  const Stress({Key? key}) : super(key: key);

  @override
  State<Stress> createState() => _StressState();
}

class _StressState extends State<Stress> {
  Map testAnswer = {};
  bool _inProgress = false;

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
                          testScale: itemChecker(Items.stressItems[index].id),
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
                          double sum = 0;

                          // get the list of all values of the map
                          List<dynamic> values = testAnswer.values.toList();

                          // calculate the sum with a loop
                          for (var value in values) {
                            sum += value;
                          }

                          // print out the sum
                          print(sum);

                          if ((testAnswer.length != Items.stressItems.length)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill all items')));
                          } else {
                            //todo: result
                            //n = 7,9,10,11,12
                            var result = sum.round();

                            String title = '';
                            String subtitle = '';
                            if (result < 20) {
                              title = 'Low';
                              subtitle = 'low stress';
                            } else if (result.clamp(15, 20) == result) {
                              title = 'Moderate stress';
                              subtitle = 'low stress';
                            } else if (result > 60) {
                              title = 'High stress';
                              subtitle = 'high stress';
                            }

                            setState(() => _inProgress = true);

                            await Future.delayed(const Duration(seconds: 5))
                                .then((value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StressResult(
                                    resultModel: ResultModel(
                                      sum: result.toDouble(),
                                      title: title,
                                      subtitle: subtitle,
                                    ),
                                  ),
                                ),
                              );
                            });
                          }
                          //
                          setState(() => _inProgress = false);
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

itemChecker(var items) {
  //n = 7 9 10 11 12
  if (items == 7 || items == 9 || items == 10 || items == 11 || items == 12) {
    return Items.stressScaleN;
  }
  return Items.stressScaleP;
}
