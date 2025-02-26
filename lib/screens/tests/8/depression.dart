import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wellbeingclinic/screens/tests/8/depression_result.dart';

import '/items/items.dart';
import '/models/result_model.dart';
import '/widgets/item_card.dart';

class Depression extends StatefulWidget {
  const Depression({super.key});

  @override
  State<Depression> createState() => _DepressionState();
}

class _DepressionState extends State<Depression> {
  Map testAnswer = {};
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Depression',
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
                Items.depressionInstruction,
                style: const TextStyle(fontFamily: 'tiro'),
              ),

              const SizedBox(height: 16),

              //
              ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Items.depressionItems.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    index: index,
                    testItems: Items.depressionItems,
                    testScale: Items.depressionScale,
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

                    if ((testAnswer.length != Items.depressionItems.length)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill all items')));
                    } else {
                      //todo: result
                      String title = '';
                      String subtitle = '';

                      if (sum.clamp(0, 4) == sum) {
                        print('Minimal');
                        title = 'Minimal';
                        subtitle =
                            'আপনি যথেষ্ট উৎফুল্ল। জীবনকে আপনি নিজের মত করে উপভোগ করেন।';
                      } else if (sum.clamp(5, 9) == sum) {
                        print('Mild');
                        title = 'Mild Depression';
                        subtitle =
                            'আপনি কিছুটা বিষণ্ণতায় ভুগছেন। আপনার জীবনের নানান ক্ষেত্রে এর প্রভাব পড়ছে। যেমন - ঘুমে অসুবিধা, ক্ষুধামন্দা, দুর্বলতা, খিটখিটে মেজাজ, অসহায় অনুভব করা ইত্যাদি।';
                      } else if (sum.clamp(10, 14) == sum) {
                        print('Moderate');
                        title = 'Moderately Depression';
                        subtitle =
                            'আপনি যথেষ্ট বিষণ্ণতায় ভুগছেন।  আপনার ব্যক্তিগত ও সামাজিক জীবন এর ফলে  ব্যাহত হচ্ছে। কর্মজীবনেও এর নেতিবাচক প্রভাব পড়ছে। আপনি নিজেকে মূল্যহীন ভাবছেন। এবং যেকোনো বিষয়ে আপনি সহজেই উদ্বিগ্ন হয়ে পড়ছেন।';
                      } else if (sum.clamp(15, 19) == sum) {
                        print('Moderately severe ');
                        title = 'Moderately Severe Depression';
                        subtitle =
                            'আপনি অনেক বিষণ্ণতায় ভুগছেন।  আপনার ব্যক্তিগত ও সামাজিক জীবনে এর ব্যাপক নেতিবাচক প্রভাব পড়ছে। কর্মজীবনেও আপনার যথেষ্ট অবনতি হচ্ছে। আপনি নিজেকে মূল্যহীন ভাবছেন এবং যেকোনো বিষয়ে আপনি সহজেই উদ্বিগ্ন হয়ে পড়ছেন।';
                      }
                      if (sum.clamp(20, 27) == sum) {
                        print('Severe');
                        title = 'Severe Depression';
                        subtitle =
                            'আপনি প্রচন্ড বিষণ্ণ। আপনার প্রায়ই হ্যালুসিনেশন বা বিভ্রম হচ্ছে। একই সাথে আপনি নির্জীব হয়ে পড়েছেন। আপনার আত্মহত্যার চেষ্টা করেছেন বা প্রায়ই এধরণের চিন্তা আসছে।';
                      }

                      setState(() => _inProgress = true);

                      await Future.delayed(const Duration(seconds: 1)).then(
                        (value) {
                          //
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DepressionResult(
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
                            style: const TextStyle(
                              color: Colors.white,
                            ),
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
