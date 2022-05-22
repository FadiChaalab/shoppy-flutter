import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/src/utils/constante.dart';

class SizeItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  const SizeItem({
    Key? key,
    required this.text,
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
            color: isSelected ? kPrimaryColor : Theme.of(context).cardColor,
            width: 2,
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}
