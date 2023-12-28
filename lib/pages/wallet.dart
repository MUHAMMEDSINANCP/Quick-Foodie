// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:quick_foodie/common_widgets/default_wallets_amounts.dart';
import 'package:quick_foodie/service/database.dart';
import 'package:quick_foodie/service/shared_pref.dart';
import 'package:quick_foodie/widget/stripe_api.dart';
import 'package:quick_foodie/widget/widget_support.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool isLoading = false;
  String? wallet;
  String? id;
  int? add;
  TextEditingController amountcontroller = TextEditingController();

  getthesharedpref() async {
    wallet = await SharedpreferenceHelper().getUserWallet();
    id = await SharedpreferenceHelper().getUserId();

    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallet == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
                strokeWidth: 5,
                backgroundColor: Colors.white38,
              ),
            )
          : Container(
              margin: const EdgeInsets.only(top: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: 2.0,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Center(
                        child: Text(
                          "Quick Foodie Wallet",
                          style: TextStyle(
                            foreground: Paint()
                              ..shader = const LinearGradient(
                                colors: [
                                  Colors.redAccent,
                                  Colors.red,
                                  Colors.black,
                                  Colors.red,
                                  Colors.black,
                                  Colors.red,
                                  Colors.black,
                                  Colors.red,
                                  Colors.black,
                                  Colors.red,
                                  Colors.red,
                                  Colors.black,
                                ], // Replace with your gradient colors
                              ).createShader(const Rect.fromLTWH(
                                  50.0,
                                  50.0,
                                  270.0,
                                  150.0)), // Adjust the Rect size as needed
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Image.asset(
                          "images/ewallet.png",
                          height: 53,
                          width: 53,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 25.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Wallet",
                              style: AppWidget.semiBoldTextFeildStyle(),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "₹ ${wallet!}",
                              style: AppWidget.boldTextFeildStyle(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Add Money",
                      style: AppWidget.semiBoldTextFeildStyle(),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            makePayment('100');
                          },
                          child: const DefaultWalletAmount(amount: "₹ " "100")),
                      GestureDetector(
                          onTap: () {
                            makePayment('500');
                          },
                          child: const DefaultWalletAmount(amount: "₹ " "500")),
                      GestureDetector(
                          onTap: () {
                            makePayment('1000');
                          },
                          child:
                              const DefaultWalletAmount(amount: "₹ " "1000")),
                      GestureDetector(
                        onTap: () {
                          makePayment('2000');
                        },
                        child: const DefaultWalletAmount(
                          amount: "₹ " "2000",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      opeEdit();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: isLoading
                            ? const Center(
                                child: SizedBox(
                                height: 0.1,
                                width: 150,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.red,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  strokeWidth: 4,
                                ),
                              ))
                            : const Text(
                                "Add Money",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      if (amount.isEmpty) {
        // Show error message if amount is empty
        showDialog(
          context: context,
          builder: (_) => Transform.scale(
            scale: 0.8,
            child: const AlertDialog(
              content: Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  'Please enter the amount!',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
        return;
      }

      setState(() {
        isLoading = true;
      });

      paymentIntent = await createPaymentIntent(amount, 'INR');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Sinan'))
          .then((value) {});
      setState(() {
        isLoading = false;
      });
      displayPaymentSheet(amount);
    } catch (e, s) {
      print('exception: $e\n$s');
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        add = int.parse(wallet!) + int.parse(amount);
        await SharedpreferenceHelper().saveUserWallet(add.toString());
        await DatabaseMethods().updateUserWallet(
          id!,
          add.toString(),
        );
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 11,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 26,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "Payment Successful.",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ));

        await getthesharedpref();

        paymentIntent = null;
        amountcontroller.clear();
      }).onError((error, stackTrace) {
        print('Error is ---> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is: ---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text(
                  "Cancelled",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ));
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print('Payment Intent Body ->>>  ${response.body.toString()}');

      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculateAmount = (int.parse(amount)) * 100;

    return calculateAmount.toString();
  }

  Future opeEdit() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.cancel,
                      ),
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    const Center(
                      child: Text(
                        "Add Money to Wallet",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  height: 1,
                  indent: 54,
                  endIndent: 43,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 2.0),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: TextField(
                    controller: amountcontroller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Amount',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      makePayment(
                        amountcontroller.text.trim(),
                      );
                    },
                    child: Container(
                      width: 80,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Pay",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
