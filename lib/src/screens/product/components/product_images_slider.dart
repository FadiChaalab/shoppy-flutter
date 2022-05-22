import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/src/components/dot_widget.dart';
import 'package:shop/src/utils/constante.dart';

class ProductImagesSlider extends StatefulWidget {
  final List<String> images;
  const ProductImagesSlider({Key? key, required this.images}) : super(key: key);

  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 224.h,
          child: CarouselSlider.builder(
            itemCount: widget.images.length,
            itemBuilder: (context, index, id) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: CachedNetworkImage(
                  imageUrl: widget.images[index],
                  cacheKey: widget.images[index],
                  fit: BoxFit.cover,
                  height: 224.h,
                  width: double.infinity,
                ),
              );
            },
            options: CarouselOptions(
              height: 224.h,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        ),
        Positioned(
          right: kDefaultPadding,
          bottom: kDefaultPadding,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFEFEFE),
              borderRadius: BorderRadius.circular(kDefaultPadding / 2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.images.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Dot(
                    isActive: _current == entry.key,
                    isRow: true,
                    color: kTextColor,
                    isLast: entry.key == widget.images.length - 1,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
