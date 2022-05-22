import 'package:flutter/material.dart';
import 'package:shop/src/utils/constante.dart';

class CategoryItem extends StatelessWidget {
  final bool isActive;
  final String title;
  final VoidCallback press;
  const CategoryItem({
    Key? key,
    required this.isActive,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: kDefaultPadding / 2),
      child: GestureDetector(
        onTap: press,
        child: Chip(
          label: Text(title),
          backgroundColor: isActive
              ? kPrimaryColor
              : Theme.of(context).scaffoldBackgroundColor,
          labelStyle: TextStyle(
            color: isActive
                ? Colors.white
                : Theme.of(context).colorScheme.secondary,
          ),
          side: isActive
              ? BorderSide.none
              : BorderSide(color: Theme.of(context).cardColor),
        ),
      ),
    );
  }
}
