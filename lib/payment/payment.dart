import 'package:flutter/material.dart';


class Payment extends StatefulWidget {
  const Payment({super.key});
  static const routeName = '/payment';

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wellbeing Clinic"),
      ),
      body: const Center(child: Text('Payment Successful')),
    );
  }
}
