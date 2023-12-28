import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quick_foodie/admin/home_admin.dart';
import 'package:quick_foodie/pages/login.dart';
import 'package:quick_foodie/widget/widget_support.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController userpasswordcontroller = TextEditingController();
  String? emailError;
  String? passwordError;
  bool isPasswordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFededeb),
      body: Stack(
        children: [
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 1.1),
            padding: const EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                        MediaQuery.of(context).size.width, 110.0))),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
            child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.25,
                      ),
                      const Text(
                        "Let's Start as Admin!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2.4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 47.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 19),
                                  child: TextFormField(
                                    controller: usernamecontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the ID.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(18),
                                      hintText: 'Enter your ID',
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      errorText: emailError,
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 19),
                                  child: TextFormField(
                                    obscureText: !isPasswordVisible,
                                    controller: userpasswordcontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(18),
                                      hintText: 'Enter your password',
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      errorText: passwordError,
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      prefixIcon:
                                          const Icon(Icons.password_outlined),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isPasswordVisible =
                                                !isPasswordVisible;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            isPasswordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: isPasswordVisible
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                      }
                                      loginAdmin();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        isLoading
                                            ? const SizedBox(
                                                height: 24,
                                                width: 24,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 1,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.white),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                        isLoading
                                            ? const SizedBox(
                                                height: 23,
                                                width: 23,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 6,
                                                  backgroundColor: Colors.grey,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.white),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                        Center(
                                          child: isLoading
                                              ? const SizedBox.shrink()
                                              : const Text(
                                                  "LogIn",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
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
                      ),
                      const SizedBox(
                        height: 45.0,
                      ),
                      MaterialButton(
                        color: Colors.transparent,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white38),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                                Icons
                                    .exit_to_app, // Use your preferred exit icon here
                                color:
                                    Colors.red // Match the button's text color
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
                                    text: "Admin Panel",
                                    style: AppWidget.semiBoldTextFeildStyle()
                                        .copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight
                                          .w600, // Ensure consistent boldness
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
                              return AlertDialog(
                                title: const Center(
                                  child: Text(
                                    'Leave Admin Panel',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                                content: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            'Are you sure you want to Leave the ',
                                      ),
                                      TextSpan(
                                        text: 'Quick Foodie',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' Admin Panel?',
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Login()),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      height: 30,
                                      width: 80,
                                      child: const Center(
                                        child: Text(
                                          'Leave',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  loginAdmin() {
    bool found = false;

    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      if (usernamecontroller.text.trim().isEmpty ||
          userpasswordcontroller.text.trim().isEmpty) {
        setState(() {
          emailError = usernamecontroller.text.trim().isEmpty
              ? 'Please enter your email'
              : null;

          passwordError = userpasswordcontroller.text.trim().isEmpty
              ? 'Please enter your password'
              : null;
        });
        return;
      } else {
        setState(() {
          emailError = null;
          passwordError = null;
        });
      }
      for (var result in snapshot.docs) {
        if (result.data()['id'] != usernamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              dismissDirection: DismissDirection.up,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
              backgroundColor: Colors.redAccent,
              content: Center(
                child: Text(
                  "Your id is not correct",
                  style: TextStyle(fontSize: 18.0),
                ),
              )));
          setState(() {
            isLoading = false;
          });
        } else if (result.data()['password'] !=
            userpasswordcontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              dismissDirection: DismissDirection.up,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
              backgroundColor: Colors.redAccent,
              content: Center(
                child: Text(
                  "Your password is not correct",
                  style: TextStyle(fontSize: 18.0),
                ),
              )));
          setState(() {
            isLoading = false;
          });
        } else {
          found = true;
          break;
        }
      }
      if (found) {
        Route route =
            MaterialPageRoute(builder: (context) => const HomeAdmin());
        Navigator.pushReplacement(context, route);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white, // Green color for success
              title: const Center(
                child: Column(
                  children: [
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                    Divider(
                      color: Colors.black,
                      height: 2,
                    )
                  ],
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black, // Default text color
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'You have successfully logged into the '),
                      TextSpan(
                        text: 'Quick Foodie',
                        style: TextStyle(
                          color: Colors.black54, // Red color for Quick Foodie
                          fontWeight: FontWeight.bold, // Optional: Make it bold
                        ),
                      ),
                      TextSpan(text: ' Admin Panel.'),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 30,
                    width: 47,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    });
  }
}
