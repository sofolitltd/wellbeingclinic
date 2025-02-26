import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/items/items.dart';
import '../../../widgets/item_card.dart';
import '../../test_page.dart';
import '../1/wellbeing.dart';

class SelfEsteem extends StatefulWidget {
  const SelfEsteem({super.key});

  @override
  State<SelfEsteem> createState() => _SelfEsteemState();
}

class _SelfEsteemState extends State<SelfEsteem> {
  Map testAnswer = {};
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Tests test = args['test']; // Extract test object
    String mobileNo = args['mobile_no']; // Extract mobile number

    int selectedItemCount = testAnswer.length;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Self Esteem Test ($selectedItemCount/${Items.selfEsteemItems.length})',
        ),
      ),
      body: SingleChildScrollView(
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
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: Items.selfEsteemItems.length,
              itemBuilder: (context, index) {
                return ItemCard(
                  index: index,
                  testItems: Items.selfEsteemItems,
                  testScale: itemChecker(Items.selfEsteemItems[index].id),
                  testAnswer: testAnswer,
                  onChanged: () {
                    setState(() {
                      selectedItemCount = testAnswer.length;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: _inProgress
                    ? null
                    : () async {
                        await calculatedResult(mobileNo, test.id);
                      },
                child: _inProgress
                    ? const SpinKitThreeBounce(color: Colors.white, size: 50)
                    : Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text('Submit now'.toUpperCase()),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculatedResult(mobileNo, testId) async {
    setState(() => _inProgress = true);

    double sum = testAnswer.values.fold(0, (prev, curr) => prev + curr);
    var result = sum.round();

    if (testAnswer.length != Items.selfEsteemItems.length) {
      List<int> unselectedItems = [];
      for (int i = 0; i < Items.selfEsteemItems.length; i++) {
        if (!testAnswer.containsKey(Items.selfEsteemItems[i].id)) {
          unselectedItems
              .add(i + 1); // Adding 1 to match the item index starting from 1
        }
      }
      String errorMessage =
          'Please select items: ${unselectedItems.join(', ')}';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } else {
      String title = '';
      String subtitle = '';

      if (result < 15) {
        title = 'Low';
        subtitle =
            'আপনি আত্মবিশ্বাসহীনতায় ভুগেন, নিজের প্রতি নেতিবাচক ধারনা রাখেন।আপনার নিজের কর্মদক্ষতা নিয়ে আপনি সন্দিহান থাকেন। নতুন চ্যালেঞ্জ গ্রহণ করতে পছন্দ করেন না। কিছুসময় আপনি নিজেকে গুটিয়ে রাখতে পছন্দ করেন।';
      } else if (result.clamp(15, 25) == result) {
        title = 'Normal';
        subtitle =
            'আপনি আত্মবিশ্বাসী। দৈনন্দিন জীবনের কিছু পরিস্থিতিতে আপনি কিছুটা বিচলিত অনুভব করলেও পরবর্তীতে তা সম্পন্ন করতে পারেন। আপনি অতিরিক্ত চিন্তা বা দুশ্চিন্তা করতে পছন্দ করেন না। আপনি আপনার পারিপার্শ্বিক মানুষকে ইতিবাচক ভাবে গ্রহণ করেন,সুসম্পর্ক বজায় রাখেন।';
      } else if (result > 25) {
        title = 'High';
        subtitle =
            'আপনি একজন আত্মবিশ্বাসী মানুষ। নিজেকে নিয়ে আপনি ইতিবাচক মনোভাব রাখেন।দৈনন্দিন কাজ সম্পাদন করার জন্য আপনি বিচলিত হোন না।আপনি আত্মমর্যাদা অনুভব করে থাকেন। আপনি যেমন আছেন নিজেকে সেইভাবেই গ্রহণ করতে পারেন। আপনি নতুন চ্যালেঞ্জ গ্রহণ করতে ভালোবাসেন।';
      }

      //todo
      await updateTestResultByMobile(mobileNo, testId, title);

      Navigator.pushReplacementNamed(
        context,
        '/success',
        arguments: {'mobile_no': mobileNo},
      );

      // await Future.delayed(const Duration(seconds: 1));
      //
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => SelfEsteemResult(
      //       resultModel: ResultModel(
      //         sum: result.toDouble(),
      //         title: title,
      //         subtitle: subtitle,
      //       ),
      //     ),
      //   ),
      // );
    }
    setState(() => _inProgress = false);
  }

  //
  itemChecker(int itemId) {
    if (itemId == 1 ||
        itemId == 2 ||
        itemId == 4 ||
        itemId == 6 ||
        itemId == 7) {
      return Items.selfEsteemScaleP;
    } else if (itemId == 3 ||
        itemId == 5 ||
        itemId == 8 ||
        itemId == 9 ||
        itemId == 10) {
      return Items.selfEsteemScaleN;
    }
  }
}
