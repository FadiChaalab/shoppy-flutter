import 'package:flutter/material.dart';
import 'package:shop/src/utils/constante.dart';

class ColorItem extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  const ColorItem({
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: kDefaultAnimationDuration,
        margin: const EdgeInsets.only(right: kDefaultPadding / 2),
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? kDarkPrimaryColor : Theme.of(context).cardColor,
            width: 2,
          ),
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
