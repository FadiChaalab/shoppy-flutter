import 'package:shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'sign_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  FadeInDown(
                    child: Text(
                      AppLocalizations.of(context)!.completeprf,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 26,
                        letterSpacing: -0.3857143249511719,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  FadeInDown(
                    preferences: const AnimationPreferences(
                      offset: Duration(milliseconds: 200),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.details,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xff707070),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  const SignForm(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
