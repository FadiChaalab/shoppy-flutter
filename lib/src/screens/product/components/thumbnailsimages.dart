import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/src/screens/product/components/thumbnail_image.dart';

class ThumbnailsImages extends StatefulWidget {
  final List<String> images;
  const ThumbnailsImages({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<ThumbnailsImages> createState() => _ThumbnailsImagesState();
}

class _ThumbnailsImagesState extends State<ThumbnailsImages> {
  int _isSelected = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          String image = widget.images[index];
          return ThumbnailImage(
            image: image,
            isSelected: _isSelected == index,
            onTap: () {
              setState(() {
                _isSelected = index;
              });
            },
          );
        },
      ),
    );
  }
}
