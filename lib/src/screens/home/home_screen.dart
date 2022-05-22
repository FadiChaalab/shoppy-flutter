import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop/src/controllers/drawer_controller.dart';
import 'package:shop/src/controllers/theme_controller.dart';
import 'package:shop/src/screens/bookmarks/bookmarks_screen.dart';
import 'package:shop/src/screens/cart/cart_screen.dart';
import 'package:shop/src/screens/discover/discover_screen.dart';
import 'package:shop/src/screens/home/components/body.dart';
import 'package:shop/src/screens/profile/profile_screen.dart';
import 'package:shop/src/utils/constante.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const Body(),
      const DiscoverScreen(),
      const BookmarksScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Consumer<ThemeController>(builder: (context, theme, _) {
          return AnimatedSwitcher(
            duration: kDefaultAnimationDuration,
            child: theme.darkMode
                ? Image.asset(
                    'assets/images/logo-light.png',
                    height: 40,
                    width: 84,
                    key: ValueKey(theme.darkMode),
                  )
                : Image.asset(
                    'assets/images/logo-dark.png',
                    height: 40,
                    width: 84,
                    key: ValueKey(theme.darkMode),
                  ),
          );
        }),
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            icon: SvgPicture.asset(
              "assets/icons/Scan.svg",
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {},
          ),
          IconButton(
            splashColor: Colors.transparent,
            icon: SvgPicture.asset(
              "assets/icons/Notification.svg",
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<DrawerModel>(
        builder: (context, controller, _) {
          return screens[controller.currentScreen];
        },
      ),
      bottomNavigationBar:
          Consumer<DrawerModel>(builder: (context, controller, _) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).backgroundColor.withOpacity(0.3),
                blurRadius: 8.0,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Theme.of(context).scaffoldBackgroundColor),
            child: BottomNavigationBar(
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              selectedFontSize: 12,
              selectedItemColor: kPrimaryColor,
              showSelectedLabels: true,
              elevation: 0,
              currentIndex: controller.currentScreen,
              onTap: controller.changeScreen,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Home.svg",
                    color: controller.currentScreen == 0
                        ? kPrimaryColor
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  label: AppLocalizations.of(context)!.home,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Category.svg",
                    color: controller.currentScreen == 1
                        ? kPrimaryColor
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  label: AppLocalizations.of(context)!.discover,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Bookmark.svg",
                    color: controller.currentScreen == 2
                        ? kPrimaryColor
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  label: AppLocalizations.of(context)!.bookmarks,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Bag.svg",
                    color: controller.currentScreen == 3
                        ? kPrimaryColor
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  label: AppLocalizations.of(context)!.cart,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Profile.svg",
                    color: controller.currentScreen == 4
                        ? kPrimaryColor
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  label: AppLocalizations.of(context)!.profile,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
