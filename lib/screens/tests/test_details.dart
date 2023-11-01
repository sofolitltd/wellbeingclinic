import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';

import '../../payment/credentials.dart';
import 'test_screen.dart';

class TestDetails extends StatefulWidget {
  const TestDetails({super.key});

  @override
  State<TestDetails> createState() => _TestDetailsState();
}

class _TestDetailsState extends State<TestDetails> {
  bool isLoading = false;
  late Tests test;
  int? price;

  //
  @override
  Widget build(BuildContext context) {
    test = ModalRoute.of(context)!.settings.arguments as Tests;

    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: ()async{
      //
      //
      // },),
      appBar: AppBar(
        centerTitle: true,
        title:  Text(test.title),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //img
              Container(
                height: 200,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: test.color,
                ),
                padding: const EdgeInsets.all(4),
                child: Image.asset('assets/images/${test.image}.png'),
              ),

              const SizedBox(height: 24),
              Text(
                test.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                test.description,
                style:  const TextStyle(
                  // fontSize: 14,
                  fontWeight: FontWeight.w100,
                  height: 1.4,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 24),

              const Text("Author:"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  test.author,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              //
              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('user')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: test.color,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              offset: const Offset(2, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'price',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    height: 1,
                                    color: Colors.black87,
                                  ),
                                ),

                                //
                                StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('test')
                                      .doc(test.id)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      // Get the document data from the snapshot.
                                      final DocumentSnapshot documentSnapshot =
                                          snapshot.data!;

                                      price = documentSnapshot.get('price');

                                      return Text(
                                        '$price BDT',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return const Text(
                                        '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      );
                                    } else {
                                      return const Text(
                                        '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      );
                                    }
                                  },
                                )
                              ],
                            ),

                            const SizedBox(width: 16),

                            //
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                      side:
                                          const BorderSide(color: Colors.black54),
                                      shape: const StadiumBorder(),
                                      textStyle:
                                          const TextStyle(color: Colors.black)),
                                  onPressed: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    print(price);
                                    paymentCheckout(price!.toDouble());
                                  },
                                  icon: const Icon(Icons.keyboard_arrow_right,
                                      color: Colors.black),
                                  label: const Text('Buy Now',
                                      style: TextStyle(color: Colors.black))),
                            ),
                          ],
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: test.color,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              offset: const Offset(2, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'price',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    height: 1,
                                    color: Colors.black87,
                                  ),
                                ),

                                //
                                StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('test')
                                      .doc(test.id)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      // Get the document data from the snapshot.
                                      final DocumentSnapshot documentSnapshot =
                                          snapshot.data!;

                                      price = documentSnapshot.get('price');

                                      return Text(
                                        '$price BDT',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return const Text(
                                        '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      );
                                    } else {
                                      return const Text(
                                        '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      );
                                    }
                                  },
                                )
                              ],
                            ),

                            const SizedBox(width: 16),

                            //
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                      side:
                                          const BorderSide(color: Colors.black54),
                                      shape: const StadiumBorder(),
                                      textStyle:
                                          const TextStyle(color: Colors.black)),
                                  onPressed: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    print(price);
                                    paymentCheckout(price!.toDouble());
                                  },
                                  icon: const Icon(Icons.keyboard_arrow_right,
                                      color: Colors.black),
                                  label: const Text('Buy Now',
                                      style: TextStyle(color: Colors.black))),
                            ),
                          ],
                        ),
                      );
                    }

                    List tests = snapshot.data!.get('tests');
                    print(tests);

                    if (tests.contains(test.id)) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'I agree with privacy policy',
                            style: TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: test.color,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, test.route);
                                },
                                icon: const Icon(
                                  Icons.arrow_right_alt,
                                  color: Colors.black,
                                ),
                                label:  Text('Continue'.toUpperCase(),
                                    style:const TextStyle(color: Colors.black))),
                          ),
                        ],
                      );
                    }

                    //
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: test.color,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: const Offset(2, 4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'price',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  height: 1,
                                  color: Colors.black87,
                                ),
                              ),

                              //
                              StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('test')
                                    .doc(test.id)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    // Get the document data from the snapshot.
                                    final DocumentSnapshot documentSnapshot =
                                        snapshot.data!;

                                    price = documentSnapshot.get('price');
                                    return Text(
                                      '$price BDT',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Text(
                                      '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    );
                                  } else {
                                    return const Text(
                                      '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    );
                                  }
                                },
                              )
                            ],
                          ),

                          const SizedBox(width: 16),

                          //
                          isLoading
                              ? const CircularProgressIndicator()
                              : Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                            color: Colors.black54,
                                          ),
                                          shape: const StadiumBorder(),
                                          textStyle: const TextStyle(
                                              color: Colors.black)),
                                      onPressed: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        print(price);
                                        await paymentCheckout(price!.toDouble());
                                      },
                                      icon: const Icon(Icons.keyboard_arrow_right,
                                          color: Colors.black),
                                      label: const Text('Buy Now',
                                          style: TextStyle(color: Colors.black))),
                                ),
                        ],
                      ),
                    );
                  }),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  /// payment
  Future<void> paymentCheckout(double amount) async {
    // when use [ Sandbox credentials ]
    // var credentials = const BkashCredentials(
    //   username: SandboxCredentials.username,
    //   password: SandboxCredentials.password,
    //   appKey: SandboxCredentials.appKey,
    //   appSecret: SandboxCredentials.appSecret,
    //   isSandbox: true,
    // );
    //user: 01619777282 pin: 12121 otp: 123456

    // // when use [ Live credentials ]
    var credentials = const BkashCredentials(
      username: LiveCredentials.username,
      password: LiveCredentials.password,
      appKey: LiveCredentials.appKey,
      appSecret: LiveCredentials.appSecret,
      isSandbox: false,
    );

    final flutterBkash = FlutterBkash(bkashCredentials: credentials);

    String generateInvoice() {
      // Create a random number generator.
      final Random random = Random();

      // Generate a random number in the range 10000 to 99999.
      final int randomNumber = random.nextInt(90000) + 10000;

      // Convert the random number to a string.
      final String random5DigitNumber = randomNumber.toString();

      // Return the random 5-digit number.
      return random5DigitNumber.toString();
    }

    /// Goto BkashPayment page & pass the params
    try {
      /// call pay method to pay without agreement as parameter pass the context, amount, merchantInvoiceNumber
      final result = await flutterBkash.pay(
        context: context,
        // need it double type
        amount: amount,
        payerReference: "00011122233",
        // payerReference: "01619777282", // sandbox
        merchantInvoiceNumber: generateInvoice(),
      );

      /// if the payment is [success]
      print(result.toString());
      var uid = FirebaseAuth.instance.currentUser!.uid;
      var refPurchase =
          FirebaseFirestore.instance.collection('user').doc(uid);
      final DocumentSnapshot path = await refPurchase.get();

      //
      if (path.exists) {
        await refPurchase.update({
          "tests": FieldValue.arrayUnion([test.id]),
        });
      } else {
        refPurchase.set({
          "uid": uid,
          "tests": [test.id],
        });
      }

      //
      print(result);
      await FirebaseFirestore.instance.collection('payment').doc().set({
        'uid': uid,
        'test': test.id,
        'trxId': result.trxId,
        'executeTime': result.executeTime.toString(),
        'payerReference': result.payerReference,
        'amount': amount,
      });

      // Navigator.pushNamed(context, test.route);

      /// if the payment is success then show the snack-bar
      // _showSnackbar("(Success) tranId: ${result.trxId}");
    } on BkashFailure catch (e, st) {
      /// if something went wrong then show the log
      print(e.message);
      print(st);

      /// if something went wrong then show the snack-bar
      showSnackBar(e.message);
      setState(() {
        isLoading = false;
      });
    } catch (e, st) {
      /// if something went wrong then show the log
      print(e);
      print(st);

      /// if something went wrong then show the snack-bar
      showSnackBar("Something went wrong");
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
    return;
  }

  /// show snack-bar with message
  void showSnackBar(String message) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
