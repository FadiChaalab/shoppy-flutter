import 'package:flutter/material.dart';
import 'package:shop/src/utils/constante.dart';

class LanguageItem extends StatelessWidget {
  final String language;
  final String flag;
  final bool isSelected;
  final VoidCallback onTap;
  const LanguageItem(
      {Key? key,
      required this.language,
      required this.flag,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: kDefaultAnimationDuration,
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
          border: Border.all(
            color: isSelected ? kPrimaryColor : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              flag,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: kDefaultPadding / 2),
            Text(
              language,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: isSelected
                        ? kPrimaryColor
                        : Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
