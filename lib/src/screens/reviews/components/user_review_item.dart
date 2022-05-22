import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/src/models/review.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserReviewItem extends StatelessWidget {
  final Review review;
  const UserReviewItem({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(review.date);
    final timeAgo = timeago.format(dateTime, locale: 'en_short');
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 28,
                    width: 28,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundImage:
                          CachedNetworkImageProvider(review.userAvatar),
                    ),
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  Text(
                    review.userName,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 14.sp),
                  ),
                  const SizedBox(width: kDefaultPadding / 2),
                  Text(
                    timeAgo,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: kTextColor.withOpacity(0.5), fontSize: 12.sp),
                  ),
                ],
              ),
              RatingBar(
                itemSize: 18.0,
                initialRating: review.rating.rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                ignoreGestures: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                ratingWidget: RatingWidget(
                  full: SvgPicture.asset(
                    'assets/icons/Star-bold.svg',
                    color: kStarIconColor,
                  ),
                  half: SvgPicture.asset('assets/icons/Star-bold.svg'),
                  empty: SvgPicture.asset(
                    'assets/icons/Star-bold.svg',
                    color: kStarInactiveIconColor,
                  ),
                ),
                onRatingUpdate: (rating) {
                  debugPrint(rating.toString());
                },
              )
            ],
          ),
          const SizedBox(height: kDefaultPadding),
          Text(
            review.comment,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 14.sp,
                  color: kTextReviewColor,
                ),
          ),
        ],
      ),
    );
  }
}
