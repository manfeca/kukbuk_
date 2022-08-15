import 'package:flutter/material.dart';

class GasMarkProvider extends ChangeNotifier {
  //
  final List<String> _gasMarkList = [
    "1/4",
    "1/2",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10"
  ];

  String? _selectedGasMark;

  String? _celsius;
  String? _fahrenheit;
  String? _descriptive;

  String? get celsius => _celsius;

  String? get fahrenheit => _fahrenheit;

  String? get descriptive => _descriptive;

  List<String> get gasMarkList => _gasMarkList;

  GasMarkProvider() {
    _selectedGasMark = _gasMarkList.first;
    _fahrenheit = "225";
    _celsius = "107";
    _descriptive = "Very slow / Very low";
  }

  String? get selectedGasMark => _selectedGasMark;

  set selectedGasMark(String? value) {
    switch (value) {
      case "1/4":
        _selectedGasMark = _gasMarkList[0];
        _celsius = "107";
        _fahrenheit = "225";
        _descriptive = "Very slow / very low";
        break;

      case "1/2":
        _selectedGasMark = _gasMarkList[1];
        _celsius = "121";
        _fahrenheit = "251";
        _descriptive = "Very slow / very low";
        break;

      case "1":
        _selectedGasMark = _gasMarkList[2];
        _celsius = "135";
        _fahrenheit = "275";
        _descriptive = "Slow / Low";
        break;

      case "2":
        _selectedGasMark = _gasMarkList[3];
        _celsius = "149";
        _fahrenheit = "300";
        _descriptive = "Slow / Low";
        break;

      case "3":
        _selectedGasMark = _gasMarkList[4];
        _celsius = "163";
        _fahrenheit = "325";
        _descriptive = "Moderately Slow / Warm";
        break;

      case "4":
        _selectedGasMark = _gasMarkList[5];
        _celsius = "177";
        _fahrenheit = "350";
        _descriptive = "Moderate / Medium";
        break;
      case "5":
        _selectedGasMark = _gasMarkList[6];
        _celsius = "191";
        _fahrenheit = "370";
        _descriptive = "Moderate / Moderately Hot ";
        break;
      case "6":
        _selectedGasMark = _gasMarkList[7];
        _celsius = "204";
        _fahrenheit = "400";
        _descriptive = "Moderately Hot";
        break;
      case "7":
        _selectedGasMark = _gasMarkList[8];
        _celsius = "218";
        _fahrenheit = "425";
        _descriptive = "Hot";
        break;
      case "8":
        _selectedGasMark = _gasMarkList[9];
        _celsius = "232";
        _fahrenheit = "450";
        _descriptive = "Hot / Very Hot";
        break;
      case "9":
        _selectedGasMark = _gasMarkList[10];
        _celsius = "246";
        _fahrenheit = "475";
        _descriptive = "Very Hot";
        break;
      case "10":
        _selectedGasMark = _gasMarkList[11];
        _celsius = "270";
        _fahrenheit = "520";
        _descriptive = "Extremely Hot";
        break;
      default:
        break;
    }

    notifyListeners();
  }
}
