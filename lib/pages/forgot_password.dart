// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_foodie/pages/signup.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController mailController = TextEditingController();

  String email = "";
  bool isLoading = false;

  final _formkey = GlobalKey<FormState>();

  resetPassword() async {
    try {
      setState(() {
        isLoading = true;
      });

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Password Reset Email has been sent Successfully!!",
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Error resetting password. Please try again.";

      if (e.code == "user-not-found") {
        errorMessage = "No user found for that email.";
        setState(() {
          isLoading = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 15.0,
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: const Text(
              "Password Recovery",
              style: TextStyle(
                color: Colors.black,
                fontSize: 29.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            "Enter your Registered Email",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 17.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: mailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 30.0,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            email = mailController.text;
                          });
                          resetPassword();
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        width: 140,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: isLoading
                              ? const SizedBox(
                                  height: 0.1,
                                  width: 140,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.red,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                    strokeWidth: 4,
                                  ),
                                )
                              : const Text(
                                  "Send Email",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Dont't have an account?",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUp(),
                              ),
                            );
                          },
                          child: const Text(
                            "Create",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 17.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
