import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../models/result_model.dart';
import '../../../widgets/item_card.dart';
import '/items/items.dart';
import 'internet_addiction_result.dart';

class InternetAddiction extends StatefulWidget {
  const InternetAddiction({super.key});

  @override
  State<InternetAddiction> createState() => _InternetAddictionState();
}

class _InternetAddictionState extends State<InternetAddiction> {
  Map testAnswer = {};
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Internet Addiction Scale',
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
                      Items.internetAddictionInstruction,
                      style: const TextStyle(fontFamily: 'tiro'),
                    ),

                    const SizedBox(height: 16),

                    //
                    ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Items.internetAddictionItems.length,
                      itemBuilder: (context, index) {
                        return ItemCard(
                          index: index,
                          testItems: Items.internetAddictionItems,
                          testScale: Items.internetAddictionScale,
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
                              Items.internetAddictionItems.length)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill all items')));
                          } else {
                            //todo: result
                            String title = '';
                            String subtitle = '';

                            if (sum.clamp(18, 35) == sum) {
                              title = 'Minimal User';
                              subtitle =
                                  'আপনার ইন্টারনেট আসক্তি নেই। আপনার ইন্টারনেট ব্যবহারের উপর পূর্ণ নিয়ন্ত্রণ রয়েছে।';
                            } else if (sum.clamp(36, 62) == sum) {
                              print('Moderate user');
                              title = 'Moderate User';
                              subtitle =
                                  'আপনি প্রয়োজনের তুলনায় কিছুটা বেশি সময় ইন্টারনেটে ব্যয় করে থাকেন। যা পরবর্তীতে আসক্তি তে রুপান্তরিত হতে পারে।';
                            }
                            if (sum.clamp(63, 90) == sum) {
                              print('Excessive user');
                              title = 'Excessive User';
                              subtitle =
                                  'আপনার ইন্টারনেট আসক্তি বিদ্যমান। আপনি প্রয়োজনের চেয়ে বেশি ইন্টারনেট ব্যবহার করে থাকেন,যা আপনার দৈনন্দিন জীবনে নেতিবাচক প্রভাব ফেলছে।';
                            }

                            setState(() => _inProgress = true);

                            await Future.delayed(const Duration(seconds: 1))
                                .then(
                              (value) {
                                //
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        InternetAddictionResult(
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
                        child:
                        _inProgress
                            ?  const SpinKitThreeBounce(
                          color: Colors.white,
                          size: 50,
                        )
                            :
                        Padding(
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
