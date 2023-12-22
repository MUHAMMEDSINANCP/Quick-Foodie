import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_foodie/pages/bottom_nav.dart';
import 'package:quick_foodie/pages/forgot_password.dart';
import 'package:quick_foodie/pages/signup.dart';
import '../admin/admin_login.dart';
import '../widget/widget_support.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";
  bool isLoading = false;
  bool isPasswordVisible = false;

  final _formkey = GlobalKey<FormState>();

  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.red,
                  Colors.red,
                ],
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: const Text(""),
          ),
          Container(
            margin: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25.0,
                  ),
                  Center(
                      child: Image.asset(
                    "images/logo.png",
                    width: MediaQuery.of(context).size.width / 1.5,
                    fit: BoxFit.cover,
                  )),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.27,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10.0,
                              ),
                              Divider(
                                color: Colors.red.shade300,
                                height: 2,
                                indent: 105,
                                thickness: 2,
                                endIndent: 105,
                              ),
                              Text(
                                "Login",
                                style: AppWidget.headlineTextFeildStyle(),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Divider(
                                color: Colors.red.shade300,
                                height: 2,
                                indent: 105,
                                thickness: 2,
                                endIndent: 105,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: userEmailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a email.";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle:
                                        AppWidget.semiBoldTextFeildStyle(),
                                    prefixIcon:
                                        const Icon(Icons.email_outlined)),
                              ),
                              const SizedBox(
                                height: 26.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: userPasswordController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your password.";
                                        }
                                        return null;
                                      },
                                      obscureText: !isPasswordVisible,
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        hintStyle:
                                            AppWidget.semiBoldTextFeildStyle(),
                                        prefixIcon:
                                            const Icon(Icons.password_outlined),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: isPasswordVisible
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 14.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword(),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13.0,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 22.0,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      email = userEmailController.text.trim();
                                      password =
                                          userPasswordController.text.trim();
                                    });
                                  }
                                  userLogin();
                                },
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: isLoading
                                          ? const SizedBox(
                                              height: 0.1,
                                              width: 140,
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.red,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                                strokeWidth: 4,
                                              ),
                                            )
                                          : const Text(
                                              "LOGIN",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                  fontFamily: 'Poppins1',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an Account?  ",
                        style: AppWidget
                            .semiBoldTextFeildStyle(), // Style for the first part of the text
                        children: <TextSpan>[
                          TextSpan(
                            text: "SignUp",
                            style: AppWidget.semiBoldTextFeildStyle()
                                .copyWith(color: Colors.red
                                    // Changing only the color of "Login" text
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "Or",
                    style: TextStyle(letterSpacing: 1),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminLogin()));
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Login as ",
                        style: AppWidget
                            .semiBoldTextFeildStyle(), // Style for the first part of the text
                        children: <TextSpan>[
                          TextSpan(
                            text: "Admin",
                            style: AppWidget.semiBoldTextFeildStyle()
                                .copyWith(color: Colors.black54
                                    // Changing only the color of "Login" text
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void userLogin() async {
    if (userEmailController.text.isEmpty ||
        userPasswordController.text.isEmpty) {
      showSnackBar(
        "Please enter both email and password",
        Colors.redAccent,
      );
      return; // Stop execution if fields are empty
    }

    try {
      setState(() {
        isLoading = true;
      });

      await signInUser();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            duration: const Duration(seconds: 1),
            backgroundColor: Colors
                .white, // Set the Snackbar background color to transparent
            content: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.red,
                    width: 2), // Define the border color and width
                borderRadius: BorderRadius.circular(
                    8), // Adjust the border radius as needed
              ),
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Center(
                  child: Text(
                    "Welcome back to Quick Foodie App!",
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
        navigateToHome();
      }
    } on FirebaseException catch (e) {
      handleFirebaseException(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> signInUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: userEmailController.text.trim(),
      password: userPasswordController.text.trim(),
    );
  }

  void showSnackBar(
    String message,
    Color color, {
    double fontSize = 15,
    DismissDirection dismissDirection = DismissDirection.up,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        dismissDirection: dismissDirection,
        content: Text(
          message,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void handleFirebaseException(FirebaseException e) {
    String errorMessage =
        "Invalid Credentials! Check your email & password again.";

    if (e.code == 'user-not-found') {
      errorMessage = "No user found for that email.";
    } else if (e.code == 'wrong-password') {
      errorMessage = "Wrong password provided by the user.";
    }

    if (context.mounted) {
      showSnackBar(
        errorMessage,
        Colors.redAccent,
        fontSize: 15,
        dismissDirection: DismissDirection.down,
      );
    }
  }

  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const BottomNav(
                initialIndex: 0,
              )),
    );
  }
}
