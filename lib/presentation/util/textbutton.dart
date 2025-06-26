import 'package:flutter/material.dart';

class CaTinderTextButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const CaTinderTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      style: TextButton.styleFrom(
        minimumSize: Size(double.infinity, 70),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
