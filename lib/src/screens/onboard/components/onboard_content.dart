import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
    required this.title,
  }) : super(key: key);
  final String title, text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(flex: 2),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            image,
            height: 300.h,
            width: double.infinity,
          ),
        ),
        const Spacer(
          flex: 3,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontSize: 24.sp, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ],
    );
  }
}
