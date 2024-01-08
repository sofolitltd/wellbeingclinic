import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../models/result_model.dart';
import '/items/items.dart';
import '/widgets/item_card.dart';
import 'love_obsession_result.dart';

class LoveObsession extends StatefulWidget {
  const LoveObsession({super.key});

  @override
  State<LoveObsession> createState() => _LoveObsessionState();
}

class _LoveObsessionState extends State<LoveObsession> {
  Map testAnswer = {};
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    var counter =
        "${testAnswer.length}/${Items.loveObsessionItems.length.toString()}";

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Love Obsession',
        ),
        //todo: add counter
        // actions: [Text(counter)],
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
                Items.loveObsessionInstruction,
                style: const TextStyle(fontFamily: 'tiro'),
              ),

              const SizedBox(height: 16),

              //
              ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Items.loveObsessionItems.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    index: index,
                    testItems: Items.loveObsessionItems,
                    testScale: Items.loveObsessionScale,
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

                    if ((testAnswer.length !=
                        Items.loveObsessionItems.length)) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Please fill all items'),
                            Text(counter),
                          ],
                        ),
                      ));
                    } else {
                      //todo: result
                      String title = '';
                      String subtitle = '';

                      if (6.5 < sum) {
                        title = 'Love Obsession';

                        testAnswer.forEach((key, value) {
                          if ((key == 12 && value == 1) ||
                              (key == 13 && value == 1)) {
                            subtitle = "Love Obsession.\n You need counseling.";
                            print(subtitle);
                          } else {
                            subtitle = "Love Obsession";
                            print(subtitle);
                          }
                        });
                      } else {
                        title = 'Not Love Obsession';
                        subtitle = "Not Love Obsession";
                      }

                      setState(() => _inProgress = true);

                      await Future.delayed(const Duration(seconds: 1)).then(
                        (value) {
                          //
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoveObsessionResult(
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
