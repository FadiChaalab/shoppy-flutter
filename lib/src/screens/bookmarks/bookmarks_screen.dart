import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop/src/components/headline_title.dart';
import 'package:shop/src/components/loading_widget.dart';
import 'package:shop/src/components/no_data.dart';
import 'package:shop/src/components/product_item.dart';
import 'package:shop/src/models/product.dart';
import 'package:shop/src/models/user.dart';
import 'package:shop/src/screens/product/product_details.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 20.h),
          HeadlineTitle(
            title: AppLocalizations.of(context)!.favorites,
          ),
          SizedBox(height: 20.h),
          Consumer<UserModel?>(builder: (context, user, _) {
            if (user?.bookmarks != null) {
              if (user!.bookmarks!.isNotEmpty) {
                List<Product> bookmarks = user.bookmarks!;
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: kDefaultPadding / 2,
                    mainAxisSpacing: kDefaultPadding / 2,
                    childAspectRatio: 0.66,
                  ),
                  itemCount: bookmarks.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Product product = bookmarks[index];
                    return ProductItem(
                      title: product.title,
                      isGrid: true,
                      image: product.images.first,
                      price: product.price.toString(),
                      remise: product.remise.toString(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetails(product: product),
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                return const NoDataWidget();
              }
            } else if (user?.bookmarks == null) {
              return const NoDataWidget();
            } else {
              return const LoadingWidget();
            }
          }),
        ],
      ),
    );
  }
}
