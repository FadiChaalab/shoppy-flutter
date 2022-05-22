import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shop/src/controllers/theme_controller.dart';

class BrandsLogos extends StatelessWidget {
  const BrandsLogos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> brands = [
      'assets/images/lipsy.png',
      'assets/images/river.png',
      'assets/images/gucci.png',
      'assets/images/cartier.png',
    ];
    final List<String> brandsLight = [
      'assets/images/lipsy-light.png',
      'assets/images/river-light.png',
      'assets/images/gucci-light.png',
      'assets/images/cartier-light.png',
    ];
    return SizedBox(
      height: 64.h,
      child: CarouselSlider.builder(
        itemCount: brands.length,
        itemBuilder: (context, index, id) {
          return Consumer<ThemeController>(builder: (context, theme, _) {
            return Image.asset(
              theme.darkMode ? brandsLight[index] : brands[index],
              fit: BoxFit.cover,
              height: 64.h,
            );
          });
        },
        options: CarouselOptions(
          viewportFraction: 0.5,
          autoPlay: true,
        ),
      ),
    );
  }
}
