import 'package:flutter/material.dart';

import '../screens/tests/test_screen.dart';

class TestCardGrid extends StatelessWidget {
  const TestCardGrid({
    super.key,
    required this.test,
  });

  final Tests test;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/tests', arguments: test);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 12, 5, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: test.color,
              ),
              padding: const EdgeInsets.all(4),
              child: Image.asset('assets/images/${test.image}.png'),
            ),
            const SizedBox(height: 8),
            const Spacer(),

            Text(
              test.title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    // letterSpacing: .4,
                    height: 1.2,
                  ),
            ),
            const Spacer(),

            //todo: reconsider description later
            // const SizedBox(height: 4),
            // Expanded(
            //   child: Text(
            //     test.description,
            //     textAlign: TextAlign.center,
            //     maxLines: 4,
            //     overflow: TextOverflow.ellipsis,
            //     style: Theme.of(context).textTheme.labelMedium!.copyWith(
            //           wordSpacing: 1.2,
            //           height: 1.13,
            //           letterSpacing: .2,
            //           fontWeight: FontWeight.w500,
            //           color: Colors.blueGrey,
            //         ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
