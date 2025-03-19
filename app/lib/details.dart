import 'package:app/loader.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final Image image;
  final CatCard card;

  const Details({
    super.key,
    required this.image,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.breed),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  image,
                  Text(card.description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
