import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wellbeingclinic/screens/tests/11/insomnia_result.dart';

import '/items/items.dart';
import '/models/result_model.dart';
import '/widgets/item_card.dart';

class Insomnia extends StatefulWidget {
  const Insomnia({super.key});

  @override
  State<Insomnia> createState() => _InsomniaState();
}

class _InsomniaState extends State<Insomnia> {
  Map testAnswer = {};
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Insomnia',
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
                Items.insomniaInstruction,
                style: const TextStyle(fontFamily: 'tiro'),
              ),

              const SizedBox(height: 16),

              //
              ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Items.insomniaItems.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    index: index,
                    testItems: Items.insomniaItems,
                    testScale: itemChecker(Items.insomniaItems[index].id),
                    testAnswer: testAnswer,
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
                    double sum = 0;

                    // get the list of all values of the map
                    List<dynamic> values = testAnswer.values.toList();

                    // calculate the sum with a loop
                    for (var value in values) {
                      sum += value;
                    }

                    // print out the sum
                    print(sum);

                    if ((testAnswer.length != Items.insomniaItems.length)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill all items')));
                    } else {
                      //todo: result
                      String title = '';
                      String subtitle = '';

                      if (sum.clamp(0, 7) == sum) {
                        title = 'Absence of Insomnia';
                        subtitle = 'Absence of Insomnia';
                      } else if (sum.clamp(8, 14) == sum) {
                        title = 'Mild of Insomnia';
                        subtitle = 'Mild of Insomnia';
                      } else if (sum.clamp(15, 21) == sum) {
                        print('Moderate');
                        title = 'Moderate of Insomnia';
                        subtitle = 'Moderate of Insomnia';
                      } else if (sum.clamp(22, 28) == sum) {
                        print('Severe');
                        title = 'Severe of Insomnia';
                        subtitle = 'Severe of Insomnia';
                      }

                      setState(() => _inProgress = true);

                      await Future.delayed(const Duration(seconds: 1)).then(
                        (value) {
                          //
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InsomniaResult(
                                resultModel: ResultModel(
                                  sum: sum,
                                  title: title,
                                  subtitle: subtitle,
                                ),
                              ),
                            ),
                          );
                        },
                      );

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
                          child: Text(
                            'Submit now'.toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
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
  //
  if (items == 1 || items == 2 || items == 3) {
    return Items.insomniaScale123;
  } else if (items == 4) {
    return Items.insomniaScale4;
  } else if (items == 5) {
    return Items.insomniaScale5;
  } else if (items == 6) {
    return Items.insomniaScale6;
  } else if (items == 7) {
    return Items.insomniaScale7;
  }
}
