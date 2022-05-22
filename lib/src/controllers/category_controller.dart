import 'package:flutter/cupertino.dart';

class CategoryController extends ChangeNotifier {
  int _selectedCategory = 0;
  int get selectedCategory => _selectedCategory;
  String _categoryName = 'All';
  String get categoryName => _categoryName;
  void changeCategory(int index) {
    _selectedCategory = index;
    notifyListeners();
  }

  void changeCategoryName(String name) {
    _categoryName = name;
    notifyListeners();
  }
}
