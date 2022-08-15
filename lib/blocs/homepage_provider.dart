import 'package:flutter/foundation.dart';

class HomePageProvider extends ChangeNotifier {
  // Control the search button pressed in the appbar
  // // and trigger the search  textfield
  bool _isSearchButtonPressed = false;

  set isSearchButtonPressed(bool value) {
    _isSearchButtonPressed = value;
    notifyListeners();
  }

  bool get isSearchButtonPressed => _isSearchButtonPressed;

  // Index of homepage for RootPage bottomnavigationbar
  //
  int _homepageNavigationBarCurrentIndex = 0;

  int get homepageNavigationBarCurrentIndex =>
      _homepageNavigationBarCurrentIndex;

  set homepageNavigationBarCurrentIndex(int value) {
    _homepageNavigationBarCurrentIndex = value;
    notifyListeners();
  }

  // Control AppBar favourite button
  //
  bool _showFavorites = false;

  bool get getShowFavorites => _showFavorites;

  set setShowFavorites(bool showFavorites) {
    this._showFavorites = showFavorites;
    notifyListeners();
  }
}
