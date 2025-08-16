import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get SelectedIndex => _selectedIndex;

  void updateindex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
