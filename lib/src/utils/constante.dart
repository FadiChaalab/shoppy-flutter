import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF7B62FF);
const kSecondaryColor = Color(0xFF00e0c1);
const kDarkPrimaryColor = Color(0xFF6C56DD);
const kLightPrimaryColor = Color(0xFF6A51FF);
const kContrastColor = Color(0xFFE6FF62);
const kMonoColor = Color(0xFF502FFF);
const kInfoColor = Color(0xFF246e8a);
const kSuccessColor = Color(0xFF2DC972);
const kDarkSuccessColor = Color(0xFF248a45);
const kDangerColor = Color(0xFFE85B5D);
const kStarIconColor = Color(0xFFFDBE26);
const kStarInactiveIconColor = Color(0xFFE2E0E5);
const kTextColor = Color(0xFFC3C3C3);
const kTextDarkColor = Color(0xFF181627);
const kBorderColor = Color(0xFFE5E5E5);
const kTextReviewColor = Color(0xFFB4B4B4);
const kBackgroundColor = Color(0xFFF8F8F8);
const kDarkBackgroundColor = Color(0xFF1B182A);
const kPrimaryShadeColor = Color(0xFFf5f5ff);
const kSkipShadeGradientColor = Color(0xFF52FBDD);
const kSkipShadeTGradientColor = Color(0xFF00AED8);
const kSkipShadeThGradientColor = Color(0xFF005EB8);

const kDefaultPadding = 16.0;

const kDefaultAnimationDuration = Duration(milliseconds: 300);

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp phoneValidatorRegExp = RegExp(r"^[0-9]");

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(
      color: Color(0xFFE5E5E5),
    ),
  );
}
