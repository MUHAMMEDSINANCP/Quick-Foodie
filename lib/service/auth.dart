// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_foodie/pages/login.dart';

class AuthMethods {
  Future<void> deleteAccount(BuildContext context) async {
    // Show confirmation dialog before deleting the account
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool deleting = false; // Add a flag to track deletion process

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Center(
                child: Column(
                  children: [
                    Text(
                      "Delete Account",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      color: Colors.red,
                      height: 2,
                    ),
                  ],
                ),
              ),
              content: deleting
                  ? const SizedBox(
                      height: 1,
                      width: 1,
                      child: CircularProgressIndicator(
                        color: Colors.red,
                        strokeWidth: 5,
                        backgroundColor: Colors.grey,
                      ),
                    )
                  : const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Are you sure you want to delete your account permanently? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 1,
                              ),
                              child: Icon(
                                Icons.warning_rounded,
                                size: 20,
                                color: Colors.redAccent,
                              ),
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                "This action cannot be undone.",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
              actions: [
                if (!deleting)
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                TextButton(
                  onPressed: deleting
                      ? null
                      : () async {
                          setState(() {
                            deleting = true; // Set deleting flag to true
                          });

                          try {
                            User? currentUser =
                                FirebaseAuth.instance.currentUser;

                            if (currentUser != null) {
                              // Get the user ID
                              String userId = currentUser.uid;

                              // Delete the user's document from Firestore
                              await FirebaseFirestore.instance
                                  .collection(
                                      'users') // Adjust this path based on your Firestore structure
                                  .doc(userId)
                                  .delete();

                              // Delete the user from Firebase Auth
                              await currentUser.delete();

                              Navigator.pop(
                                  context); // Close the confirmation dialog
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  content:
                                      Text("Your account has been deleted."),
                                  duration: Duration(seconds: 4),
                                ),
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                            }
                          } catch (error) {
                            // ignore: avoid_print
                            print("Error deleting account: $error");
                            // Handle error, show message to the user, etc.
                          }
                        },
                  child: Container(
                    width: deleting ? 115 : 65,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // margin: const EdgeInsets.only(
                    //     left: 20.0, right: 20.0, bottom: 20.0),
                    child: Center(
                      child: Text(
                        deleting ? "Deleting...." : "Delete",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                          color: Colors.white,
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
    );
  }

  Future<void> confirmLogout(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Center(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black, // Default color for text
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Logout from ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Quick Foodie',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18.0,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Divider(
                color: Colors.red,
                height: 2,
              ),
              const Divider(
                endIndent: 120,
                color: Colors.black,
                height: 2,
              ),
              const Divider(
                color: Colors.red,
                height: 2,
              )
            ],
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.0,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.0,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                // Perform logout logic here
                await FirebaseAuth.instance.signOut();

                Navigator.pop(context); // Close the confirmation dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      "You have successfully logged out.",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                    duration: Duration(seconds: 4),
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
              child: Container(
                width: 60,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                // margin: const EdgeInsets.only(
                //     left: 20.0, right: 20.0, bottom: 20.0),
                child: const Center(
                  child: Text(
                    "LogOut",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
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
}
