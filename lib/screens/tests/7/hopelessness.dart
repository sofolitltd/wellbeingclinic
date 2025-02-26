import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wellbeingclinic/screens/tests/7/hopelessness_result.dart';

import '/items/items.dart';
import '/models/result_model.dart';
import '/widgets/item_card.dart';

class Hopelessness extends StatefulWidget {
  const Hopelessness({super.key});

  @override
  State<Hopelessness> createState() => _HopelessnessState();
}

class _HopelessnessState extends State<Hopelessness> {
  Map testAnswer = {};
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Hopelessness Scale(Beck)',
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
                Items.hopelessnessInstruction,
                style: const TextStyle(fontFamily: 'tiro'),
              ),

              const SizedBox(height: 16),

              //
              ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Items.hopelessnessItems.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    index: index,
                    testItems: Items.hopelessnessItems,
                    testScale: Items.hopelessnessScale,
                    testAnswer: testAnswer,
                    onChanged: () {},
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

                    if ((testAnswer.length != Items.hopelessnessItems.length)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill all items')));
                    } else {
                      //todo: result
                      String title = '';
                      String subtitle = '';

                      if (sum.clamp(0, 3) == sum) {
                        print('Normal');
                        title = 'Normal';
                        subtitle =
                            'আপনার এই আশাহীনতা স্বাভাবিক। একজন স্বাভাবিক মানুষ জীবনে প্রতিনিয়ত এটুকু আশাহীনতা মোকাবিলা করে থাকে। একঘেয়েমিতা বা ক্লান্তি এর কারণ হতে পারে।';
                      } else if (sum.clamp(4, 8) == sum) {
                        print('Mild');
                        title = 'Mild Hopelessness';
                        subtitle =
                            'আপনি কিছুটা আশাহীনতায় ভুগছেন। আপনি সহজেই বিভিন্ন ক্ষেত্রে নিরাশ হয়ে পড়ছেন। এটি আপনার দৈনন্দিন জীবনে প্রভাব ফেলতে পারে।';
                      } else if (sum.clamp(9, 14) == sum) {
                        print('Moderate');
                        title = 'Moderate Hopelessness';
                        subtitle =
                            'আপনি বর্তমানে যথেষ্ট নিরাশ। কোন কাজে যথাযথ প্রেরণা পাচ্ছেন না। যা আপনার জীবনে স্বাভাবিকভাবে এগিয়ে যাওয়া ব্যাহত করছে।';
                      }
                      if (15 <= sum) {
                        print('Severe');
                        title = 'Severe Hopelessness';
                        subtitle =
                            'আপনি আপনার জীবনে চরম আশাহীনতায় ভুগছেন। জীবনে কোনোকিছুতেই আপনি তেমন আগ্রহ পাচ্ছেন না। আপনার মধ্যে এর ফলে নেতিবাচকতা বৃদ্ধি পাচ্ছে যার ফলে আপনি নিজের জন্য ক্ষতিকর পদক্ষেপ নেওয়ার চিন্তা করেন।';
                      }

                      setState(() => _inProgress = true);

                      await Future.delayed(const Duration(seconds: 1)).then(
                        (value) {
                          //
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HopelessnessResult(
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
