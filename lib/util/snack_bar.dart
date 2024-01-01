import 'package:flutter/material.dart';

class SnackBarUtils{


  static showSnackBar(context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 800),
      elevation: 5.0,
      content: Text(message),
    ));
  }


}