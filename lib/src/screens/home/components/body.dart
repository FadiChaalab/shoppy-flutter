import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/src/components/headline_title.dart';
import 'package:shop/src/screens/arrival/new_arrival_screen.dart';
import 'package:shop/src/screens/black/black_friday_screen.dart';
import 'package:shop/src/screens/home/components/banner_slider.dart';
import 'package:shop/src/screens/home/components/best_sellers.dart';
import 'package:shop/src/screens/home/components/brands_logos.dart';
import 'package:shop/src/screens/home/components/category_list_items.dart';
import 'package:shop/src/screens/home/components/flash_sales.dart';
import 'package:shop/src/screens/home/components/popular_products.dart';
import 'package:shop/src/screens/home/components/special_offer.dart';
import 'package:shop/src/screens/home/components/super_sales.dart';
import 'package:shop/src/screens/summer/summer_sales_screen.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(height: 20.h),
        const BannerSlider(),
        SizedBox(height: 20.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: HeadlineTitle(
            title: AppLocalizations.of(context)!.category,
          ),
        ),
        const SizedBox(height: kDefaultPadding),
        const CategoryListItems(),
        SizedBox(height: 20.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: HeadlineTitle(
            title: AppLocalizations.of(context)!.popular,
          ),
        ),
        const SizedBox(height: kDefaultPadding),
        const PopularProducts(),
        SizedBox(height: 20.h),
        const BrandsLogos(),
        SizedBox(height: 20.h),
        const SuperSales(),
        SizedBox(height: 20.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: HeadlineTitle(
            title: AppLocalizations.of(context)!.flash,
          ),
        ),
        const SizedBox(height: kDefaultPadding),
        const FlashSales(),
        SizedBox(height: 20.h),
        SpecialOffer(
          image: 'assets/images/2.jpg',
          title: 'New\nArrival',
          subtitle: 'Special offer',
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NewArrivalScreen(),
              ),
            );
          },
        ),
        const SizedBox(height: kDefaultPadding / 4),
        SpecialOffer(
          chip: true,
          chipText: 'special offer',
          image: 'assets/images/1.jpg',
          title: 'Summer\nsale',
          subtitle: 'up to 30% off',
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SummerSalesScreen(),
              ),
            );
          },
        ),
        const SizedBox(height: kDefaultPadding / 4),
        SpecialOffer(
          chip: true,
          chipText: '50% off',
          image: 'assets/images/3.jpg',
          title: 'black\nFriday',
          subtitle: 'collection',
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const BlackFridayScreen(),
              ),
            );
          },
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: HeadlineTitle(
            title: AppLocalizations.of(context)!.sellers,
          ),
        ),
        const SizedBox(height: kDefaultPadding),
        const BestSellers(),
        SizedBox(height: 20.h),
      ],
    );
  }
}
