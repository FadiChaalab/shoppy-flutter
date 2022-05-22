import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/src/utils/constante.dart';

class ProductItem extends StatelessWidget {
  final String title;
  final String image;
  final String price;
  final String remise;
  final bool? isGrid;
  final VoidCallback onTap;
  const ProductItem({
    Key? key,
    required this.title,
    required this.image,
    required this.price,
    required this.remise,
    this.isGrid = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remisePrice = double.parse(price) -
        (double.parse(price) * double.parse(remise)) / 100;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: isGrid! ? 0 : kDefaultPadding),
        width: 172.w,
        height: 204.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Theme.of(context).cardColor,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      cacheKey: image,
                      imageUrl: image,
                      fit: BoxFit.cover,
                      height: isGrid! ? 104.h : 132.h,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kDangerColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 4,
                          horizontal: kDefaultPadding / 2,
                        ),
                        child: Text(
                          '${remise.split('.')[0]}% Off',
                          style: Theme.of(context)
                              .textTheme
                              .overline!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kDefaultPadding),
              Text(
                title,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              const SizedBox(height: kDefaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${remisePrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                  ),
                  Text(
                    '\$$price',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: kTextColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
