import 'package:app/presentation/swiper/card.dart';
import 'package:flutter/material.dart';

class SwiperWidget extends StatelessWidget {
  final CardWidget _card;
  final Function onRightSwipe;
  final Function onLeftSwipe;
  final Function onTap;

  const SwiperWidget({
    super.key,
    required CardWidget card,
    required this.onRightSwipe,
    required this.onLeftSwipe,
    required this.onTap,
  }) : _card = card;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              onRightSwipe();
            } else if (direction == DismissDirection.endToStart) {
              onLeftSwipe();
            }
          },
          child: _card,
        ),
      ),
    );
  }
}
