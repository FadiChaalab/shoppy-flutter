import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/src/utils/constante.dart';

class SuperSales extends StatefulWidget {
  const SuperSales({
    Key? key,
  }) : super(key: key);

  @override
  State<SuperSales> createState() => _SuperSalesState();
}

class _SuperSalesState extends State<SuperSales> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(days: 1);

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(days: 1));
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    if (mounted) {
      setState(() {
        final seconds = myDuration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          countdownTimer!.cancel();
        } else {
          myDuration = Duration(seconds: seconds);
        }
      });
    }
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    countdownTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return SizedBox(
      height: 164.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/super-sales.jpg', fit: BoxFit.cover),
          Container(
            height: 164.h,
            decoration: BoxDecoration(
              color: const Color(0xFF25213A).withOpacity(0.7),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: kDefaultPadding),
                Text(
                  'Super Flash Sale \n50% Off',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: kDefaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: kDefaultPadding / 4),
                      decoration: BoxDecoration(
                        color: kBackgroundColor.withOpacity(0.16),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Text(hours),
                      ),
                    ),
                    const Text(':'),
                    Container(
                      margin: const EdgeInsets.only(
                          right: kDefaultPadding / 4,
                          left: kDefaultPadding / 4),
                      decoration: BoxDecoration(
                        color: kBackgroundColor.withOpacity(0.16),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Text(minutes),
                      ),
                    ),
                    const Text(':'),
                    Container(
                      margin: const EdgeInsets.only(left: kDefaultPadding / 4),
                      decoration: BoxDecoration(
                        color: kBackgroundColor.withOpacity(0.16),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Text(seconds),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
