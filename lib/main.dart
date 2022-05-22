import 'package:shop/src/components/loading_screen.dart';
import 'package:shop/src/controllers/cart_controller.dart';
import 'package:shop/src/controllers/category_controller.dart';
import 'package:shop/src/controllers/drawer_controller.dart';
import 'package:shop/src/controllers/locale_controller.dart';
import 'package:shop/src/controllers/theme_controller.dart';
import 'package:shop/src/db/auth.dart';
import 'package:shop/src/db/products_repo.dart';
import 'package:shop/src/models/product.dart';
import 'package:shop/src/models/user.dart';
import 'package:shop/src/screens/home/home_screen.dart';
import 'package:shop/src/screens/onboard/onboard.dart';
import 'package:shop/src/screens/sign_in/sign_in_screen.dart';
import 'package:shop/src/services/locator.dart';
import 'package:shop/src/theme/theme.dart';
import 'package:shop/src/utils/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

bool _isFirst = true;

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await firebase_core.Firebase.initializeApp();
    setUp();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFirst = prefs.getBool('firstTime') ?? true;
    prefs.setBool('firstTime', false);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    runApp(const MyApp());
  } catch (e) {
    debugPrint(e.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authService = AuthService();
    final _productRepository = ProductRepository();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeController>(
            create: (_) => locator.get<ThemeController>(),
          ),
          ListenableProvider<DrawerModel>(
            create: (_) => locator.get<DrawerModel>(),
          ),
          ListenableProvider<LocaleController>(
            create: (_) => LocaleController(),
          ),
          ListenableProvider<CategoryController>(
            create: (_) => CategoryController(),
          ),
          ListenableProvider<CartController>(
            create: (_) => CartController(),
          ),
          StreamProvider<ConnectivityStatus>(
            create: (_) =>
                ConnectivityService().connectionStatusController.stream,
            initialData: ConnectivityStatus.offline,
          ),
          StreamProvider<UserModel?>.value(
            value: _authService.streamFirestoreUser(),
            initialData: null,
          ),
          StreamProvider<List<Product>?>.value(
            value: _productRepository.getProducts(),
            initialData: null,
          ),
        ],
        child: Consumer2<ThemeController, LocaleController>(
          builder: (context, controller, locale, _) {
            return MaterialApp(
              title: 'Shoppy',
              debugShowCheckedModeBanner: false,
              locale: locale.locale,
              theme: controller.darkMode ? darkTheme : lightTheme,
              home: _isFirst ? const OnboardScreen() : const HomeController(),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
            );
          },
        ),
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  const HomeController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const SignInScreen();
          }
        }
      },
    );
  }
}
