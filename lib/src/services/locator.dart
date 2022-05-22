import 'package:shop/src/controllers/drawer_controller.dart';
import 'package:shop/src/controllers/theme_controller.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setUp() {
  locator.registerSingleton<DrawerModel>(DrawerModel());
  locator.registerSingleton<ThemeController>(ThemeController());
}
