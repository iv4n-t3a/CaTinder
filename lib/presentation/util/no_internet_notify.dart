import 'package:flutter/material.dart';

void notifyNoInternet(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("No internet :("),
      backgroundColor: Colors.red,
    ),
  );
}
