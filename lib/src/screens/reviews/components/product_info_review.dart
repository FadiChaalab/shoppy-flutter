import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/src/models/product.dart';
import 'package:shop/src/utils/constante.dart';

class ProductInfoReview extends StatelessWidget {
  final Product product;
  const ProductInfoReview({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(kDefaultPadding),
          child: CachedNetworkImage(
            imageUrl: product.images.first,
            fit: BoxFit.cover,
            height: 84,
            width: 84,
          ),
        ),
        const SizedBox(width: kDefaultPadding),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.brand.toUpperCase(),
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 12.sp,
                    color: kTextColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: kDefaultPadding / 2),
            Text(
              product.title,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
