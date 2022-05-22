import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/src/models/review.dart';
import 'package:shop/src/screens/product/components/star_item.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewsWidget extends StatelessWidget {
  final List<Review> reviews;
  const ReviewsWidget({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double getRating() {
      double rating = 0;
      if (reviews.isNotEmpty) {
        rating = reviews
                .map((review) => review.rating.rating)
                .reduce((a, b) => a + b) /
            reviews.length;
      }
      return rating;
    }

    int getNumberOfReviews() {
      int numberOfReviews = 0;
      if (reviews.isNotEmpty) {
        numberOfReviews = reviews.length;
      }
      return numberOfReviews;
    }

    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    getRating().toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 36.sp),
                  ),
                  Text(
                    '/5',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 18.sp),
                  ),
                ],
              ),
              const SizedBox(height: kDefaultPadding / 2),
              Text(
                AppLocalizations.of(context)!.basedOnTitle +
                    ' ' +
                    getNumberOfReviews().toString() +
                    ' ' +
                    AppLocalizations.of(context)!.reviewsTitle.toLowerCase(),
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: kTextReviewColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 14.sp,
                    ),
              ),
              const SizedBox(height: kDefaultPadding),
              RatingBar(
                itemSize: 24.0,
                initialRating: getRating(),
                minRating: 0,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              StarItem(title: '5', width: 50),
              SizedBox(height: kDefaultPadding / 2),
              StarItem(title: '4', width: 40),
              SizedBox(height: kDefaultPadding / 2),
              StarItem(title: '3', width: 30),
              SizedBox(height: kDefaultPadding / 2),
              StarItem(title: '2', width: 20),
              SizedBox(height: kDefaultPadding / 2),
              StarItem(title: '1', width: 10),
            ],
          )
        ],
      ),
    );
  }
}
