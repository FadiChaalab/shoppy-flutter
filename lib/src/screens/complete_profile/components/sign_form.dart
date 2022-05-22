import 'package:shop/src/components/custom_leading_icon.dart';
import 'package:shop/src/components/default_button.dart';
import 'package:shop/src/db/auth.dart';
import 'package:shop/src/models/user.dart';
import 'package:shop/src/screens/success/success_screen.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  String? first;
  String? last;
  String? phone;
  String? addrese;
  String? age;

  Future createUserModel() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await _authService.getCurrentUser().then(
        (value) async {
          if (value != null) {
            await _authService
                .createUser(
              UserModel(
                uid: value.uid,
                email: value.email!,
                firstName: first,
                lastName: last,
                phone: int.parse(phone!),
                age: int.parse(age!),
                addrese: addrese,
                bookmarks: [],
                carts: [],
              ),
            )
                .then(
              (value) {
                if (value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SuccessScreen(),
                    ),
                  );
                }
              },
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
          buildFirstFormField(),
          SizedBox(height: 20.h),
          buildLastFormField(),
          SizedBox(height: 20.h),
          buildPhoneFormField(),
          SizedBox(height: 20.h),
          buildAgeFormField(),
          SizedBox(height: 20.h),
          buildAddreseFormField(),
          SizedBox(height: 20.h),
          FadeInDown(
            preferences: const AnimationPreferences(
              offset: Duration(milliseconds: 1400),
            ),
            child: DefaultButton(
              text: AppLocalizations.of(context)!.continueButton,
              press: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  createUserModel();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAddreseFormField() {
    String? error;
    return FadeInDown(
      preferences: const AnimationPreferences(
        offset: Duration(milliseconds: 1200),
      ),
      child: TextFormField(
        style: TextStyle(fontSize: 14.sp),
        keyboardType: TextInputType.streetAddress,
        onSaved: (newValue) => addrese = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              error = null;
            });
          }
          if (value.length >= 3) {
            setState(() {
              error = null;
            });
          }
          if (value.length <= 40) {
            setState(() {
              error = null;
            });
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              error = AppLocalizations.of(context)!.addresenull;
            });
          } else if (value.length < 3) {
            setState(() {
              error = AppLocalizations.of(context)!.shorterror;
            });
          } else if (value.length > 40) {
            setState(() {
              error = AppLocalizations.of(context)!.addreselongerror;
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
          hintText: AppLocalizations.of(context)!.hintAddrese,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: const CustomLeadingIcon(
            svgIcon: "assets/icons/Location.svg",
            color: kTextColor,
          ),
        ),
      ),
    );
  }

  Widget buildPhoneFormField() {
    String? error;
    return FadeInDown(
      preferences: const AnimationPreferences(
        offset: Duration(milliseconds: 800),
      ),
      child: TextFormField(
        style: TextStyle(fontSize: 14.sp),
        keyboardType: TextInputType.phone,
        onSaved: (newValue) => phone = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              error = null;
            });
          }
          if (value.length == 8) {
            setState(() {
              error = null;
            });
          }
          if (phoneValidatorRegExp.hasMatch(value)) {
            setState(() {
              error = null;
            });
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              error = AppLocalizations.of(context)!.shorterror;
            });
          } else if (value.length < 8 || value.length > 8) {
            setState(() {
              error = AppLocalizations.of(context)!.phonenull;
            });
          } else if (!phoneValidatorRegExp.hasMatch(value)) {
            setState(() {
              error = AppLocalizations.of(context)!.phoneerror;
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
          hintText: AppLocalizations.of(context)!.hintPhone,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: const CustomLeadingIcon(
            svgIcon: "assets/icons/Call.svg",
            color: kTextColor,
          ),
        ),
      ),
    );
  }

  Widget buildAgeFormField() {
    String? error;
    return FadeInDown(
      preferences: const AnimationPreferences(
        offset: Duration(milliseconds: 1000),
      ),
      child: TextFormField(
        style: TextStyle(fontSize: 14.sp),
        keyboardType: TextInputType.number,
        onSaved: (newValue) => age = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              error = null;
            });
          }
          if (int.parse(value) >= 7 && int.parse(value) <= 80) {
            setState(() {
              error = null;
            });
          }
          if (phoneValidatorRegExp.hasMatch(value)) {
            setState(() {
              error = null;
            });
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              error = AppLocalizations.of(context)!.agenull;
            });
          } else if (int.parse(value) < 7 || int.parse(value) > 80) {
            setState(() {
              error = AppLocalizations.of(context)!.ageerror;
            });
          } else if (!phoneValidatorRegExp.hasMatch(value)) {
            setState(() {
              error = AppLocalizations.of(context)!.invalidAge;
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
          hintText: AppLocalizations.of(context)!.hintAge,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: const CustomLeadingIcon(
            svgIcon: "assets/icons/Calendar.svg",
            color: kTextColor,
          ),
        ),
      ),
    );
  }

  Widget buildLastFormField() {
    String? error;
    return FadeInDown(
      preferences: const AnimationPreferences(
        offset: Duration(milliseconds: 600),
      ),
      child: TextFormField(
        style: TextStyle(fontSize: 14.sp),
        onSaved: (newValue) => last = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              error = null;
            });
          }
          if (value.length >= 3) {
            setState(() {
              error = null;
            });
          }
          if (value.length <= 14) {
            setState(() {
              error = null;
            });
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              error = AppLocalizations.of(context)!.lastnull;
            });
          } else if (value.length < 3) {
            setState(() {
              error = AppLocalizations.of(context)!.shorterror;
            });
          } else if (value.length > 14) {
            setState(() {
              error = AppLocalizations.of(context)!.longerror;
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
          hintText: AppLocalizations.of(context)!.hintLast,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: const CustomLeadingIcon(
            svgIcon: "assets/icons/User.svg",
            color: kTextColor,
          ),
        ),
      ),
    );
  }

  Widget buildFirstFormField() {
    String? error;
    return FadeInDown(
      preferences: const AnimationPreferences(
        offset: Duration(milliseconds: 400),
      ),
      child: TextFormField(
        style: TextStyle(fontSize: 14.sp),
        onSaved: (newValue) => first = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              error = null;
            });
          }
          if (value.length >= 3) {
            setState(() {
              error = null;
            });
          }
          if (value.length <= 14) {
            setState(() {
              error = null;
            });
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            setState(() {
              error = AppLocalizations.of(context)!.firstnull;
            });
          } else if (value.length < 3) {
            setState(() {
              error = AppLocalizations.of(context)!.shorterror;
            });
          } else if (value.length > 14) {
            setState(() {
              error = AppLocalizations.of(context)!.longerror;
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
          hintText: AppLocalizations.of(context)!.hintFirst,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: const CustomLeadingIcon(
            svgIcon: "assets/icons/User.svg",
            color: kTextColor,
          ),
        ),
      ),
    );
  }
}
