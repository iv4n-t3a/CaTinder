import 'package:flutter/material.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.wifi_off,
        color: Colors.red,
        size: 64.0,
      ),
    );
  }
}
