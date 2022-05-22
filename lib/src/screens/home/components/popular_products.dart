import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop/src/components/loading_widget.dart';
import 'package:shop/src/components/no_data.dart';
import 'package:shop/src/components/product_item.dart';
import 'package:shop/src/controllers/category_controller.dart';
import 'package:shop/src/models/product.dart';
import 'package:shop/src/screens/product/product_details.dart';
import 'package:shop/src/utils/constante.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 234.h,
      child: Padding(
        padding: const EdgeInsets.only(left: kDefaultPadding),
        child: Consumer2<List<Product>?, CategoryController>(
            builder: (context, products, category, _) {
          if (products != null) {
            if (products.isNotEmpty) {
              List<Product> popularProducts = products.where((product) {
                return product.popular;
              }).toList();

              if (category.categoryName.toLowerCase() == 'man') {
                popularProducts = popularProducts
                    .where((product) => product.category.toLowerCase() == 'man')
                    .toList();
                if (popularProducts.isEmpty) return const NoDataWidget();
              } else if (category.categoryName.toLowerCase() == 'woman') {
                popularProducts = popularProducts
                    .where(
                        (product) => product.category.toLowerCase() == 'woman')
                    .toList();
                if (popularProducts.isEmpty) return const NoDataWidget();
              } else if (category.categoryName.toLowerCase() == 'kid') {
                popularProducts = popularProducts
                    .where((product) => product.category.toLowerCase() == 'kid')
                    .toList();
                if (popularProducts.isEmpty) return const NoDataWidget();
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularProducts.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  Product product = popularProducts[index];
                  return ProductItem(
                    title: product.title,
                    image: product.images.first,
                    price: product.price.toString(),
                    remise: product.remise.toString(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetails(
                            product: product,
                          ),
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
