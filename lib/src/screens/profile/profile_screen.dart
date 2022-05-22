import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shop/src/components/headline_title.dart';
import 'package:shop/src/components/image_profile.dart';
import 'package:shop/src/controllers/drawer_controller.dart';
import 'package:shop/src/controllers/locale_controller.dart';
import 'package:shop/src/controllers/theme_controller.dart';
import 'package:shop/src/db/auth.dart';
import 'package:shop/src/models/user.dart';
import 'package:shop/src/screens/profile/components/genral_settings_item.dart';
import 'package:shop/src/screens/profile/components/language_item.dart';
import 'package:shop/src/screens/profile/components/user_information_item.dart';
import 'package:shop/src/screens/profile/edit_profile_screen.dart';
import 'package:shop/src/screens/sign_in/sign_in_screen.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authService = AuthService();
    final _drawer = Provider.of<DrawerModel>(context, listen: false);
    signOut() async {
      var result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        await _authService.signOut().then(
          (value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const SignInScreen(),
              ),
            );
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

    final _themeController =
        Provider.of<ThemeController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 20.h),
          Row(
            children: [
              ImageProfile(
                width: 58,
                icon: 'assets/icons/Edit.svg',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfileScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(width: kDefaultPadding),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<UserModel?>(builder: (context, user, _) {
                    String userName = user == null
                        ? ''
                        : user.firstName! + ' ' + user.lastName!;
                    return HeadlineTitle(
                      title: AppLocalizations.of(context)!.greeting +
                          ', ' +
                          userName,
                    );
                  }),
                  const SizedBox(height: kDefaultPadding / 4),
                  Consumer<UserModel?>(builder: (context, user, _) {
                    return Text(
                      user == null ? '' : user.email!,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                    );
                  }),
                ],
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 2),
          HeadlineTitle(title: AppLocalizations.of(context)!.account),
          const SizedBox(height: kDefaultPadding),
          Consumer<UserModel?>(builder: (context, user, _) {
            return UserInformationItem(
              title: AppLocalizations.of(context)!.firstTitle,
              subtitle: user == null ? '' : user.firstName!,
            );
          }),
          Consumer<UserModel?>(builder: (context, user, _) {
            return UserInformationItem(
              title: AppLocalizations.of(context)!.lastTitle,
              subtitle: user == null ? '' : user.lastName!,
            );
          }),
          Consumer<UserModel?>(builder: (context, user, _) {
            return UserInformationItem(
              title: AppLocalizations.of(context)!.ageTitle,
              subtitle: user == null ? '' : user.age!.toString(),
            );
          }),
          Consumer<UserModel?>(builder: (context, user, _) {
            return UserInformationItem(
              title: AppLocalizations.of(context)!.phoneTitle,
              subtitle: user == null ? '' : user.phone!.toString(),
            );
          }),
          Consumer<UserModel?>(builder: (context, user, _) {
            return UserInformationItem(
              title: AppLocalizations.of(context)!.addreseTitle,
              subtitle: user == null ? '' : user.addrese!,
            );
          }),
          const SizedBox(height: kDefaultPadding * 2),
          HeadlineTitle(title: AppLocalizations.of(context)!.personal),
          const SizedBox(height: kDefaultPadding),
          GenralSettingsItem(
            title: AppLocalizations.of(context)!.languages,
            icon: 'assets/icons/global.svg',
            onPress: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  insetAnimationDuration: kDefaultAnimationDuration,
                  insetAnimationCurve: Curves.fastOutSlowIn,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FractionallySizedBox(
                      heightFactor: 0.46,
                      child: Column(
                        children: [
                          const SizedBox(height: kDefaultPadding / 3),
                          SizedBox(
                            height: 134.h,
                            child: Lottie.asset(
                              'assets/json/translate.json',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                            ),
                            child: Consumer<LocaleController>(
                              builder: (context, controller, _) {
                                return LanguageItem(
                                  language: AppLocalizations.of(context)!
                                      .englishLanguage,
                                  flag: 'assets/images/flag-united-kingdom.png',
                                  isSelected:
                                      controller.locale == const Locale('en'),
                                  onTap: () {
                                    controller.changeLocale(const Locale('en'));
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: kDefaultPadding / 2),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                            ),
                            child: Consumer<LocaleController>(
                              builder: (context, controller, _) {
                                return LanguageItem(
                                  language: AppLocalizations.of(context)!
                                      .frenchLanguage,
                                  flag: 'assets/images/flag-france.png',
                                  isSelected:
                                      controller.locale == const Locale('fr'),
                                  onTap: () {
                                    controller.changeLocale(const Locale('fr'));
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          GenralSettingsItem(
            title: AppLocalizations.of(context)!.theme,
            icon: 'assets/icons/bucket.svg',
            onPress: () {
              _themeController.toggleChangeTheme();
            },
          ),
          GenralSettingsItem(
            title: 'Notifications',
            icon: 'assets/icons/Notification.svg',
            onPress: () {},
          ),
          GenralSettingsItem(
            title: AppLocalizations.of(context)!.logout,
            icon: 'assets/icons/Logout.svg',
            onPress: () {
              _drawer.changeScreen(0);
              signOut();
            },
          ),
          const SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
