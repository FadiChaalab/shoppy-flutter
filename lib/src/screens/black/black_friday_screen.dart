import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop/src/components/loading_widget.dart';
import 'package:shop/src/components/no_data.dart';
import 'package:shop/src/components/product_item.dart';
import 'package:shop/src/models/product.dart';
import 'package:shop/src/screens/product/product_details.dart';
import 'package:shop/src/utils/constante.dart';

class BlackFridayScreen extends StatelessWidget {
  const BlackFridayScreen({Key? key}) : super(key: key);

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
          'Black Friday',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding)
            .copyWith(top: kDefaultPadding),
        child: Consumer<List<Product>?>(builder: (context, products, _) {
          if (products != null) {
            if (products.isNotEmpty) {
              List<Product> blackFriday = products.where((product) {
                return product.blackMarket;
              }).toList();
              if (blackFriday.isEmpty) return const NoDataWidget();
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: kDefaultPadding / 2,
                  mainAxisSpacing: kDefaultPadding / 2,
                  childAspectRatio: 0.66,
                ),
                itemCount: blackFriday.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  Product product = blackFriday[index];
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
          } else if (products == null) {
            return const NoDataWidget();
          } else {
            return const LoadingWidget();
          }
        }),
      ),
    );
  }
}
