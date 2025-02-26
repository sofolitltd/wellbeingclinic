import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/items/items.dart';
import '/widgets/item_card.dart';
import '../../test_page.dart';
import '../1/wellbeing.dart';

class Insomnia extends StatefulWidget {
  const Insomnia({super.key});

  @override
  State<Insomnia> createState() => _InsomniaState();
}

class _InsomniaState extends State<Insomnia> {
  Map testAnswer = {};
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    // Get arguments from previous screen
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Tests test = args['test']; // Extract test object
    String mobileNo = args['mobile_no']; // Extract mobile number

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Insomnia',
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
                Items.insomniaInstruction,
                style: const TextStyle(fontFamily: 'tiro'),
              ),

              const SizedBox(height: 16),

              //
              ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Items.insomniaItems.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    index: index,
                    testItems: Items.insomniaItems,
                    testScale: itemChecker(Items.insomniaItems[index].id),
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

                    if ((testAnswer.length != Items.insomniaItems.length)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill all items')));
                    } else {
                      //todo: result
                      String title = '';
                      String subtitle = '';

                      if (sum.clamp(0, 7) == sum) {
                        title = 'Absence of Insomnia';
                        subtitle =
                            'আপনার ঘুমে কোনো সমস্যা নেই। আপনার ঘুমাতে যেতে বা ঘুমের মধ্যে তেমন কোনো অসুবিধা হয় না।';
                      } else if (sum.clamp(8, 14) == sum) {
                        title = 'Mild of Insomnia';
                        subtitle =
                            'আপনার সামান্য ইনসমনিয়া আছে। আপনাকে ঠিকভাবে ঘুমাতে যথেষ্ট বেগ পেতে হয়। এছাড়াও দিনে আপনি পরিমিত ঘুমাতে পারছেন না। ';
                      } else if (sum.clamp(15, 21) == sum) {
                        print('Moderate');
                        title = 'Moderate of Insomnia';
                        subtitle =
                            'আপনার প্রায়ই অনিদ্রাজনিত সমস্যায় ভুগছেন। অপরিমিত ঘুম এবং ঘুমাতে যেতে আপনার অনেক বেগ পেতে হচ্ছে। এর ফলে আপনার সামাজিক এবং কর্মক্ষেত্রে অসুবিধা হচ্ছে।';
                      } else if (sum.clamp(22, 28) == sum) {
                        print('Severe');
                        title = 'Severe of Insomnia';
                        subtitle =
                            'আপনি প্রচন্ড অনিদ্রায় ভুগছেন। আপনার পরিমিত এবং ভালো ঘুম হচ্ছে না। এর ফলে আপনার সামাজিক এবং কর্মক্ষেত্র ব্যাপকভাবে ব্যাহত হচ্ছে।';
                      }

                      setState(() => _inProgress = true);

                      //
                      await updateTestResultByMobile(mobileNo, test.id, title);

                      Navigator.pushReplacementNamed(
                        context,
                        '/success',
                        arguments: {'mobile_no': mobileNo},
                      );

                      // await Future.delayed(const Duration(seconds: 1)).then(
                      //   (value) {
                      //     //
                      //     Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => InsomniaResult(
                      //           resultModel: ResultModel(
                      //             sum: sum,
                      //             title: title,
                      //             subtitle: subtitle,
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // );

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

itemChecker(var items) {
  //
  if (items == 1 || items == 2 || items == 3) {
    return Items.insomniaScale123;
  } else if (items == 4) {
    return Items.insomniaScale4;
  } else if (items == 5) {
    return Items.insomniaScale5;
  } else if (items == 6) {
    return Items.insomniaScale6;
  } else if (items == 7) {
    return Items.insomniaScale7;
  }
}
