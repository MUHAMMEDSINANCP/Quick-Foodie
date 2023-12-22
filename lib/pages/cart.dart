import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:quick_foodie/service/database.dart';
import 'package:quick_foodie/service/shared_pref.dart';
import 'package:quick_foodie/widget/widget_support.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Stream? foodStream;
  bool showProgress = false;

  bool placingOrder = false;
  String? id, wallet, address;
  int total = 0, amount2 = 0;

  void startTimer() {
    Timer(const Duration(seconds: 1), () {
      amount2 = total;
      setState(() {});
    });
  }

  getthesharedpref() async {
    id = await SharedpreferenceHelper().getUserId();
    wallet = await SharedpreferenceHelper().getUserWallet();
    address = await SharedpreferenceHelper().getUserAddress();

    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    foodStream = await DatabaseMethods().getFoodCart(id!);
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  Widget foodCart() {
    return StreamBuilder(
      stream: foodStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
              strokeWidth: 5,
              backgroundColor: Colors.white38,
            ),
          );
        } else if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return Image.asset(
            'images/emptycart.png.jpg',
            width: double.infinity,
          );
        } else {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              total = total + int.parse(ds["Total"]);

              return Dismissible(
                key: Key(ds.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.centerRight,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: Icon(Icons.delete, size: 30, color: Colors.white),
                  ),
                ),
                onDismissed: (direction) async {
                  await DatabaseMethods().removeCartItem(id!, ds.id);
                  setState(() {
                    snapshot.data.docs.removeAt(index);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 10.0,
                  ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 46,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Center(
                              child: Text(
                                'Qty: ${ds["Quantity"]}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: FancyShimmerImage(
                              errorWidget: const Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.red,
                                size: 28,
                              ),
                              imageUrl: ds["Image"],
                              height: 80,
                              width: 80,
                              boxFit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ds["Name"],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black45,
                                ),
                                Center(
                                  child: Text(
                                    '₹ ${ds["Total"]}',
                                    style: AppWidget.semiBoldTextFeildStyle(),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Food Cart",
          style: AppWidget.boldTextFeildStyle(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.width * 1.22,
            child: foodCart(),
          ),
          const Spacer(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Price",
                  style: AppWidget.boldTextFeildStyle(),
                ),
                Text(
                  "₹ $total",
                  style: AppWidget.semiBoldTextFeildStyle(),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          GestureDetector(
            onTap: () async {
              if (total == 0) {
                // If cart is empty, show alert dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Transform.scale(
                      scale: 0.8,
                      child: AlertDialog(
                        title: const Center(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 5, left: 50),
                                    child: Icon(
                                      Icons.warning_rounded,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    " Empty Cart",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.0,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins'),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.red,
                                height: 2,
                              ),
                            ],
                          ),
                        ),
                        content: const Padding(
                          padding: EdgeInsets.only(top: 14),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              "Your Quick Foodie cart is empty. Please add foods to place an order.",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(); // Close the insufficient funds alert
                            },
                            child: Container(
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                setState(() {
                  showProgress = true; // Show the progress indicator
                });

                // Simulate a 2-second delay using Timer
                Timer(const Duration(seconds: 2), () {
                  setState(() {
                    showProgress =
                        false; // Hide the progress indicator after 2 seconds
                  });

                  // Proceed with checkout logic after 2 seconds
                  showConfirmationDialog(context);
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              margin:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: Center(
                child: showProgress
                    ? const SizedBox(
                        height: 0.1,
                        width: 150,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.red,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 4,
                        ),
                      )
                    : const Text(
                        "CheckOut",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Transform.scale(
              scale: 0.85,
              child: AlertDialog(
                title: const Center(
                  child: Column(
                    children: [
                      Text(
                        "Confirm Order",
                        style: TextStyle(
                            color: Colors.redAccent,
                            letterSpacing: 2,
                            fontSize: 16.0,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Divider(
                        color: Colors.red,
                        height: 2,
                      )
                    ],
                  ),
                ),
                content: const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Are you sure you want to place this order?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  TextButton(
                    onPressed: placingOrder
                        ? null
                        : () async {
                            setState(() {
                              placingOrder = true; // Update placingOrder state
                            });
                            int remainingAmount = int.parse(wallet!) - total;
                            if (remainingAmount >= 0) {
                              // Process the order and deduct the total price from the wallet
                              await DatabaseMethods().updateUserWallet(
                                  id!, remainingAmount.toString());
                              await SharedpreferenceHelper()
                                  .saveUserWallet(remainingAmount.toString());
                              await DatabaseMethods().removeAllCartItems(id!);

                              if (mounted) {
                                setState(() {
                                  placingOrder =
                                      false; // Reset placingOrder state
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 40, horizontal: 20),
                                    content: Text(
                                      '''Your order is placed and will be delivered to your home address :- $address''',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins'),
                                    ),
                                    duration: const Duration(seconds: 4),
                                  ),
                                );
                              }
                              // Close the dialog
                              if (mounted) {
                                Navigator.of(context).pop();
                              }
                            } else {
                              // Insufficient funds alert
                              Navigator.of(context)
                                  .pop(); // Close the confirmation dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Transform.scale(
                                    scale: 0.8,
                                    child: AlertDialog(
                                      title: const Center(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 5, left: 20),
                                                  child: Icon(
                                                    Icons.warning_rounded,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  " Insufficient Funds",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17.0,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Poppins'),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.red,
                                              height: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      content: const Padding(
                                        padding: EdgeInsets.only(top: 14),
                                        child: Text(
                                          "Your wallet does not have sufficient balance to complete this order.",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins'),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the insufficient funds alert
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Center(
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins'),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: placingOrder
                            ? const SizedBox(
                                height: 0.1,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.red),
                                  strokeWidth: 4,
                                ),
                              )
                            : const Text(
                                "Confirm",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
