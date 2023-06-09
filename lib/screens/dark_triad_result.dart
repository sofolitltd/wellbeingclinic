import 'package:flutter/material.dart';
import 'package:wellbeingclinic/utils/constants.dart';

import 'home.dart';

class DarkTriadResult extends StatelessWidget {
  const DarkTriadResult({
    Key? key,
    required this.machiavellianism,
    required this.psychopathy,
    required this.narcissism,
  }) : super(key: key);

  final String machiavellianism;
  final String psychopathy;
  final String narcissism;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > 1000
              ? MediaQuery.of(context).size.width * .2
              : 12,
          vertical: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //mc
                      DarkTriadCard(
                        title: 'Machiavellianism',
                        result: machiavellianism,
                        description:
                            'ম্যাকিয়াভেলিয়ানিজম হল একটি ব্যক্তিত্বের বৈশিষ্ট্য যা ধূর্ততা, কারসাজি এবং মানব প্রকৃতির একটি কুৎসিত দৃষ্টিভঙ্গি দ্বারা চিহ্নিত করা হয়।\n\n* ম্যাকিয়াভেলিয়ানদের প্রায়ই ঠান্ডা, গণনাকারী এবং নির্দয় হিসাবে দেখা হয়।\n* ম্যাকিয়াভেলিয়ানরা লোকেদের পড়তে এবং তারা যা চায় তা পাওয়ার জন্য তাদের কৌশলে দক্ষ।\n* ম্যাকিয়াভেলিয়ানরা প্রায়শই নিষ্ঠুর এবং অন্যদের প্রতি অবিশ্বাসী।\n* ম্যাকিয়াভেলিয়ানিজম প্রায়শই ব্যক্তিত্বের বৈশিষ্ট্যের \'Dark Triad\'-এর সাথে যুক্ত।',
                        color: kGreenColor,
                      ),
                      const SizedBox(height: 16),

                      //psy
                      DarkTriadCard(
                        title: 'Psychopathy',
                        result: psychopathy,
                        description:
                            'সাইকোপ্যাথি একটি মানসিক ব্যাধি যা সহানুভূতি, অনুশোচনা এবং অপরাধবোধের অভাব দ্বারা চিহ্নিত করা হয়।\n\n* সাইকোপ্যাথরা প্রায়ই কৌশলী হয়, যা তাদের সনাক্ত করা কঠিন করে তোলে।\n* তারা স্বাভাবিক মানুষের মতো মনে হতে পারে, কিন্তু তাদের সহানুভূতি এবং অনুশোচনার অভাব রয়েছে, যা বিপজ্জনক এবং ধ্বংসাত্মক আচরণের দিকে নিয়ে যেতে পারে।\n* এটা মনে রাখা গুরুত্বপূর্ণ যে সাইকোপ্যাথি একটি গুরুতর মানসিক ব্যাধি এবং যাদের এটি আছে তারা খারাপ মানুষ নয়। তারা কেবল এমন একটি শর্তের সাথে লড়াই করছে যা তাদের পক্ষে সমাজে কাজ করা কঠিন তুল পারে।',
                        color: kPinkColor,
                      ),
                      const SizedBox(height: 16),

                      //nar
                      DarkTriadCard(
                        title: 'Narcissism',
                        result: narcissism,
                        description:
                            'নার্সিসিজম হল একটি ব্যক্তিত্বের বৈশিষ্ট্য যা অত্যধিক আত্ম-প্রেম এবং নিজের ইচ্ছা, চাহিদা এবং কৃতিত্ব নিয়ে ব্যস্ততা দ্বারা চিহ্নিত করা হয়।\n\n*নার্সিসিস্টিক বৈশিষ্ট্যযুক্ত ব্যক্তিদের প্রায়শই তাদের নিজস্ব গুরুত্বের একটি অতিরঞ্জিত বোধ, ক্রমাগত প্রশংসার প্রয়োজন এবং অন্যদের প্রতি সহানুভূতির অভাব থাকে।\n* নার্সিসিস্টিক ব্যক্তিরা তাদের আচরণে প্রায়শই হেরফের, অহংকার এবং অন্যের অনুভূতির প্রতি অবজ্ঞা করে থাকে।\n* তারা সমালোচনা বা প্রত্যাখ্যানের সাথেও লড়াই করতে পারে়।',
                        color: kBlueColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                        (route) => false);
                  },
                  child: Text("Back to All Tests".toUpperCase())),
            ),
          ],
        ),
      ),
    );
  }
}

class DarkTriadCard extends StatelessWidget {
  const DarkTriadCard({
    super.key,
    required this.title,
    required this.result,
    required this.description,
    required this.color,
  });

  final String title;
  final String result;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
          width: .5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Text(
                  '$title - ',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                ),
                Text(
                  result,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: result == 'Exist' ? Colors.red : Colors.green),
                ),
              ],
            ),
          ),

          //
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontFamily: 'hindSiliguri',
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
