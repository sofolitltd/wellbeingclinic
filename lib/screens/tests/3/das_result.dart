import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wellbeingclinic/utils/constants.dart';

import '../test_screen.dart';

class DASResult extends StatelessWidget {
  const DASResult({
    super.key,
    required this.depression,
    required this.anxiety,
    required this.stress,
  });

  final String depression;
  final String anxiety;
  final String stress;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Depression, Anxiety & Stress'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Depression'),
              Tab(text: 'Anxiety'),
              Tab(text: 'Stress'),

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
                      //dep
                      DasCard(
                        title: 'Depression',
                        result: depression,
                        description: '0-9    =  Normal'
                            '\n10-13  =  Mild'
                            '\n14-20 =  Moderate'
                            '\n21-27  =  Severe'
                            '\n28+    =  Extremely Severe',
                        subtitle: 'Depression বা "বিষণ্ণতা" একটি প্রচলিত এবং মারাত্মক মানসিক অসুস্থতা যা অনুভূতি, চিন্তা এবং আচরণকে নেতিবাচকভাবে প্রভাবিত করে।',
                        color: kGreenColor,
                      ),


                      //psy
                      DasCard(
                        title: 'Anxiety',
                        result: anxiety,
                        description: '0-7    =   Normal'
                            '\n8-9    =   Mild'
                            '\n10-14  =  Moderate'
                            '\n15-19  =  Severe'
                            '\n20+    =  Extremely Severe',
                        subtitle: 'Anxiety বা "উদ্বেগ" হলো কতগুলো মানসিক অসুস্থতার সমষ্টি যা মর্মপীড়া, যন্ত্রণা বা বেদনার সৃষ্টি করে স্বাভাবিক জীবনযাপনকে ব্যাহত করে।',
                        color: kPinkColor,
                      ),

                      //nar
                      DasCard(
                        title: 'Stress',
                        result: stress,
                        description: '0-14   =  Normal'
                            '\n15-18  =  Mild'
                            '\n19-25  =  Moderate'
                            '\n26-33  =  Severe'
                            '\n34+     =  Extremely Severe',
                        subtitle: 'Stress বা "চাপ" একটি শারীরিক, মানসিক, বা আবেগময় বিষয় যা দৈহিক বা মানসিক দুশ্চিন্তার কারণ হয়ে দাঁড়ায়।',
                        color: kBlueColor,
                      ),
                    ],
                  ),
                ),
              ),

              // back to test
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child:  Text("Test again".toUpperCase())),

                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text("Back to All Tests".toUpperCase())),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DasCard extends StatelessWidget {
  const DasCard({
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
                  const url = kFacebook;

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
                    vertical: 12, horizontal: 20),
                child: Text(
                  'Contact now',
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
