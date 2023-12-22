import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:quick_foodie/pages/bottom_nav.dart';
import 'package:quick_foodie/pages/details.dart';
import 'package:quick_foodie/service/database.dart';
import 'package:quick_foodie/service/shared_pref.dart';
import '../widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName = "";

  bool icecream = false, pizza = false, salad = false, burger = false;

  Stream? fooditemStream;

  ontheload() async {
    icecream = true; // Set ice cream as selected
    pizza = false;
    salad = false;
    burger = false;
    fooditemStream = await DatabaseMethods().getFoodItem("Ice-cream");
    setState(() {});
  }

  // Fetch the username from shared preferences
  getUserInfo() async {
    String? name = await SharedpreferenceHelper().getUserName();
    if (name != null) {
      setState(() {
        userName = name;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
    ontheload();
  }

  List<Divider> generateDividers() {
    List<Divider> dividers = [];
    int initialIndent = 24;
    int numberOfDividers = 15;

    for (int i = 0; i < numberOfDividers; i++) {
      dividers.add(
        Divider(
          color: i.isEven ? Colors.red : Colors.black,
          height: 5,
          thickness: 1,
          endIndent: initialIndent * (i + 1),
        ),
      );
    }

    return dividers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(top: 50.0, left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Welcome, ',
                            style: TextStyle(
                                color: Colors.red,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                fontFamily:
                                    'Poppins' // Add any other styles you want for the username
                                ),
                            // Add any other styles you want for the "Welcome" text
                          ),
                          const TextSpan(
                            text: "\n   ",
                          ),
                          TextSpan(
                            text: userName,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontFamily:
                                    'Poppins' // Add any other styles you want for the username
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Tooltip(
                    message: "Hot Trending",
                    child: GestureDetector(
                      onTap: () async {
                        icecream = false;
                        pizza = false;
                        salad = false;
                        burger = true;
                        fooditemStream =
                            await DatabaseMethods().getFoodItem("Burger");
                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 1,
                  ),
                  Tooltip(
                    message: "Go to Food Cart",
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomNav(
                                    initialIndex: 1,
                                  )),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ...generateDividers(),
              const Center(
                child: Text("Explore Delicious Foods",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 23.0,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins')),
              ),
              const Padding(
                padding: EdgeInsets.all(1.0),
                child: Center(
                  child: Text("Order Effortlessly from Quick Foodie.",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12.0,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins')),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: showItem()),
              const SizedBox(
                height: 11.0,
              ),
              SizedBox(height: 300, child: allItems()),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: allItemsVertically(),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                icecream = true;
                pizza = false;
                salad = false;
                burger = false;
                setState(() {});
                fooditemStream =
                    await DatabaseMethods().getFoodItem("Ice-cream");
              },
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: icecream ? Colors.red : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    "images/ice-cream.png",
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    color: icecream ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 26,
            ),
            GestureDetector(
              onTap: () async {
                icecream = false;
                pizza = true;
                salad = false;
                burger = false;
                fooditemStream = await DatabaseMethods().getFoodItem("Pizza");

                setState(() {});
              },
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: pizza ? Colors.red : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    "images/pizza.png",
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    color: pizza ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 26,
            ),
            GestureDetector(
              onTap: () async {
                icecream = false;
                pizza = false;
                salad = true;
                burger = false;
                fooditemStream = await DatabaseMethods().getFoodItem("Salad");

                setState(() {});
              },
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: salad ? Colors.red : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    "images/salad.png",
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    color: salad ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 26,
            ),
            GestureDetector(
              onTap: () async {
                icecream = false;
                pizza = false;
                salad = false;
                burger = true;
                fooditemStream = await DatabaseMethods().getFoodItem("Burger");

                setState(() {});
              },
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: burger ? Colors.red : Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    "images/burger.png",
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    color: burger ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget allItems() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(
                              detail: ds["Detail"],
                              name: ds["Name"],
                              price: ds["Price"],
                              image: ds["Image"],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 190,
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Builder(builder: (context) {
                                      return Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          child: FancyShimmerImage(
                                            height: 151,
                                            width: double.infinity,
                                            errorWidget: const Icon(
                                              Icons.warning_amber_rounded,
                                              color: Colors.red,
                                              size: 28,
                                            ),
                                            imageUrl: ds["Image"],
                                            boxFit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }),
                                    Text(ds["Name"],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins')),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(ds["Detail"],
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 11.0,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins')),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "₹ ${ds["Price"]}",
                                      style: AppWidget.semiBoldTextFeildStyle(),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : const SizedBox();
          // const SizedBox(
          //     height: 10,
          //     width: 10,
          //     child: CircularProgressIndicator(
          //       color: Colors.black,
          //       strokeWidth: 2,
          //     ));
        });
  }

  Widget allItemsVertically() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot
                        .data.docs[snapshot.data.docs.length - index - 1];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(
                              detail: ds["Detail"],
                              name: ds["Name"],
                              price: ds["Price"],
                              image: ds["Image"],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin:
                            const EdgeInsets.only(right: 20.0, bottom: 20.0),
                        child: Material(
                          elevation: 7.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Builder(builder: (context) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: FancyShimmerImage(
                                      height: 120,
                                      width: 120,
                                      errorWidget: const Icon(
                                        Icons.warning_amber_rounded,
                                        color: Colors.red,
                                        size: 28,
                                      ),
                                      imageUrl: ds["Image"],
                                      boxFit: BoxFit.cover,
                                    ),
                                  );
                                }),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Text(
                                            ds["Name"],
                                            softWrap: true,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins'),
                                          )),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Text(
                                            ds["Detail"],
                                            style:
                                                AppWidget.lightTextFeildStyle(),
                                          )),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Text(
                                            '₹ ${ds["Price"]}',
                                            style: AppWidget
                                                .semiBoldTextFeildStyle(),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : const SizedBox();
          // const SizedBox(
          //     height: 10,
          //     width: 10,
          //     child: CircularProgressIndicator(
          //       color: Colors.black,
          //       strokeWidth: 2,
          //     ));
        });
  }
}
