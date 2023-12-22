import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:quick_foodie/service/database.dart';
import 'package:quick_foodie/service/shared_pref.dart';

import '../widget/widget_support.dart';

class Details extends StatefulWidget {
  final String image;
  final String name;
  final String detail;
  final String price;

  const Details(
      {super.key,
      required this.image,
      required this.name,
      required this.detail,
      required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1;
  int total = 0;
  String? id;
  bool addingToCart = false;

  getthesharedprefs() async {
    id = await SharedpreferenceHelper().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedprefs();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
    total = int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    weight: 10,
                    size: 30,
                    color: Colors.red,
                  )),
              const SizedBox(
                height: 15,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FancyShimmerImage(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  errorWidget: const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                    size: 28,
                  ),
                  imageUrl: widget.image,
                  boxFit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   widget.name,
                        //   style: AppWidget.semiBoldTextFeildStyle(),
                        // ),
                        Text(
                          widget.name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.14,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (a > 1) {
                        --a;
                        total = total - int.parse(widget.price);
                      }
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38),
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    a.toString(),
                    style: AppWidget.semiBoldTextFeildStyle(),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      ++a;
                      total = total + int.parse(widget.price);
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38),
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                widget.detail,
                maxLines: 4,
                style: AppWidget.lightTextFeildStyle(),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Text(
                    "Delivery Time  :",
                    style: AppWidget.semiBoldTextFeildStyle(),
                  ),
                  const SizedBox(
                    width: 25.0,
                  ),
                  const Icon(
                    Icons.alarm,
                    color: Colors.red,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "30 min",
                    style: AppWidget.semiBoldTextFeildStyle(),
                  )
                ],
              ),
              const SizedBox(
                height: 1,
              ),
              const Divider(
                color: Colors.black45,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Price",
                          style: AppWidget.semiBoldTextFeildStyle(),
                        ),
                        Text(
                          "₹ $total",
                          style: AppWidget.headlineTextFeildStyle(),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          addingToCart =
                              true; // Set loading state to true when adding to cart
                        });

                        Map<String, dynamic> addFoodtoCart = {
                          "Name": widget.name,
                          "Quantity": a.toString(),
                          "Total": total.toString(),
                          "Image": widget.image,
                        };
                        await DatabaseMethods()
                            .addFoodToCart(addFoodtoCart, id!);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              dismissDirection: DismissDirection.up,
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20),
                              duration: const Duration(seconds: 1),
                              backgroundColor: Colors
                                  .white, // Set the Snackbar background color to transparent
                              content: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.red,
                                      width:
                                          2), // Define the border color and width
                                  borderRadius: BorderRadius.circular(
                                      8), // Adjust the border radius as needed
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Center(
                                    child: Text(
                                      "Food Added to Cart.",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 15.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        if (mounted) {
                          Navigator.pop(context);
                        }

                        // After adding to cart operation is complete:
                        setState(() {
                          addingToCart =
                              false; // Set loading state back to false
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: addingToCart
                            ? const SizedBox(
                                height: 0.1,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.red,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  strokeWidth: 4,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Add to cart",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Transform.scale(
                                    scale: 0.94,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black54),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: const Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
