import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop/src/components/custom_divider.dart';
import 'package:shop/src/components/custom_list_tile.dart';
import 'package:shop/src/components/headline_title.dart';
import 'package:shop/src/controllers/bookmarks_controller.dart';
import 'package:shop/src/models/product.dart';
import 'package:shop/src/models/user.dart';
import 'package:shop/src/screens/product/components/product_images_slider.dart';
import 'package:shop/src/screens/product/components/reviews_widget.dart';
import 'package:shop/src/screens/product/details.dart';
import 'package:shop/src/screens/reviews/reviews_screen.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _isBookmarked = false;
  final _controller = BookmarksController();

  void toggle() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  double getRating(Product product) {
    double rating = 0;
    if (product.reviews.isNotEmpty) {
      rating = product.reviews
              .map((review) => review.rating.rating)
              .reduce((a, b) => a + b) /
          product.reviews.length;
    }
    return rating;
  }

  int getNumberOfReviews(Product product) {
    int numberOfReviews = 0;
    if (product.reviews.isNotEmpty) {
      numberOfReviews = product.reviews.length;
    }
    return numberOfReviews;
  }

  Future<void> handleFavorite(List<Product> bookmarks) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      if (_isBookmarked == true) {
        _controller.removeBookmark(bookmarks, widget.product);
      } else {
        _controller.addBookmark(bookmarks, widget.product);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Oops you are offline",
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          children: [
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    "assets/icons/Arrow-Left-3.svg",
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Consumer<UserModel?>(builder: (context, user, _) {
                  return GestureDetector(
                    onTap: () {
                      toggle();
                      handleFavorite(user?.bookmarks ?? []);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/Bookmark.svg",
                      color: _controller.isBookmarked(
                              user?.bookmarks ?? [], widget.product)
                          ? kPrimaryColor
                          : Theme.of(context).colorScheme.secondary,
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: kDefaultPadding * 2),
            ProductImagesSlider(
              images: widget.product.images,
            ),
            const SizedBox(height: kDefaultPadding * 2),
            Text(
              widget.product.brand.toUpperCase(),
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 14.sp,
                    color: kTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: kDefaultPadding),
            Text(
              widget.product.title,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: kDefaultPadding / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                  ),
                  label: Text(
                    widget.product.quantity > 0
                        ? "Available In Stock"
                        : "Out Of Stock",
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  backgroundColor: kSuccessColor,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/Star.svg",
                      color: kStarIconColor,
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                    Text(
                      getRating(widget.product).toString(),
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      "(" +
                          getNumberOfReviews(widget.product).toString() +
                          " " +
                          AppLocalizations.of(context)!.reviewsTitle +
                          ")",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: kTextColor,
                            fontSize: 12.sp,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            HeadlineTitle(title: AppLocalizations.of(context)!.overview),
            const SizedBox(height: kDefaultPadding / 2),
            Text(
              widget.product.description,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 14.sp,
                    color: kTextColor,
                  ),
            ),
            const SizedBox(height: kDefaultPadding),
            const CustomDivider(),
            CustomListTile(
              title: AppLocalizations.of(context)!.productDetailsTitle,
              icon: 'assets/icons/barcode.svg',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DetailsScreen(
                      product: widget.product,
                    ),
                  ),
                );
              },
            ),
            const CustomDivider(),
            CustomListTile(
              title: AppLocalizations.of(context)!.productShippingTitle,
              icon: 'assets/icons/truck.svg',
              onTap: () {},
            ),
            const CustomDivider(),
            CustomListTile(
              title: AppLocalizations.of(context)!.returnsTitle,
              icon: 'assets/icons/tag-right.svg',
              onTap: () {},
            ),
            const SizedBox(height: kDefaultPadding),
            ReviewsWidget(
              reviews: widget.product.reviews,
            ),
            const SizedBox(height: kDefaultPadding),
            const CustomDivider(),
            CustomListTile(
              title: AppLocalizations.of(context)!.reviewsTitle,
              icon: 'assets/icons/Chat.svg',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ReviewsScreen(
                      reviews: widget.product.reviews,
                      product: widget.product,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}
