import 'package:flutter/foundation.dart';

class RecipeDetailsProvider extends ChangeNotifier {
  int _navigationBarcurrentIndex = 0;

  int get navigationBarcurrentIndex => _navigationBarcurrentIndex;

   int _stepsLength = 1;
   int _stepsPosition = 0;

  set stepsLength(int value) {
    stepsLength = value;
    notifyListeners();
  }

  int get stepsLength => _stepsLength;

  set stepsPosition(int value) {
    _stepsPosition = value;
    notifyListeners();
  }

  int get stepsPosition => _stepsPosition;

  set navigationBarcurrentIndex(int value) {
    _navigationBarcurrentIndex = value;
    notifyListeners();
  }
} //
