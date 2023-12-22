import 'package:flutter/material.dart';
import 'package:quick_foodie/admin/add_food.dart';
import 'package:quick_foodie/pages/login.dart';
import 'package:quick_foodie/widget/widget_support.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Center(
              child: Text(
                "Admin Home",
                style: AppWidget.headlineTextFeildStyle(),
              ),
            ),
            const Divider(
              color: Colors.black,
              height: 2,
              endIndent: 80,
              indent: 80,
            ),
            const SizedBox(
              height: 50.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddFood()));
              },
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Image.asset(
                            "images/food.jpg",
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 30.0,
                        ),
                        const Text(
                          "Add Food Items",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              child: MaterialButton(
                color: Colors.white,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.black54,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.exit_to_app, // Use your preferred exit icon here
                      color: Colors.red, // Match the button's text color
                    ),
                    RichText(
                      text: TextSpan(
                        text: " Leave ",
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Admin Panel ",
                            style: AppWidget.semiBoldTextFeildStyle().copyWith(
                              color: Colors.black54,
                              fontWeight:
                                  FontWeight.w600, // Ensure consistent boldness
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Transform.scale(
                        scale: 0.9,
                        child: AlertDialog(
                          title: const Center(
                            child: Column(
                              children: [
                                Text(
                                  'Quick Foodie Admin Panel',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Divider(
                                  color: Colors.black54,
                                  height: 1,
                                  indent: 5,
                                  endIndent: 1,
                                )
                              ],
                            ),
                          ),
                          content: const Padding(
                            padding: EdgeInsets.only(top: 10, left: 10),
                            child: Text(
                              'Are you sure you want to leave Admin Panel?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(12)),
                                height: 30,
                                width: 100,
                                child: const Center(
                                  child: Text(
                                    'Leave',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
