import 'package:shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 56,
    this.radius = 15,
    this.isUpper = true,
  }) : super(key: key);
  final String text;
  final Function press;
  final Color color;
  final Color? textColor;
  final double? width;
  final double height;
  final double? radius;
  final bool? isUpper;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius!.r),
            ),
          ),
        ),
        onPressed: press as void Function(),
        child: Text(
          isUpper! ? text.toUpperCase() : text,
          style: Theme.of(context).textTheme.button!.copyWith(
                color: textColor,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
