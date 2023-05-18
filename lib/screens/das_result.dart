import 'package:flutter/material.dart';
import 'package:wellbeingclinic/utils/constants.dart';

import 'home.dart';

class DASResult extends StatelessWidget {
  const DASResult({
    Key? key,
    required this.depression,
    required this.anxiety,
    required this.stress,
  }) : super(key: key);

  final String depression;
  final String anxiety;
  final String stress;

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
                      DasCard(
                        title: 'Depression',
                        result: depression,
                        description: '0-9 = Normal'
                            '\n10-13 =  Mild'
                            '\n14-20 = Moderate'
                            '\n21-27 = Severe'
                            '\n28+ = Extremely Severe',
                        color: kGreenColor,
                      ),
                      const SizedBox(height: 16),

                      //psy
                      DasCard(
                        title: 'Anxiety',
                        result: anxiety,
                        description: '0-7 = Normal'
                            '\n8-9 =  Mild'
                            '\n10-14 = Moderate'
                            '\n15-19 = Severe'
                            '\n20+ = Extremely Severe',
                        color: kPinkColor,
                      ),
                      const SizedBox(height: 16),

                      //nar
                      DasCard(
                        title: 'Stress',
                        result: stress,
                        description: '0-14 = Normal'
                            '\n15-18 =  Mild'
                            '\n19-25 = Moderate'
                            '\n26-29 = Severe'
                            '\n34+ = Extremely Severe',
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

class DasCard extends StatelessWidget {
  const DasCard({
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
                  '$title :  ',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                ),
                Text(
                  result,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
                    fontFamily: 'tiro',
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
