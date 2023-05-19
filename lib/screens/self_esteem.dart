import 'package:flutter/material.dart';

import '/items/items.dart';
import '/models/result_model.dart';
import '/screens/self_esteem_result.dart';
import '../widgets/loading.dart';
import '../widgets/question_card.dart';

class SelfEsteem extends StatefulWidget {
  const SelfEsteem({Key? key}) : super(key: key);

  @override
  State<SelfEsteem> createState() => _SelfEsteemState();
}

class _SelfEsteemState extends State<SelfEsteem> {
  Map testAnswer = {};
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Self Esteem Scale',
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
                      Items.selfEsteemInstruction,
                      style: const TextStyle(fontFamily: 'tiro'),
                    ),

                    const SizedBox(height: 16),

                    //
                    ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Items.selfEsteemItems.length,
                      itemBuilder: (context, index) {
                        return ItemCard(
                          index: index,
                          testItems: Items.selfEsteemItems,
                          testScale:
                              itemChecker(Items.selfEsteemItems[index].id),
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
                              Items.selfEsteemItems.length)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill all items')));
                          } else {
                            //todo: result
                            //1,2,4,6,7 +
                            //3,5,8,9,10 -
                            var result = sum.round();

                            String title = '';
                            String subtitle = '';
                            if (result < 15) {
                              title = 'LOW - Self Esteem';
                              subtitle =
                                  'আপনি আত্মবিশ্বাসহীনতায় ভুগেন, নিজের প্রতি নেতিবাচক ধারনা রাখেন।আপনার নিজের কর্মদক্ষতা নিয়ে আপনি সন্দিহান থাকেন। নতুন চ্যালেঞ্জ গ্রহণ করতে পছন্দ করেন না। কিছুসময় আপনি নিজেকে গুটিয়ে রাখতে পছন্দ করেন।';
                            } else if (result.clamp(15, 20) == result) {
                              title = 'NORMAL - Self Esteem';
                              subtitle =
                                  'আপনি আত্মবিশ্বাসী। দৈনন্দিন জীবনের কিছু পরিস্থিতিতে আপনি কিছুটা বিচলিত অনুভব করলেও পরবর্তীতে তা সম্পন্ন করতে পারেন। আপনি অতিরিক্ত চিন্তা বা দুশ্চিন্তা করতে পছন্দ করেন না। আপনি আপনার পারিপার্শ্বিক মানুষকে ইতিবাচক ভাবে গ্রহণ করেন,সুসম্পর্ক বজায় রাখেন।';
                            } else if (result > 25) {
                              title = 'High - Self Esteem';
                              subtitle =
                                  'আপনি একজন আত্মবিশ্বাসী মানুষ। নিজেকে নিয়ে আপনি ইতিবাচক মনোভাব রাখেন।দৈনন্দিন কাজ সম্পাদন করার জন্য আপনি বিচলিত হোন না।আপনি আত্মমর্যাদা অনুভব করে থাকেন। আপনি যেমন আছেন নিজেকে সেইভাবেই গ্রহণ করতে পারেন।আপনি নতুন চ্যালেঞ্জ গ্রহণ করতে ভালোবাসেন।';
                            }

                            //
                            setState(() => _inProgress = true);
                            await Future.delayed(const Duration(seconds: 3))
                                .then(
                              (value) {
                                //
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SelfEsteemResult(
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

itemChecker(var items) {
  // p =12467
  //n = 358910
  if (items == 1 || items == 2 || items == 4 || items == 6 || items == 7) {
    return Items.selfEsteemScaleP;
  }
  return Items.selfEsteemScaleN;
}
