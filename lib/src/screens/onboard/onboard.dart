import 'dart:math';

import 'package:shop/src/components/next_button.dart';
import 'package:shop/src/screens/onboard/components/onboard_indicator.dart';
import 'package:shop/src/screens/sign_in/sign_in_screen.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'components/onboard_content.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen>
    with SingleTickerProviderStateMixin {
  int _currentPage = 0;
  late AnimationController _pageIndicatorAnimationController;
  late PageController _pageController;
  late Animation<double> _pageIndicatorAnimation;

  List<Map<String, String>> onboardData = [
    {
      "text":
          "Here you will see rich variety of products from different categories",
      "image": "assets/images/searching.svg",
      "title": "Find the item you've been looking for"
    },
    {
      "text": "Add any item to your cart and checkout with one tap",
      "image": "assets/images/add_to_cart.svg",
      "title": "Add to cart and exchange"
    },
    {
      "text":
          "There are many ways to pay for your order, choose the one that suits you best",
      "image": "assets/images/online_payments.svg",
      "title": "Fast and easy online payment"
    },
  ];

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    _pageIndicatorAnimationController = AnimationController(
      vsync: this,
      duration: kDefaultAnimationDuration,
    );
    _setPageIndicatorAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pageIndicatorAnimationController.dispose();
    super.dispose();
  }

  void _setPageIndicatorAnimation({bool isClockwiseAnimation = true}) {
    final multiplicator = isClockwiseAnimation ? 2.0 : -2.0;

    setState(() {
      _pageIndicatorAnimation = Tween<double>(
        begin: 0.0,
        end: multiplicator * pi,
      ).animate(
        CurvedAnimation(
          parent: _pageIndicatorAnimationController,
          curve: Curves.easeIn,
        ),
      );
      _pageIndicatorAnimationController.reset();
    });
  }

  void _setNextPage(int nextPageNumber) {
    setState(() {
      _currentPage = nextPageNumber;
    });
    _pageController.animateToPage(
      _currentPage,
      duration: kDefaultAnimationDuration,
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> _nextPage() async {
    switch (_currentPage) {
      case 0:
        if (_pageIndicatorAnimation.status == AnimationStatus.dismissed) {
          _pageIndicatorAnimationController.forward();
          _setNextPage(1);
          _setPageIndicatorAnimation(isClockwiseAnimation: false);
        }
        break;
      case 1:
        if (_pageIndicatorAnimation.status == AnimationStatus.dismissed) {
          _pageIndicatorAnimationController.forward();
          _setNextPage(2);
        }
        break;
      case 2:
        if (_pageIndicatorAnimation.status == AnimationStatus.completed) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const SignInScreen(),
            ),
          );
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: PageView.builder(
                  itemCount: onboardData.length,
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    _setNextPage(value);
                  },
                  itemBuilder: (context, index) => SplashContent(
                    image: onboardData[index]['image']!,
                    text: onboardData[index]['text']!,
                    title: onboardData[index]['title']!,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      const Spacer(
                        flex: 3,
                      ),
                      AnimatedBuilder(
                        animation: _pageIndicatorAnimation,
                        builder: (_, Widget? child) {
                          return OnboardingPageIndicator(
                            angle: _pageIndicatorAnimation.value,
                            currentPage: _currentPage,
                            child: child!,
                          );
                        },
                        child: NextPageButton(onPressed: _nextPage),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
