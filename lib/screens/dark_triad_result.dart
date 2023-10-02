import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Machiavellianism'),
              Tab(text: 'Psychopathy'),
              Tab(text: 'Narcissism'),

            ],
          ),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TabBarView(
                    children: [
                      //mc
                      DarkTriadCard(
                        title: 'Machiavellianism',
                        result: machiavellianism,
                        description:
                            'ম্যাকিয়াভেলিয়ানিজম হল একটি ব্যক্তিত্বের বৈশিষ্ট্য যা ধূর্ততা, কারসাজি এবং মানব প্রকৃতির কুৎসিত দৃষ্টিভঙ্গি দ্বারা চিহ্নিত করা হয়।',
                        subtitle: '* ম্যাকিয়াভেলিয়ানদের প্রায়ই ঠান্ডা, গণনাকারী এবং নির্দয় হিসাবে দেখা হয়।\n* ম্যাকিয়াভেলিয়ানরা লোকেদের পড়তে এবং তারা যা চায় তা পাওয়ার জন্য তাদের কৌশলে দক্ষ।\n* ম্যাকিয়াভেলিয়ানরা প্রায়শই নিষ্ঠুর এবং অন্যদের প্রতি অবিশ্বাসী।\n* ম্যাকিয়াভেলিয়ানিজম প্রায়শই ব্যক্তিত্বের বৈশিষ্ট্যের \'Dark Triad\'-এর সাথে যুক্ত।',
                        color: kGreenColor,
                      ),

                      //psy
                      DarkTriadCard(
                        title: 'Psychopathy',
                        result: psychopathy,
                        description:
                            'সাইকোপ্যাথি একটি মানসিক ব্যাধি যা সহানুভূতি, অনুশোচনা এবং অপরাধবোধের অভাব দ্বারা চিহ্নিত করা হয়।',
                        subtitle: '* সাইকোপ্যাথরা প্রায়ই কৌশলী হয়, যা তাদের সনাক্ত করা কঠিন করে তোলে।\n* তারা স্বাভাবিক মানুষের মতো মনে হতে পারে, কিন্তু তাদের সহানুভূতি এবং অনুশোচনার অভাব রয়েছে, যা বিপজ্জনক এবং ধ্বংসাত্মক আচরণের দিকে নিয়ে যেতে পারে।\n* এটা মনে রাখা গুরুত্বপূর্ণ যে সাইকোপ্যাথি একটি গুরুতর মানসিক ব্যাধি এবং যাদের এটি আছে তারা খারাপ মানুষ নয়। তারা কেবল এমন একটি শর্তের সাথে লড়াই করছে যা তাদের পক্ষে সমাজে কাজ করা কঠিন তুল পারে।',
                        color: kPinkColor,
                      ),

                      //nar
                      DarkTriadCard(
                        title: 'Narcissism',
                        result: narcissism,
                        description:
                            'নার্সিসিজম হল একটি ব্যক্তিত্বের বৈশিষ্ট্য যা অত্যধিক আত্ম-প্রেম এবং নিজের ইচ্ছা, চাহিদা এবং কৃতিত্ব নিয়ে ব্যস্ততা দ্বারা চিহ্নিত করা হয়।',
                        subtitle: '*নার্সিসিস্টিক বৈশিষ্ট্যযুক্ত ব্যক্তিদের প্রায়শই তাদের নিজস্ব গুরুত্বের একটি অতিরঞ্জিত বোধ, ক্রমাগত প্রশংসার প্রয়োজন এবং অন্যদের প্রতি সহানুভূতির অভাব থাকে।\n* নার্সিসিস্টিক ব্যক্তিরা তাদের আচরণে প্রায়শই হেরফের, অহংকার এবং অন্যের অনুভূতির প্রতি অবজ্ঞা করে থাকে।\n* তারা সমালোচনা বা প্রত্যাখ্যানের সাথেও লড়াই করতে পারে়।',
                        color: kBlueColor,
                      ),
                    ],
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
    required this.subtitle,
    required this.color,
  });

  final String title;
  final String result;
  final String description;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        //1
        Container(
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
              // title
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 8,
                  bottom: 8,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your $title label:',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                    ),
                    Text(
                      result.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              //des
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
        ),

        const SizedBox(height: 16),

        //
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.grey,
              width: .5,
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontFamily: 'hindSiliguri',

            ),
            textAlign: TextAlign.start,
          ),
        ),

        const SizedBox(height: 24),

        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 4,
            ),
            child: Text(
              'Need mental health service?',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontFamily: 'hindSiliguri',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        //
        Row(
          children: [
            //
            Expanded(
              child: InkWell(
                onTap: () async {
                  const url = kFacebookPage;

                  if (!await launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  )) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.blue.shade400,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const Icon(Icons.facebook, color: Colors.blueAccent,),
                      const SizedBox(width: 8),
                      //
                      Text(
                        'Follow on Facebook',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                          fontFamily: 'hindSiliguri',
                          // color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //
            const SizedBox(width: 12),

            //
            InkWell(
              onTap: () async {
                const url = kContact;

                if (!await launchUrl(
                  Uri.parse(url),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw Exception('Could not launch $url');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 16),
                child: Text(
                  'Contact Us',
                  style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontFamily: 'hindSiliguri',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
