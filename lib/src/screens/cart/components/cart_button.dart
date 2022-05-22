import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;
  const CartButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: Theme.of(context).cardColor,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(
            icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
