import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/src/components/custom_divider.dart';
import 'package:shop/src/models/product.dart';
import 'package:shop/src/screens/reviews/components/form_review.dart';
import 'package:shop/src/screens/reviews/components/product_info_review.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddReviewsScreen extends StatelessWidget {
  final Product product;
  const AddReviewsScreen({Key? key, required this.product}) : super(key: key);

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
          AppLocalizations.of(context)!.addReviewTitle,
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
          ProductInfoReview(product: product),
          const SizedBox(height: kDefaultPadding),
          const CustomDivider(),
          FormReview(
            product: product,
          ),
        ],
      ),
    );
  }
}
