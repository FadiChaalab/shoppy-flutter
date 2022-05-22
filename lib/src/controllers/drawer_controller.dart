import 'package:flutter/cupertino.dart';

class DrawerModel extends ChangeNotifier {
  int _currentScreen = 0;
  int get currentScreen => _currentScreen;
  void changeScreen(int index) {
    _currentScreen = index;
    notifyListeners();
  }
}
