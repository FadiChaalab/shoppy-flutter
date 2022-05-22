import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/src/components/default_button.dart';
import 'package:shop/src/components/dot_widget.dart';
import 'package:shop/src/screens/arrival/new_arrival_screen.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({Key? key}) : super(key: key);

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _current = 0;
  final List<String> imgList = [
    'assets/images/banner.png',
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
  ];

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 154.h,
          width: double.infinity,
          child: CarouselSlider.builder(
            itemCount: 4,
            itemBuilder: (context, index, id) {
              return SizedBox(
                width: double.infinity,
                height: 154.h,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      imgList[index],
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 164.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF25213A).withOpacity(0.16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: kDefaultPadding),
                          Text(
                            'New items with free \nshipping'.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                          ),
                          const SizedBox(height: kDefaultPadding),
                          DefaultButton(
                            text: AppLocalizations.of(context)!.seeOurProducts,
                            color: Colors.white,
                            textColor: Colors.black,
                            width: 174.w,
                            height: 42,
                            radius: 8,
                            isUpper: false,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const NewArrivalScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            options: CarouselOptions(
              viewportFraction: 1.0,
              autoPlay: true,
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
          top: 154.h / 2 - 22,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Dot(
                  isActive: _current == entry.key,
                  isLast: entry.key == imgList.length - 1,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
