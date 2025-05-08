import 'package:flutter/widgets.dart';

class Swipable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onRightSwipe;
  final VoidCallback? onLeftSwipe;

  const Swipable({
    super.key,
    required this.child,
    this.onTap,
    this.onRightSwipe,
    this.onLeftSwipe,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.horizontal,
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            onRightSwipe?.call();
          } else if (direction == DismissDirection.endToStart) {
            onLeftSwipe?.call();
          }
        },
        child: child,
      ),
    );
  }
}
