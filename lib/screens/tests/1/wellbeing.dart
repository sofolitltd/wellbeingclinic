import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../widgets/item_card.dart';
import '/items/items.dart';
import '/models/result_model.dart';

import 'wellbeing_result.dart';

class Wellbeing extends StatefulWidget {
  const Wellbeing({super.key});

  @override
  State<Wellbeing> createState() => _WellbeingState();
}

class _WellbeingState extends State<Wellbeing> {
  Map testAnswer = {};
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Wellbeing Scale',
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
                      Items.wellbeingInstruction,
                      style: const TextStyle(fontFamily: 'tiro'),
                    ),

                    const SizedBox(height: 16),

                    //
                    ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Items.wellbeingItems.length,
                      itemBuilder: (context, index) {
                        return ItemCard(
                          index: index,
                          testItems: Items.wellbeingItems,
                          testScale: Items.wellbeingScale,
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
                              Items.wellbeingItems.length)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill all items')));
                          } else {
                            //todo: result
                            var result = sum * 4.round();
                            String title = '';
                            String subtitle = '';
                            if (result < 50) {
                              title = 'Low';
                              subtitle =
                                  'Low Wellbeing স্কোর নির্দেশ করছে আপনি মানসিক ভাবে বিষন্ন অনুভব করছে। আপনার দৈনন্দিন কাজে আগ্রহ কমে যাচ্ছে। নিজেকে অসুখী অনুভব করছেন।';
                            } else if (result.clamp(50, 75) == result) {
                              title =
                                  'Moderate';
                              subtitle =
                                  'Moderate Wellbeing স্কোর নির্দেশ করছে আপনি মানসিক ভাবে কিছুটা প্রফুল্ল, তবে দৈনন্দিন কাজ এবং জীবন নিয়ে আপনি সম্পুর্ণ ভাবে সন্তুষ্ট নন।';
                            } else if (result > 75) {
                              title = 'High';
                              subtitle =
                                  'High Wellbeing স্কোর নির্দেশ করছে আপনি মানসিক ভাবে প্রফুল্ল, সতেজ এবং আপনার দৈনন্দিন কাজে স্বতস্ফুর্ত।';
                            }

                            setState(() => _inProgress = true);

                            // //
                            await Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              //
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WellbeingResult(
                                    resultModel: ResultModel(
                                      sum: result,
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
                        child: _inProgress
                            ?  const SpinKitThreeBounce(
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
