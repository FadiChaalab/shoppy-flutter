import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgButton extends StatelessWidget {
  final String svg;
  final VoidCallback press;
  final Color color;
  const SvgButton(
      {Key? key, required this.svg, required this.press, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SvgPicture.asset(
        svg,
        height: 24,
        width: 24,
        color: color,
      ),
    );
  }
}
