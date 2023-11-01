import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitSpinningLines(
          color: Color(0xff72dfc1),
          size: 100,
          lineWidth: 5,
          itemCount: 5,
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text('calculating...'),
        )
      ],
    );
  }
}
