import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/result_model.dart';
import '../utils/constants.dart';
import 'home.dart';

class SelfEsteemResult extends StatelessWidget {
  const SelfEsteemResult({Key? key, required this.resultModel})
      : super(key: key);

  final ResultModel resultModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > 1000
              ? MediaQuery.of(context).size.width * .2
              : 12,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      strokeWidth: 16,
                      color: Colors.red,
                      backgroundColor: Colors.blue.shade100,
                      value: resultModel.sum / 30,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Your Self-esteem is',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  //

                  Text(
                    resultModel.title.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                      color: resultModel.title == 'Low'
                          ? Colors.red
                          : resultModel.title == 'Normal'
                          ? Colors.orange
                          : Colors.green,
                    ),
                  ),

                  //
                  const SizedBox(height: 16),

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
                      resultModel.subtitle,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontFamily: 'hindSiliguri',
                          ),
                      textAlign: TextAlign.center,
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
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                      (route) => false);
                },
                child: Text("Back to All Tests".toUpperCase())),
          ],
        ),
      ),
    );
  }
}
