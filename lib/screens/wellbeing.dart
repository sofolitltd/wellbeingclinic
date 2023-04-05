import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellbeingclinic/items/items.dart';
import 'package:wellbeingclinic/models/result_model.dart';
import 'package:wellbeingclinic/screens/wellbeing_result.dart';

import '../widgets/question_card.dart';

class Wellbeing extends StatefulWidget {
  const Wellbeing({Key? key}) : super(key: key);

  @override
  State<Wellbeing> createState() => _WellbeingState();
}

class _WellbeingState extends State<Wellbeing> {
  Map testAnswer = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'সুস্থতা স্কেল (WHO-5 সূচক)',
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
                'নীচে সুস্থতা সম্পর্কিত ৫ টি উক্তি দেয়া আছে যা গত দুই সপ্তাহ ধরে আপনার অনুভূতিগুলো কেমন ছিল তা বর্ণনা করে। প্রতিটি উক্তি আপনার ক্ষেত্রে কতটুক প্রযোজ্য তা ৬ মানকের সেলের মাধ্যমে প্রকাশ করুন। \n O = কোন সময় নয় \n 1 = কিছু সময় \n 2 = অর্ধেক সময়ের চেয়ে কম \n 3 = অর্ধেক সময়ের চেয়ে বেশি \n 4 = অধিকাংশ সময় \n 5 = সব সময়',
                style: GoogleFonts.tiroBangla(),
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

                    if ((testAnswer.length != Items.wellbeingItems.length)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill all items')));
                    } else {
                      //todo: result
                      var result = sum * 4.round();
                      String title = '';
                      String subtitle = 'your wellbeing score in percentage';
                      //
                      Navigator.push(
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
