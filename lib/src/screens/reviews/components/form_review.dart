import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop/src/components/custom_divider.dart';
import 'package:shop/src/components/default_button.dart';
import 'package:shop/src/components/headline_2_title.dart';
import 'package:shop/src/db/products_repo.dart';
import 'package:shop/src/models/product.dart';
import 'package:shop/src/models/rating.dart';
import 'package:shop/src/models/review.dart';
import 'package:shop/src/models/user.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class FormReview extends StatefulWidget {
  final Product product;
  const FormReview({Key? key, required this.product}) : super(key: key);

  @override
  State<FormReview> createState() => _FormReviewState();
}

class _FormReviewState extends State<FormReview> {
  final _formKey = GlobalKey<FormState>();
  final _productRepository = ProductRepository();

  bool _isRecommend = false;
  String? title;
  String? description;
  double rating = 1;

  //add review to product
  addReview(UserModel user) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      String ratingId = const Uuid().v1();
      String username = user.firstName! + ' ' + user.lastName!;
      Review review = Review(
        user.uid!,
        widget.product.id,
        description!,
        DateTime.now().toString(),
        username,
        user.avatarUrl!,
        Rating(ratingId, rating),
      );
      await _productRepository.addReview(widget.product, review).then(
        (value) {
          Navigator.pop(context);
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: kDefaultPadding / 2),
              Text(
                AppLocalizations.of(context)!.ratingTitle.toUpperCase(),
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: kTextColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: kDefaultPadding),
              Center(
                child: RatingBar(
                  itemSize: 24.0,
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  ratingWidget: RatingWidget(
                    full: SvgPicture.asset(
                      'assets/icons/Star-bold.svg',
                      color: kStarIconColor,
                    ),
                    half: SvgPicture.asset('assets/icons/Star-bold.svg'),
                    empty: SvgPicture.asset(
                      'assets/icons/Star-bold.svg',
                      color: kStarInactiveIconColor,
                    ),
                  ),
                  onRatingUpdate: (value) {
                    setState(() {
                      rating = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: kDefaultPadding / 2),
            ],
          ),
          const CustomDivider(),
          const SizedBox(height: kDefaultPadding),
          Headline2Title(title: AppLocalizations.of(context)!.setreviewTitle),
          const SizedBox(height: kDefaultPadding),
          buildTitleReviewFormField(),
          const SizedBox(height: kDefaultPadding),
          Headline2Title(
              title: AppLocalizations.of(context)!.setDescriptionTitle),
          const SizedBox(height: kDefaultPadding),
          buildDescriptionReviewFormField(),
          const SizedBox(height: kDefaultPadding),
          const CustomDivider(),
          const SizedBox(height: kDefaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Headline2Title(
                  title: AppLocalizations.of(context)!.recommendTitle),
              CupertinoSwitch(
                value: _isRecommend,
                onChanged: (value) {
                  setState(() {
                    _isRecommend = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 2),
          Consumer<UserModel?>(builder: (context, user, _) {
            return DefaultButton(
              text: AppLocalizations.of(context)!.submitReview,
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  addReview(user!);
                }
              },
            );
          }),
          const SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }

  Widget buildTitleReviewFormField() {
    String? error;
    return TextFormField(
      maxLength: 100,
      buildCounter:
          (_, {required currentLength, maxLength, required isFocused}) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          (maxLength! - currentLength).toString() +
              ' ' +
              AppLocalizations.of(context)!.characterLeft,
          style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
              color: kTextColor),
        ),
      ),
      style: TextStyle(fontSize: 14.sp),
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => title = newValue,
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
        if (value.length <= 100) {
          setState(() {
            error = null;
          });
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            error = '';
          });
        } else if (value.length < 3) {
          setState(() {
            error = '';
          });
        } else if (value.length > 100) {
          setState(() {
            error = '';
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
        hintText: AppLocalizations.of(context)!.hintTitle,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Widget buildDescriptionReviewFormField() {
    String? error;
    return TextFormField(
      maxLines: 4,
      maxLength: 3000,
      buildCounter:
          (_, {required currentLength, maxLength, required isFocused}) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
          (maxLength! - currentLength).toString() +
              ' ' +
              AppLocalizations.of(context)!.characterLeft,
          style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
              color: kTextColor),
        ),
      ),
      style: TextStyle(fontSize: 14.sp),
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => description = newValue,
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
        if (value.length <= 3000) {
          setState(() {
            error = null;
          });
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          setState(() {
            error = '';
          });
        } else if (value.length < 3) {
          setState(() {
            error = '';
          });
        } else if (value.length > 3000) {
          setState(() {
            error = '';
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
        hintText: AppLocalizations.of(context)!.hintDescriptionReview,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
