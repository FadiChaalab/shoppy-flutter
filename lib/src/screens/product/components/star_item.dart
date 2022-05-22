import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StarItem extends StatelessWidget {
  final String title;
  final double width;
  const StarItem({
    Key? key,
    required this.title,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title + ' ' + AppLocalizations.of(context)!.starsTitle,
          style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.normal,
              color: kTextReviewColor,
              fontSize: 12.sp),
        ),
        const SizedBox(width: kDefaultPadding / 2),
        Stack(
          children: [
            Container(
              width: 50,
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: 4),
              decoration: BoxDecoration(
                color: kStarInactiveIconColor,
                borderRadius: BorderRadius.circular(kDefaultPadding / 4),
              ),
            ),
            AnimatedContainer(
              duration: kDefaultAnimationDuration,
              width: width,
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: 4),
              decoration: BoxDecoration(
                color: kStarIconColor,
                borderRadius: BorderRadius.circular(kDefaultPadding / 4),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
