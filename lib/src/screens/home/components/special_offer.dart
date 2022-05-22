import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/src/utils/constante.dart';

class SpecialOffer extends StatelessWidget {
  final String title;
  final String image;
  final String subtitle;
  final bool? chip;
  final String? chipText;
  final VoidCallback press;
  const SpecialOffer({
    Key? key,
    required this.title,
    required this.image,
    required this.subtitle,
    required this.press,
    this.chip = false,
    this.chipText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        height: 164.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(image, fit: BoxFit.cover),
            Container(
              height: 164.h,
              decoration: BoxDecoration(
                color: const Color(0xFF25213A).withOpacity(0.7),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kDefaultPadding),
                  chip!
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 2,
                            vertical: kDefaultPadding / 4,
                          ),
                          child: Text(
                            chipText!.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      color: kTextDarkColor,
                                    ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: kDefaultPadding / 4),
                  Text(
                    title.toUpperCase(),
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 34.sp,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: kDefaultPadding / 4),
                  Text(
                    subtitle.toUpperCase(),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: kDefaultPadding,
              top: 65.h,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('assets/icons/arrow-right.svg'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
