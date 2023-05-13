import 'package:flutter/material.dart';

import '../models/result_model.dart';
import 'home.dart';

class SocialAnxietyResult extends StatelessWidget {
  const SocialAnxietyResult({Key? key, required this.resultModel})
      : super(key: key);

  final ResultModel resultModel;

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
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //
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
                      value: resultModel.sum / 28,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    resultModel.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  //
                  const SizedBox(height: 24),

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
                            fontFamily: 'tiro',
                          ),
                      textAlign: TextAlign.center,
                    ),
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
