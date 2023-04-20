import 'package:admin/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';

class SideMenuController extends ChangeNotifier {
  MenuEnum _selected = MenuEnum.Hierarchy;

  MenuEnum get selected => _selected;

  set selected(MenuEnum selected) {
    _selected = selected;
    notifyListeners();
  }
}