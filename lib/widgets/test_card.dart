import 'package:flutter/material.dart';

import '../screens/home.dart';

class TestCard extends StatelessWidget {
  const TestCard({
    super.key,
    required this.test,
  });

  final Tests test;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, test.route);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      test.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      test.description,
                      style:
                          Theme.of(context).textTheme.labelMedium!.copyWith(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
