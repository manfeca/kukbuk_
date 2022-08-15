import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MassUnitConverterProvider extends ChangeNotifier {
  // Const
  final List<String> _massUnitsList = <String>[
    "Ounce",
    "Pound",
    "Stone",
    "US ton",
    "Imp. ton",
    "Microgram",
    "Milligram",
    "Gram",
    "Kilogram",
    "Tonne"
  ];

  // ignore: deprecated_member_use
  final List _tableOfEquivalences =
      List.generate(10, (i) => List.filled(10, 0.0));

  String? _selectedUnitA;
  String? _selectedUnitB;
  TextEditingController? textEditingControllerTextFieldOne;
  TextEditingController? textEditingControllerTextFieldTwo;

  MassUnitConverterProvider() {
    selectedUnitA = _massUnitsList.first;
    selectedUnitB = _massUnitsList.first;
    generateTableOfEquivalences();
    textEditingControllerTextFieldOne = new TextEditingController();
    textEditingControllerTextFieldTwo = new TextEditingController();
  }

  void getEquivalenceResult() {
    String textFieldValue = textEditingControllerTextFieldOne!.text;

    var textField1;
    try {
      textField1 = double.parse(textFieldValue);

      int row = _massUnitsList.indexOf(_selectedUnitA!);
      int col = _massUnitsList.indexOf(_selectedUnitB!);
      double result = textField1 * _tableOfEquivalences[row][col];

      textEditingControllerTextFieldTwo!.text = result.toStringAsPrecision(6);
      notifyListeners();
    } on FormatException {
      //    textEditingControllerTextFieldTwo!.text = "";
      textEditingControllerTextFieldOne!.clear();
      textEditingControllerTextFieldTwo!.text = '';
      notifyListeners();
    }

    notifyListeners();
  }

  String? get selectedUnitA => _selectedUnitA;

  set selectedUnitA(String? selectedUnitA) {
    _selectedUnitA = selectedUnitA;
    notifyListeners();
  }

  String? get selectedUnitB => _selectedUnitB;

  set selectedUnitB(String? selectedUnitB) {
    _selectedUnitB = selectedUnitB;
    notifyListeners();
  }

  List<String> get massUnitsList => _massUnitsList;

  void generateTableOfEquivalences() {
    // OUNCE
    _tableOfEquivalences[0][0] = 1.0; // Ounce
    _tableOfEquivalences[0][1] = 0.0625; // Pound
    _tableOfEquivalences[0][2] = 0.00446429; // Stone
    _tableOfEquivalences[0][3] = 3.125e-5; //US tonne
    _tableOfEquivalences[0][4] = 2.7902e-5; // Imperial tonne
    _tableOfEquivalences[0][5] = 2.835e+7; // Microgram
    _tableOfEquivalences[0][6] = 28349.5; // Milligram
    _tableOfEquivalences[0][7] = 28.3495; //Gram
    _tableOfEquivalences[0][8] = 0.0283495; // Kilogram
    _tableOfEquivalences[0][9] = 2.835e-5; // tonne

    //

    _tableOfEquivalences[1][0] = 16.0; // Ounce
    _tableOfEquivalences[1][1] = 1.0; // Pound
    _tableOfEquivalences[1][2] = 0.0714286; // Stone
    _tableOfEquivalences[1][3] = 0.0005; // US tonne
    _tableOfEquivalences[1][4] = 0.000446429; // Imperial tonne
    _tableOfEquivalences[1][5] = 4.536e+8; // Microgram
    _tableOfEquivalences[1][6] = 453592.0; // Milligram
    _tableOfEquivalences[1][7] = 453.592; //Gram
    _tableOfEquivalences[1][8] = 0.453592; // Kilogram
    _tableOfEquivalences[1][9] = 0.000453592; // Tonne

    // Stone

    _tableOfEquivalences[2][0] = 224.0;
    _tableOfEquivalences[2][1] = 14.0;
    _tableOfEquivalences[2][2] = 1.0;
    _tableOfEquivalences[2][3] = 0.007;
    _tableOfEquivalences[2][4] = 0.00625;
    _tableOfEquivalences[2][5] = 6.35e+9;
    _tableOfEquivalences[2][6] = 6.35e+6;
    _tableOfEquivalences[2][7] = 6350.29;
    _tableOfEquivalences[2][8] = 6.35029;
    _tableOfEquivalences[2][9] = 0.00635029;

    // US tonne

    _tableOfEquivalences[3][0] = 32000.0;
    _tableOfEquivalences[3][1] = 2000.0;
    _tableOfEquivalences[3][2] = 142.857;
    _tableOfEquivalences[3][3] = 1.0;
    _tableOfEquivalences[3][4] = 0.892857;
    _tableOfEquivalences[3][5] = 9.072e+11;
    _tableOfEquivalences[3][6] = 9.072e+8;
    _tableOfEquivalences[3][7] = 907185.0;
    _tableOfEquivalences[3][8] = 907.185;
    _tableOfEquivalences[3][9] = 0.907185;

    // Imperial tonne

    _tableOfEquivalences[4][0] = 35840.0;
    _tableOfEquivalences[4][1] = 2240.0;
    _tableOfEquivalences[4][2] = 160.0;
    _tableOfEquivalences[4][3] = 1.12;
    _tableOfEquivalences[4][4] = 1.0;
    _tableOfEquivalences[4][5] = 1.016e+12;
    _tableOfEquivalences[4][6] = 1.016e+9;
    _tableOfEquivalences[4][7] = 1.016e+6;
    _tableOfEquivalences[4][8] = 1016.05;
    _tableOfEquivalences[4][9] = 1.01605;

    // Microgram

    _tableOfEquivalences[5][0] = 3.5274e-8;
    _tableOfEquivalences[5][1] = 2.2046e-9;
    _tableOfEquivalences[5][2] = 1.5747e-10;
    _tableOfEquivalences[5][3] = 1.1023e-12;
    _tableOfEquivalences[5][4] = 9.8421e-13;
    _tableOfEquivalences[5][5] = 1.0;
    _tableOfEquivalences[5][6] = 0.001;
    _tableOfEquivalences[5][7] = 1e-6;
    _tableOfEquivalences[5][8] = 1e-9;
    _tableOfEquivalences[5][9] = 1e-12;

    // Milligram

    _tableOfEquivalences[6][0] = 3.5274e-5;
    _tableOfEquivalences[6][1] = 2.2046e-6;
    _tableOfEquivalences[6][2] = 1.5747e-7;
    _tableOfEquivalences[6][3] = 1.1023e-9;
    _tableOfEquivalences[6][4] = 9.8421e-10;
    _tableOfEquivalences[6][5] = 1000.0;
    _tableOfEquivalences[6][6] = 1.0;
    _tableOfEquivalences[6][7] = 0.001;
    _tableOfEquivalences[6][8] = 1e-6;
    _tableOfEquivalences[6][9] = 1e-9;

    // Gram

    _tableOfEquivalences[7][0] = 0.035274;
    _tableOfEquivalences[7][1] = 0.00220462;
    _tableOfEquivalences[7][2] = 0.000157473;
    _tableOfEquivalences[7][3] = 1.1023e-6;
    _tableOfEquivalences[7][4] = 9.8421e-7;
    _tableOfEquivalences[7][5] = 1e+6;
    _tableOfEquivalences[7][6] = 1000.0;
    _tableOfEquivalences[7][7] = 1.0;
    _tableOfEquivalences[7][8] = 0.001;
    _tableOfEquivalences[7][9] = 1e-6;

    // Kilogram

    _tableOfEquivalences[8][0] = 35.274;
    _tableOfEquivalences[8][1] = 2.20462;
    _tableOfEquivalences[8][2] = 0.157473;
    _tableOfEquivalences[8][3] = 0.00110231;
    _tableOfEquivalences[8][4] = 0.000984207;
    _tableOfEquivalences[8][5] = 1e+9;
    _tableOfEquivalences[8][6] = 1e+6;
    _tableOfEquivalences[8][7] = 1000.0;
    _tableOfEquivalences[8][8] = 1.0;
    _tableOfEquivalences[8][9] = 0.001;

    // Tonne

    _tableOfEquivalences[9][0] = 35274.0;
    _tableOfEquivalences[9][1] = 2204.62;
    _tableOfEquivalences[9][2] = 157.473;
    _tableOfEquivalences[9][3] = 1.10231;
    _tableOfEquivalences[9][4] = 0.984207;
    _tableOfEquivalences[9][5] = 1e+12;
    _tableOfEquivalences[9][6] = 1e+9;
    _tableOfEquivalences[9][7] = 1e+6;
    _tableOfEquivalences[9][8] = 1000.0;
    _tableOfEquivalences[9][9] = 0.001;
  }
}
