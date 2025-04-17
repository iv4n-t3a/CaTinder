import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onPressed;
  final IconData icon;

  const Button({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(80, 80),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      onPressed: () => onPressed(),
      child: Icon(
        icon,
        size: 32,
      ),
    );
  }
}
