import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellbeingclinic/items/items.dart';
import 'package:wellbeingclinic/models/result_model.dart';
import 'package:wellbeingclinic/screens/self_esteem_result.dart';

import '../widgets/question_card.dart';

class SelfEsteem extends StatefulWidget {
  const SelfEsteem({Key? key}) : super(key: key);

  @override
  State<SelfEsteem> createState() => _SelfEsteemState();
}

class _SelfEsteemState extends State<SelfEsteem> {
  Map testAnswer = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Self Esteem Scale',
          style: GoogleFonts.hindSiliguri(),
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
                'নিচে আত্মমর্যাদা সম্পর্কিত ১০টি উক্তি রয়েছে। প্রতিটি উক্তি আপনার ক্ষেত্রে কতটুকু প্রযোজ্য তা ৪টি পছন্দক্রমের যেকোনো একটিতে টিক(v) চিহ্ন দিয়ে প্রকাশ করুন। \n 3 = সম্পূর্ণভাবে একমত \n 2 = একমত \n 1 = একমত নই \n 0 = একেবারেই একমত নই',
                style: GoogleFonts.tiroBangla(),
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
                    testScale: Items.selfEsteemScale,
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
                  onPressed: () {
                    double sum = 0;

                    // get the list of all values of the map
                    List<dynamic> values = testAnswer.values.toList();

                    // calculate the sum with a loop
                    for (var value in values) {
                      sum += value;
                    }

                    // print out the sum
                    print(sum);

                    if ((testAnswer.length != Items.selfEsteemItems.length)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill all items')));
                    } else {
                      //todo: result
                      var result = sum.round();
                      String title = '';
                      String subtitle = '';
                      if (result < 15) {
                        title = 'Low';
                        subtitle = 'low self esteem';
                      } else if (result.clamp(15, 20) == result) {
                        title = 'LOW';
                        subtitle = 'low self esteem';
                      } else if (result > 25) {
                        title = 'High';
                        subtitle = 'high self esteem';
                      }

                      //
                      Navigator.push(
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
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Submit now'),
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
