import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String text;

  const TextBox({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class FooterTextBox extends StatelessWidget {
  final String text;

  const FooterTextBox({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.normal
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
