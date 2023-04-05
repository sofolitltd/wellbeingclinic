import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellbeingclinic/items/items.dart';

import '/screens/internet_addiction_result.dart';
import '../models/result_model.dart';
import '../widgets/question_card.dart';

class InternetAddiction extends StatefulWidget {
  const InternetAddiction({Key? key}) : super(key: key);

  @override
  State<InternetAddiction> createState() => _InternetAddictionState();
}

class _InternetAddictionState extends State<InternetAddiction> {
  Map testAnswer = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ইন্টারনেট আসক্তি পরীক্ষা (আইএটি)',
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
                'নিম্নে বামপাশে আপনার ইন্টারনেট ব্যবহার সম্পর্কিত কিছু প্রশ্ন দেয়া আছে। প্রতিটি প্রশ্নের উত্তর ৫ বিন্দু বিশিষ্ট মানকের মাধ্যমে ডান পাশে দেয়া আছে। আপনি আপনার নিজের কথা চিন্তা করে প্রতিটি প্রশ্নের জন্য প্রযোজ্য উত্তরের সংখ্যাটি টিক(/)চিহ্ন দিয়ে চিহ্নিত করুন। এখানে ভূল বা শুদ্ধ উত্তর বলে কিছু নেই। তাই অনুগ্রহ করে অকপটে উত্তর দিন। \n 1 = একেবারেই না \n 2 = কিছুটা \n 3 = মাঝে মাঝে \n 4 = প্রায়ই \n 5 = সব সময়',
                style: GoogleFonts.tiroBangla(),
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

                    if ((testAnswer.length !=
                        Items.internetAddictionItems.length)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill all items')));
                    } else {
                      //todo: result
                      if (sum.clamp(18, 35) == sum) {
                        var title = 'Minimal users';
                        var subtitle =
                            ('Minimal users are the average online users who have complete control over their internet usage');

                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InternetAddictionResult(
                              resultModel: ResultModel(
                                  sum: sum, title: title, subtitle: subtitle),
                            ),
                          ),
                        );
                      } else if (sum.clamp(36, 62) == sum) {
                        print('Moderate users');
                        var title = 'Moderate users';
                        var subtitle =
                            ('Moderate users are those experiencing occasional or frequent problems due to internet usage.');

                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InternetAddictionResult(
                                resultModel: ResultModel(
                                    sum: sum,
                                    title: title,
                                    subtitle: subtitle)),
                          ),
                        );

                        //
                      }
                      if (sum.clamp(63, 90) == sum) {
                        print('Excessive users');
                        var title = 'Excessive users';
                        var subtitle =
                            ('Excessive users are those having significant problems caused by internet usage.');

                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InternetAddictionResult(
                                resultModel: ResultModel(
                                    sum: sum,
                                    title: title,
                                    subtitle: subtitle)),
                          ),
                        );
                      }
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
