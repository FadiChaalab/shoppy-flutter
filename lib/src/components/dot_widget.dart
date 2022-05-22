import 'package:flutter/material.dart';
import 'package:shop/src/utils/constante.dart';

class Dot extends StatelessWidget {
  final bool isActive;
  final bool? isRow;
  final Color? color;
  final bool isLast;
  const Dot({
    Key? key,
    required this.isActive,
    this.isRow = false,
    this.color = Colors.transparent,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kDefaultAnimationDuration,
      margin: isRow!
          ? EdgeInsets.only(right: isLast ? 0 : 4)
          : EdgeInsets.only(bottom: isLast ? 0 : 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        border: isActive || color != Colors.transparent
            ? null
            : Border.all(
                color: kBackgroundColor,
                width: 1,
              ),
        shape: BoxShape.circle,
        color: isActive ? kPrimaryColor : color,
      ),
    );
  }
}
