import 'package:flutter/material.dart';

class SearchModel extends ChangeNotifier {
  String _searchText = '';

  String get searchText => _searchText;

  set searchText(String searchText) {
    _searchText = searchText;
    notifyListeners();
  }
}