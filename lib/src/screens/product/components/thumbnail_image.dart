import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/src/utils/constante.dart';

class ThumbnailImage extends StatelessWidget {
  final String image;
  final bool isSelected;
  final VoidCallback onTap;
  const ThumbnailImage({
    Key? key,
    required this.image,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: kDefaultAnimationDuration,
        width: 64.h,
        margin: const EdgeInsets.only(
          right: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding),
          border: isSelected
              ? Border.all(
                  color: kPrimaryColor,
                  width: 2,
                )
              : null,
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              image,
              cacheKey: image,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
