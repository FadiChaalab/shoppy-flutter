import 'package:shop/src/components/custom_leading_icon.dart';
import 'package:shop/src/components/default_button.dart';
import 'package:shop/src/db/auth.dart';
import 'package:shop/src/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  String? email;
  String? password;
  String? repassword;
  String? match;

  signUp() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await _authService.signUpWithEmailAndPassword(email!, password!).then(
        (value) {
          if (value != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const CompleteProfileScreen(),
              ),
            );
          }
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            AppLocalizations.of(context)!.offline,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: 20.h),
          buildPasswordFormField(),
          SizedBox(height: 20.h),
          buildRePasswordFormField(),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 1000),
            ),
            child: DefaultButton(
              text: AppLocalizations.of(context)!.signup,
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  signUp();
                  if (_authService.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          _authService.errorMessage!,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ),
          SizedBox(height: 40.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 1200),
            ),
            child: Text(
              AppLocalizations.of(context)!.terms,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: kTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPasswordFormField() {
    String? error;
    return FadeInDown(
      preferences: const AnimationPreferences(
        offset: Duration(milliseconds: 600),
      ),
      child: TextFormField(
        style: TextStyle(fontSize: 14.sp),
        obscureText: true,
        onSaved: (newValue) => password = newValue,
        onChanged: (value) {
          match = value;
          if (value.isNotEmpty) {
            setState(() {
              error = null;
            });
          }
          if (value.length >= 8) {
            setState(() {
              error = null;
            });
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              error = AppLocalizations.of(context)!.pwdnull;
            });
          } else if (value.length < 8) {
            setState(() {
              error = AppLocalizations.of(context)!.pwdshort;
            });
          }
          return error;
        },
        decoration: InputDecoration(
          fillColor: Theme.of(context).cardColor,
          labelStyle: TextStyle(
            color: kTextColor,
            fontSize: 14.sp,
          ),
          hintStyle: TextStyle(
            fontSize: 12.sp,
            color: kTextColor,
          ),
          hintText: AppLocalizations.of(context)!.enterpassword,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: const CustomLeadingIcon(
            svgIcon: "assets/icons/Lock.svg",
            color: kTextColor,
          ),
        ),
      ),
    );
  }

  Widget buildRePasswordFormField() {
    String? error;
    return FadeInDown(
      preferences: const AnimationPreferences(
        offset: Duration(milliseconds: 800),
      ),
      child: TextFormField(
        style: const TextStyle(fontSize: 14),
        obscureText: true,
        onSaved: (newValue) => repassword = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              error = null;
            });
          }
          if (value.length >= 8) {
            setState(() {
              error = null;
            });
          }
          if (value == match) {
            setState(() {
              error = null;
            });
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              error = AppLocalizations.of(context)!.pwdnull;
            });
          } else if (value.length < 8) {
            setState(() {
              error = AppLocalizations.of(context)!.pwdshort;
            });
          } else if (value != match) {
            setState(() {
              error = AppLocalizations.of(context)!.nomatch;
            });
          }
          return error;
        },
        decoration: InputDecoration(
          fillColor: Theme.of(context).cardColor,
          labelStyle: TextStyle(
            color: kTextColor,
            fontSize: 14.sp,
          ),
          hintStyle: TextStyle(
            fontSize: 12.sp,
            color: kTextColor,
          ),
          hintText: AppLocalizations.of(context)!.renterpwd,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: const CustomLeadingIcon(
            svgIcon: "assets/icons/Lock.svg",
            color: kTextColor,
          ),
        ),
      ),
    );
  }

  Widget buildEmailFormField() {
    String? error;
    return FadeInDown(
      preferences: const AnimationPreferences(
        offset: Duration(milliseconds: 400),
      ),
      child: TextFormField(
        style: TextStyle(fontSize: 14.sp),
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              error = null;
            });
          }
          if (emailValidatorRegExp.hasMatch(value)) {
            setState(() {
              error = null;
            });
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              error = AppLocalizations.of(context)!.emailnull;
            });
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            setState(() {
              error = AppLocalizations.of(context)!.invalidemail;
            });
          }
          return error;
        },
        decoration: InputDecoration(
          fillColor: Theme.of(context).cardColor,
          labelStyle: TextStyle(
            color: kTextColor,
            fontSize: 14.sp,
          ),
          hintStyle: TextStyle(fontSize: 12.sp, color: kTextColor),
          hintText: AppLocalizations.of(context)!.enteremail,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: const CustomLeadingIcon(
            svgIcon: "assets/icons/Message.svg",
            color: kTextColor,
          ),
        ),
      ),
    );
  }
}
