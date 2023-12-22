import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextFeildStyle() {
    return const TextStyle(
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle headlineTextFeildStyle() {
    return const TextStyle(
        color: Colors.black,
        fontSize: 23.0,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins');
  }

  static TextStyle lightTextFeildStyle() {
    return const TextStyle(
        color: Colors.black54,
        fontSize: 15.0,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }

  static TextStyle semiBoldTextFeildStyle() {
    return const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins');
  }
}
