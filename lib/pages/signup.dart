import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_foodie/admin/admin_login.dart';
import 'package:quick_foodie/pages/bottom_nav.dart';
import 'package:quick_foodie/pages/login.dart';
import 'package:quick_foodie/service/database.dart';
import 'package:quick_foodie/service/shared_pref.dart';
import 'package:random_string/random_string.dart';
import '../widget/widget_support.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name = "";
  String password = "";
  String email = "";
  String address = "";

  bool isLoading = false;
  bool isPasswordVisible = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Form(
            key: _formkey,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.red, Colors.red])),
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
                      height: MediaQuery.of(context).size.height / 1.76,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            Divider(
                              color: Colors.red.shade300,
                              height: 2,
                              indent: 90,
                              thickness: 2,
                              endIndent: 90,
                            ),
                            Text(
                              "Sign up",
                              style: AppWidget.headlineTextFeildStyle(),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Divider(
                              color: Colors.red.shade300,
                              height: 2,
                              indent: 90,
                              thickness: 2,
                              endIndent: 90,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Name',
                                  hintStyle: AppWidget.semiBoldTextFeildStyle(),
                                  prefixIcon:
                                      const Icon(Icons.person_outlined)),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your mail address.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: AppWidget.semiBoldTextFeildStyle(),
                                  prefixIcon: const Icon(Icons.email_outlined)),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              controller: addressController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your home address.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Address',
                                  hintStyle: AppWidget.semiBoldTextFeildStyle(),
                                  prefixIcon: const Icon(
                                    Icons.home_outlined,
                                    size: 27,
                                  )),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: !isPasswordVisible,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please create a password.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: AppWidget.semiBoldTextFeildStyle(),
                                prefixIcon: const Icon(Icons.password_outlined),
                                suffixIcon: GestureDetector(
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
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formkey.currentState!.validate()) {
                                  if (nameController.text.isEmpty ||
                                      emailController.text.isEmpty ||
                                      addressController.text.isEmpty ||
                                      passwordController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        dismissDirection: DismissDirection.down,
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          "Please fill in all fields.",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      name = nameController.text.trim();
                                      email = emailController.text.trim();
                                      address = addressController.text.trim();
                                      password = passwordController.text.trim();
                                    });
                                    registration();
                                  }
                                }
                              },
                              child: Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: isLoading
                                        ? const SizedBox(
                                            height: 0.1,
                                            width: 140,
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.red,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                              strokeWidth: 4,
                                            ),
                                          )
                                        : const Text(
                                            "SIGN UP",
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
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account?  ",
                        style: AppWidget
                            .semiBoldTextFeildStyle(), // Style for the first part of the text
                        children: <TextSpan>[
                          TextSpan(
                            text: "Login",
                            style: AppWidget.semiBoldTextFeildStyle().copyWith(
                              color: Colors.red,
                              // Changing only the color of "Login" text
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  const Text(
                    "Or",
                  ),
                  const SizedBox(
                    height: 3.0,
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
                        text: "Switch to ",
                        style: AppWidget
                            .semiBoldTextFeildStyle(), // Style for the first part of the text
                        children: <TextSpan>[
                          TextSpan(
                            text: "Admin Panel",
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
          )
        ],
      ),
    );
  }

  registration() async {
    try {
      setState(() {
        isLoading = true;
      });

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Save user details to Firebase or your database
      String id = randomAlphaNumeric(10);
      Map<String, dynamic> addUserInfo = {
        "Name": nameController.text.trim(),
        "Email": emailController.text.trim(),
        'Address': addressController.text.trim(),
        "Wallet": "0",
        "Id": id,
      };
      await DatabaseMethods().addUserDetail(addUserInfo, id);

      // Save user details in SharedPreferences
      await SharedpreferenceHelper().saveUserName(nameController.text.trim());
      await SharedpreferenceHelper().saveUserEmail(emailController.text.trim());
      await SharedpreferenceHelper()
          .saveUserAddress(addressController.text.trim());
      await SharedpreferenceHelper().saveUserWallet("0");
      await SharedpreferenceHelper().saveUserId(id);

      // Show registration success message
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
                    "Registered Successfully!",
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const BottomNav(
                    initialIndex: 0,
                  )),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred, please try again.";
      if (e.code == 'invalid-email') {
        errorMessage = "Invalid email address.";
      } else if (e.code == 'weak-password') {
        errorMessage = "Password provided is too weak!";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "Account already exists!";
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
            dismissDirection: DismissDirection.horizontal,
            backgroundColor: Colors.redAccent,
            content: Text(
              errorMessage,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
