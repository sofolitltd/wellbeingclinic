import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wellbeingclinic/screens/tests/10/gad_result.dart';

import '/items/items.dart';
import '/models/result_model.dart';
import '/widgets/item_card.dart';

class GAD extends StatefulWidget {
  const GAD({super.key});

  @override
  State<GAD> createState() => _GADState();
}

class _GADState extends State<GAD> {
  Map testAnswer = {};
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'General Anxiety Disorder',
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
                Items.gadInstruction,
                style: const TextStyle(fontFamily: 'tiro'),
              ),

              const SizedBox(height: 16),

              //
              ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Items.gadItems.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    index: index,
                    testItems: Items.gadItems,
                    testScale: Items.gadScale,
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

                    if ((testAnswer.length != Items.gadItems.length)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill all items')));
                    } else {
                      //todo: result
                      String title = '';
                      String subtitle = '';

                      if (sum.clamp(0, 4) == sum) {
                        print('Moderate');
                        title = 'Minimal Anxiety';
                        subtitle =
                            'আপনার তেমন কোনো দুশ্চিন্তা নেই। সামান্য দুশ্চিন্তা থাকলেও আপনি তা কাটিয়ে উঠতে পারেন।';
                      } else if (sum.clamp(5, 9) == sum) {
                        print('Mild');
                        title = 'Mild Anxiety';
                        subtitle =
                            'আপনি কিছুটা দুশ্চিন্তায় ভুগছেন। আপনার মনোযোগ দিতে সমস্যা হচ্ছে, এবং সহজেই মেজাজ খিটখিটে হয়ে যাচ্ছে। আপনি মাঝেমধ্যে অস্থিরতা অনুভব করছেন।';
                      } else if (sum.clamp(10, 14) == sum) {
                        print('Moderate');
                        title = 'Moderate Anxiety';
                        subtitle =
                            'আপনি অনেকটা দুশ্চিন্তায় ভুগছেন। আপনার অনিয়ন্ত্রিত চিন্তা বেড়ে যাচ্ছে। এছাড়াও ঘুমে অসুবিধা, শ্বাসকষ্ট, অস্থিরতা, খিটখিটে মেজাজ আপনার জীবন ব্যাপকভাবে ব্যাহত করছে। আপনি ক্রমাগত উদ্বেগ অনুভব করছেন।';
                      }
                      if (sum.clamp(15, 21) == sum) {
                        print('Severe Anxiety');
                        title = 'Severe Anxiety';
                        subtitle =
                            'আপনি প্রচন্ড দুশ্চিন্তাগ্রস্ত। আপনার মধ্যে ব্যাপক অস্থিরতা কাজ করে। পাশাপাশি শ্বাসকষ্ট, ঘুমে অসুবিধা ইত্যাদি হচ্ছে। অতিরিক্ত চিন্তার দরুন ঘর্মাক্ত হয়ে পড়া বা প্যানিক অ্যাটাক দেখা দিচ্ছে।';
                      }

                      setState(() => _inProgress = true);

                      await Future.delayed(const Duration(seconds: 1)).then(
                        (value) {
                          //
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GADResult(
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
