import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop/src/components/custom_divider.dart';
import 'package:shop/src/components/custom_leading_icon.dart';
import 'package:shop/src/components/custom_list_tile.dart';
import 'package:shop/src/components/custom_surfix_icon.dart';
import 'package:shop/src/components/headline_title.dart';
import 'package:shop/src/components/loading_widget.dart';
import 'package:shop/src/components/no_data.dart';
import 'package:shop/src/components/product_item.dart';
import 'package:shop/src/models/product.dart';
import 'package:shop/src/screens/category/kid_category_screen.dart';
import 'package:shop/src/screens/category/man_category_screen.dart';
import 'package:shop/src/screens/category/woman_category_screen.dart';
import 'package:shop/src/screens/product/product_details.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 20.h),
          TextField(
            controller: _controller,
            style: TextStyle(fontSize: 14.sp),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.search,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                color: kTextColor,
              ),
              hintStyle: TextStyle(
                fontSize: 12.sp,
                color: kTextColor,
              ),
              fillColor: Theme.of(context).cardColor.withOpacity(0.16),
              border: outlineInputBorder().copyWith(
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
              focusedBorder: outlineInputBorder().copyWith(
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
              enabledBorder: outlineInputBorder().copyWith(
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 54,
              ),
              prefixIcon: const CustomLeadingIcon(
                svgIcon: "assets/icons/Search.svg",
                color: kTextColor,
              ),
              suffixIcon: SizedBox(
                width: 42,
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      VerticalDivider(
                        width: 8,
                        thickness: 1,
                        indent: 12,
                        endIndent: 12,
                        color: Theme.of(context).dividerColor,
                      ),
                      const SizedBox(width: 8),
                      const CustomSurffixIcon(
                        svgIcon: "assets/icons/Filter.svg",
                        color: kTextColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _controller.text.isEmpty
              ? const SizedBox()
              : SizedBox(height: (kDefaultPadding * 2).h),
          AnimatedSwitcher(
            duration: kDefaultAnimationDuration,
            child: _controller.text.isEmpty
                ? Container()
                : SizedBox(
                    height: 234.h,
                    child: Padding(
                      padding: const EdgeInsets.only(left: kDefaultPadding),
                      child: Consumer<List<Product>?>(
                          builder: (context, products, _) {
                        if (products != null) {
                          if (products.isNotEmpty) {
                            List<Product> searchedProducts =
                                products.where((product) {
                              return product.title
                                  .toLowerCase()
                                  .contains(_controller.text.toLowerCase());
                            }).toList();
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: searchedProducts.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                Product product = searchedProducts[index];
                                return ProductItem(
                                  title: product.title,
                                  image: product.images.first,
                                  price: product.price.toString(),
                                  remise: product.remise.toString(),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ProductDetails(product: product),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          } else {
                            return const NoDataWidget();
                          }
                        } else if (products == null) {
                          return const NoDataWidget();
                        } else {
                          return const LoadingWidget();
                        }
                      }),
                    ),
                  ),
          ),
          SizedBox(height: (kDefaultPadding * 3).h),
          HeadlineTitle(title: AppLocalizations.of(context)!.category),
          SizedBox(height: (kDefaultPadding * 2).h),
          CustomListTile(
            title: AppLocalizations.of(context)!.man,
            icon: 'assets/icons/man.svg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ManCategoryScreen(),
                ),
              );
            },
          ),
          const CustomDivider(),
          CustomListTile(
            title: AppLocalizations.of(context)!.woman,
            icon: 'assets/icons/woman.svg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const WomanCategoryScreen(),
                ),
              );
            },
          ),
          const CustomDivider(),
          CustomListTile(
            title: AppLocalizations.of(context)!.kid,
            icon: 'assets/icons/Buy.svg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const KidCategoryScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
