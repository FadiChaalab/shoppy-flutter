import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.signin,
          style: TextStyle(fontSize: 14.sp),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: const Body(),
    );
  }
}
