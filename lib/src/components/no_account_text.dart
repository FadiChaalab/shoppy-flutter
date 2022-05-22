import 'package:shop/src/screens/sign_up/sign_up_screen.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.noAccount,
              style: TextStyle(
                fontSize: 16.sp,
                color: kTextColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const SignUpScreen(),
                  ),
                );
              },
              child: Text(
                AppLocalizations.of(context)!.signup,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
