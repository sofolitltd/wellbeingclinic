import 'package:flutter/material.dart';

import '/items/items.dart';
import '/models/result_model.dart';
import '/screens/social_anxiety_result.dart';
import '../widgets/item_card.dart';
import '../widgets/loading.dart';

class SocialAnxiety extends StatefulWidget {
  const SocialAnxiety({Key? key}) : super(key: key);

  @override
  State<SocialAnxiety> createState() => _SocialAnxietyState();
}

class _SocialAnxietyState extends State<SocialAnxiety> {
  Map testAnswer = {};
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Social Anxiety',
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
                              Items.socialAnxietyItems.length)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill all items')));
                          } else {
                            //todo: result
                            var result = sum.round();

                            String title = '';
                            String subtitle = '';
                            if (result.clamp(0, 1) == result) {
                              title = 'Low';
                              subtitle =
                                  'সামাজিক পরিবেশে আপনি খুব বেশি অসস্তি অনুভব করেন না। আপনি অন্যদের সাথে যোগাযোগ স্থাপন করতে পারেন। আত্মবিশ্বাসী থাকেন।';
                            } else if (result.clamp(2, 11) == result) {
                              title = 'Average';
                              subtitle =
                                  'সামাজিক পরিবেশে আপনি কিছুটা বিচলিত অনুভব করেন। মেপে কথা বলার চেষ্টা করেন।আপনার মনে হয় আশেপাশের মানুষ আপনাকে নিয়ে নেতিবাচক মন্তব্য করে তাই আপনি আত্মসচেতন থাকার চেষ্টা করেন।';
                            } else if (result >= 12) {
                              title = 'High';
                              subtitle =
                                  'সামাজিক পরিবেশে আপনি অসস্তি অনুভব করেন। ভীড় বা জনসমাগম এড়িয়ে চলার চেষ্টা করেন। নিজেকে গুটিয়ে রাখার চেষ্টা করেন।';
                            }

                            setState(() => _inProgress = true);

                            await Future.delayed(const Duration(seconds: 3))
                                .then(
                              (value) {
                                //
                                Navigator.pushReplacement(
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
                              },
                            );

                            //
                            setState(() => _inProgress = false);
                          }
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
