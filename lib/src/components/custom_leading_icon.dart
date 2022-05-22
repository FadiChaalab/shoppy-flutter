import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLeadingIcon extends StatelessWidget {
  const CustomLeadingIcon({
    Key? key,
    required this.svgIcon,
    this.color,
  }) : super(key: key);

  final String? svgIcon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        0,
        20,
      ),
      child: SvgPicture.asset(
        svgIcon!,
        height: 18,
        color: color,
      ),
    );
  }
}
