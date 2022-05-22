import 'package:shop/src/components/custom_leading_icon.dart';
import 'package:shop/src/components/custom_surfix_icon.dart';
import 'package:shop/src/components/default_button.dart';
import 'package:shop/src/db/auth.dart';
import 'package:shop/src/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop/src/screens/success/success_screen.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSecure = true;
  final _authService = AuthService();

  String? email;
  String? password;
  bool remember = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  signIn() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await _authService.signInEmailAndPass(email!, password!).then(
        (value) {
          if (value != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const SuccessScreen(),
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
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 400),
            ),
            child: buildEmailFormField(),
          ),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 600),
            ),
            child: buildPasswordFormField(),
          ),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 800),
            ),
            child: DefaultButton(
              text: AppLocalizations.of(context)!.signin,
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  signIn();
                }
              },
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 1000),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.forget,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: kTextColor,
                    ),
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPasswordFormField() {
    String? error;
    return TextFormField(
      style: TextStyle(fontSize: 14.sp),
      controller: passwordController,
      obscureText: isSecure,
      onSaved: (newValue) => password = newValue,
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
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isSecure = !isSecure;
            });
          },
          child: AnimatedSwitcher(
            duration: kDefaultAnimationDuration,
            child: isSecure
                ? const CustomSurffixIcon(
                    svgIcon: "assets/icons/Show.svg",
                    color: kTextColor,
                  )
                : const CustomSurffixIcon(
                    svgIcon: "assets/icons/Hide.svg",
                    color: kTextColor,
                  ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailFormField() {
    String? error;
    return TextFormField(
      style: TextStyle(fontSize: 14.sp),
      controller: emailController,
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
          fontSize: 14.sp,
          color: kTextColor,
        ),
        hintStyle: TextStyle(
          fontSize: 12.sp,
          color: kTextColor,
        ),
        hintText: AppLocalizations.of(context)!.enteremail,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const CustomLeadingIcon(
          svgIcon: "assets/icons/Message.svg",
          color: kTextColor,
        ),
      ),
    );
  }
}
