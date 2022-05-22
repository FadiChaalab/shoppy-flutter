import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/src/components/custom_divider.dart';
import 'package:shop/src/components/custom_list_tile.dart';
import 'package:shop/src/components/headline_title.dart';
import 'package:shop/src/components/no_data.dart';
import 'package:shop/src/models/product.dart';
import 'package:shop/src/models/review.dart';
import 'package:shop/src/screens/product/components/reviews_widget.dart';
import 'package:shop/src/screens/reviews/add_review_screen.dart';
import 'package:shop/src/screens/reviews/components/user_review_item.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewsScreen extends StatelessWidget {
  final List<Review> reviews;
  final Product product;
  const ReviewsScreen({Key? key, required this.reviews, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            child: SvgPicture.asset(
              "assets/icons/Arrow-Left-3.svg",
              color: Theme.of(context).colorScheme.secondary,
              height: 18,
              width: 18,
            ),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.reviewsTitle,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        children: [
          SizedBox(height: 20.h),
          ReviewsWidget(
            reviews: reviews,
          ),
          const SizedBox(height: kDefaultPadding),
          const CustomDivider(),
          CustomListTile(
            title: AppLocalizations.of(context)!.addReviewTitle,
            icon: 'assets/icons/message-add.svg',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddReviewsScreen(product: product),
                ),
              );
            },
          ),
          const CustomDivider(),
          const SizedBox(height: kDefaultPadding),
          HeadlineTitle(title: AppLocalizations.of(context)!.usersReviewsTitle),
          const SizedBox(height: kDefaultPadding),
          ...reviews.map((review) {
            return UserReviewItem(review: review);
          }),
          reviews.isEmpty ? const NoDataWidget() : const SizedBox(),
        ],
      ),
    );
  }
}
