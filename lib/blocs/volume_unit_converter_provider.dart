import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VolumeUnitConverterProvider extends ChangeNotifier {
  // Const
  final List<String> _volumeUnitsList = <String>[
    "Teaspoon (tspn)",
    "Tablespoon (tbsp)",
    "Fluid ounce (fl oz)",
    "Cup",
    "Pint",
    "Quart (qt)",
    "Gallon (gal)",
    "Liter (l)",
    "Milliliter (mL)",
    "US teaspoon",
    "US tablespoon",
    "US fluid ounce",
    "US cup",
    "US pint",
    "US quart",
    "US gallon"
  ];

  // ignore: deprecated_member_use
  final List _tableOfEquivalences =
      List.generate(16, (i) => List.filled(16, 0.0));

  String? _selectedUnitA;
  String? _selectedUnitB;
  TextEditingController? textEditingControllerTextFieldOne;
  TextEditingController? textEditingControllerTextFieldTwo;

  VolumeUnitConverterProvider() {
    selectedUnitA = _volumeUnitsList.first;
    selectedUnitB = _volumeUnitsList.first;
    generateTableOfEquivalences();
    textEditingControllerTextFieldOne = new TextEditingController();
    textEditingControllerTextFieldTwo = new TextEditingController();
  }

  void getEquivalenceResult() {
    String textFieldValue = textEditingControllerTextFieldOne!.text;

    var textField1;
    try {
      textField1 = double.parse(textFieldValue);

      int row = _volumeUnitsList.indexOf(_selectedUnitA!);
      int col = _volumeUnitsList.indexOf(_selectedUnitB!);
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

  List<String> get volumeUnitsList => _volumeUnitsList;

  void generateTableOfEquivalences() {
    // TEASPOON
    _tableOfEquivalences[0][0] = 1.0; // imperial teaspoon
    _tableOfEquivalences[0][1] = 0.3333; // imperial tablespoon
    _tableOfEquivalences[0][2] = 0.2083; // fluid ounce
    _tableOfEquivalences[0][3] = 0.0208333; // Cup
    _tableOfEquivalences[0][4] = 0.0104167; // Imperial pint
    _tableOfEquivalences[0][5] = 0.00520834; // Quart
    _tableOfEquivalences[0][6] = 0.00130208; // Imperial gallon
    _tableOfEquivalences[0][7] = 0.00591939; //Liter
    _tableOfEquivalences[0][8] = 5.91939; // Milliliter
    _tableOfEquivalences[0][9] = 1.20095; // US teaspoon
    _tableOfEquivalences[0][10] = 0.400317; // US tablespoon
    _tableOfEquivalences[0][11] = 0.200158; // US fluid ounce
    _tableOfEquivalences[0][12] = 0.0246641; // US legal cup
    _tableOfEquivalences[0][13] = 0.0125099; // US ping
    _tableOfEquivalences[0][14] = 0.00625495; // US quart
    _tableOfEquivalences[0][15] = 0.00156374; // US gallon

    // tABLESPOON

    _tableOfEquivalences[1][0] = 3.0; // imperial teaspoon
    _tableOfEquivalences[1][1] = 1.0; // imperial tablespoon
    _tableOfEquivalences[1][2] = 0.625; // fluid ounce
    _tableOfEquivalences[1][3] = 0.0625; // Cup
    _tableOfEquivalences[1][4] = 0.03125; // Imperial pint
    _tableOfEquivalences[1][5] = 0.015625; // Quart
    _tableOfEquivalences[1][6] = 0.00390625; // Imperial gallon
    _tableOfEquivalences[1][7] = 0.0177582; //Liter
    _tableOfEquivalences[1][8] = 17.7582; // Milliliter
    _tableOfEquivalences[1][9] = 3.60285; // US teaspoon
    _tableOfEquivalences[1][10] = 1.20095; // US tablespoon
    _tableOfEquivalences[1][11] = 0.600475; // US fluid ounce
    _tableOfEquivalences[1][12] = 0.0739924; // US legal cup
    _tableOfEquivalences[1][13] = 0.0375297; // US pinT
    _tableOfEquivalences[1][14] = 0.0187649; // US quart
    _tableOfEquivalences[1][15] = 0.00469121; // US gallon

    //FLUID OUNCE

    _tableOfEquivalences[2][0] = 4.8; // imperial teaspoon
    _tableOfEquivalences[2][1] = 1.6; // imperial tablespoon
    _tableOfEquivalences[2][2] = 1.0; // fluid ounce
    _tableOfEquivalences[2][3] = 0.1; // Cup
    _tableOfEquivalences[2][4] = 0.05; // Imperial pint
    _tableOfEquivalences[2][5] = 0.025; // Quart
    _tableOfEquivalences[2][6] = 0.00625; // Imperial gallon
    _tableOfEquivalences[2][7] = 0.0284131; //Liter
    _tableOfEquivalences[2][8] = 28.4131; // Milliliter
    _tableOfEquivalences[2][9] = 5.76456; // US teaspoon
    _tableOfEquivalences[2][10] = 1.92152; // US tablespoon
    _tableOfEquivalences[2][11] = 0.96076; // US fluid ounce
    _tableOfEquivalences[2][12] = 0.118388; // US legal cup
    _tableOfEquivalences[2][13] = 0.0600475; // US pinT
    _tableOfEquivalences[2][14] = 0.0300237; // US quart
    _tableOfEquivalences[2][15] = 0.00750594; // US gallon

    // imperial cup

    _tableOfEquivalences[3][0] = 48.0; // imperial teaspoon
    _tableOfEquivalences[3][1] = 16.0; // imperial tablespoon
    _tableOfEquivalences[3][2] = 10.0; // fluid ounce
    _tableOfEquivalences[3][3] = 1.0; // Cup
    _tableOfEquivalences[3][4] = 0.5; // Imperial pint
    _tableOfEquivalences[3][5] = 0.25; // Quart
    _tableOfEquivalences[3][6] = 0.0625; // Imperial gallon
    _tableOfEquivalences[3][7] = 0.284131; //Liter
    _tableOfEquivalences[3][8] = 284.131; // Milliliter
    _tableOfEquivalences[3][9] = 57.6456; // US teaspoon
    _tableOfEquivalences[3][10] = 19.2152; // US tablespoon
    _tableOfEquivalences[3][11] = 9.6076; // US fluid ounce
    _tableOfEquivalences[3][12] = 1.18388; // US legal cup
    _tableOfEquivalences[3][13] = 0.600475; // US pint
    _tableOfEquivalences[3][14] = 0.300237; // US quart
    _tableOfEquivalences[3][15] = 0.0750594; // US gallon

    // IMPERIAL PINT

    _tableOfEquivalences[4][0] = 96.0; // imperial teaspoon
    _tableOfEquivalences[4][1] = 32.0; // imperial tablespoon
    _tableOfEquivalences[4][2] = 20.0; // fluid ounce
    _tableOfEquivalences[4][3] = 2.0; // Cup
    _tableOfEquivalences[4][4] = 1.0; // Imperial pint
    _tableOfEquivalences[4][5] = 0.5; // Quart
    _tableOfEquivalences[4][6] = 0.125; // Imperial gallon
    _tableOfEquivalences[4][7] = 0.568261; //Liter
    _tableOfEquivalences[4][8] = 568.261; // Milliliter
    _tableOfEquivalences[4][9] = 115.291; // US teaspoon
    _tableOfEquivalences[4][10] = 38.4304; // US tablespoon
    _tableOfEquivalences[4][11] = 19.2152; // US fluid ounce
    _tableOfEquivalences[4][12] = 2.36776; // US legal cup
    _tableOfEquivalences[4][13] = 1.20095; // US pint
    _tableOfEquivalences[4][14] = 0.600475; // US quart
    _tableOfEquivalences[4][15] = 0.150119; // US gallon

    // IMPERIAL QUART

    _tableOfEquivalences[5][0] = 192.0; // imperial teaspoon
    _tableOfEquivalences[5][1] = 64.0; // imperial tablespoon
    _tableOfEquivalences[5][2] = 40.0; // fluid ounce
    _tableOfEquivalences[5][3] = 4.0; // Cup
    _tableOfEquivalences[5][4] = 2.0; // Imperial pint
    _tableOfEquivalences[5][5] = 1.0; // Quart
    _tableOfEquivalences[5][6] = 0.25; // Imperial gallon
    _tableOfEquivalences[5][7] = 1.13652; //Liter
    _tableOfEquivalences[5][8] = 1136.52; // Milliliter
    _tableOfEquivalences[5][9] = 230.582; // US teaspoon
    _tableOfEquivalences[5][10] = 76.8608; // US tablespoon
    _tableOfEquivalences[5][11] = 38.4304; // US fluid ounce
    _tableOfEquivalences[5][12] = 4.73551; // US legal cup
    _tableOfEquivalences[5][13] = 2.4019; // US pint
    _tableOfEquivalences[5][14] = 1.20095; // US quart
    _tableOfEquivalences[5][15] = 0.300237; // US gallon

    // IMPERIAL GALLON

    _tableOfEquivalences[6][0] = 768.0; // imperial teaspoon
    _tableOfEquivalences[6][1] = 256.0; // imperial tablespoon
    _tableOfEquivalences[6][2] = 160.0; // fluid ounce
    _tableOfEquivalences[6][3] = 16.0; // Cup
    _tableOfEquivalences[6][4] = 8.0; // Imperial pint
    _tableOfEquivalences[6][5] = 4.0; // Quart
    _tableOfEquivalences[6][6] = 1.0; // Imperial gallon
    _tableOfEquivalences[6][7] = 4.54609; //Liter
    _tableOfEquivalences[6][8] = 4546.09; // Milliliter
    _tableOfEquivalences[6][9] = 922.33; // US teaspoon
    _tableOfEquivalences[6][10] = 307.443; // US tablespoon
    _tableOfEquivalences[6][11] = 153.722; // US fluid ounce
    _tableOfEquivalences[6][12] = 18.942; // US legal cup
    _tableOfEquivalences[6][13] = 9.6076; // US pint
    _tableOfEquivalences[6][14] = 4.8038; // US quart
    _tableOfEquivalences[6][15] = 1.20095; // US gallon

    // LITER

    _tableOfEquivalences[7][0] = 168.936; // imperial teaspoon
    _tableOfEquivalences[7][1] = 56.3121; // imperial tablespoon
    _tableOfEquivalences[7][2] = 35.1951; // fluid ounce
    _tableOfEquivalences[7][3] = 3.51951; // Cup
    _tableOfEquivalences[7][4] = 1.75975; // Imperial pint
    _tableOfEquivalences[7][5] = 0.879877; // Quart
    _tableOfEquivalences[7][6] = 0.219969; // Imperial gallon
    _tableOfEquivalences[7][7] = 1.0; //Liter
    _tableOfEquivalences[7][8] = 1000.0; // Milliliter
    _tableOfEquivalences[7][9] = 202.884; // US teaspoon
    _tableOfEquivalences[7][10] = 67.628; // US tablespoon
    _tableOfEquivalences[7][11] = 33.814; // US fluid ounce
    _tableOfEquivalences[7][12] = 4.16667; // US legal cup
    _tableOfEquivalences[7][13] = 2.11338; // US pint
    _tableOfEquivalences[7][14] = 1.05669; // US quart
    _tableOfEquivalences[7][15] = 0.264172; // US gallon

    // MILLILITER
    _tableOfEquivalences[8][0] = 0.168936; // imperial teaspoon
    _tableOfEquivalences[8][1] = 0.0563121; // imperial tablespoon
    _tableOfEquivalences[8][2] = 0.0351951; // fluid ounce
    _tableOfEquivalences[8][3] = 0.00351951; // Cup
    _tableOfEquivalences[8][4] = 0.00175975; // Imperial pint
    _tableOfEquivalences[8][5] = 0.000879877; // Quart
    _tableOfEquivalences[8][6] = 0.000219969; // Imperial gallon
    _tableOfEquivalences[8][7] = 0.001; //Liter
    _tableOfEquivalences[8][8] = 1.0; // Milliliter
    _tableOfEquivalences[8][9] = 0.202884; // US teaspoon
    _tableOfEquivalences[8][10] = 0.067628; // US tablespoon
    _tableOfEquivalences[8][11] = 0.033814; // US fluid ounce
    _tableOfEquivalences[8][12] = 0.00416667; // US legal cup
    _tableOfEquivalences[8][13] = 0.00211338; // US pint
    _tableOfEquivalences[8][14] = 0.00105669; // US quart
    _tableOfEquivalences[8][15] = 0.000264172; // US gallon

    // US TEASPOON
    _tableOfEquivalences[9][0] = 0.832674; // imperial teaspoon
    _tableOfEquivalences[9][1] = 0.277558; // imperial tablespoon
    _tableOfEquivalences[9][2] = 0.173474; // fluid ounce
    _tableOfEquivalences[9][3] = 0.0173474; // Cup
    _tableOfEquivalences[9][4] = 0.00867369; // Imperial pint
    _tableOfEquivalences[9][5] = 0.00433684; // Quart
    _tableOfEquivalences[9][6] = 0.00108421; // Imperial gallon
    _tableOfEquivalences[9][7] = 0.00492892; //Liter
    _tableOfEquivalences[9][8] = 4.92892; // Milliliter
    _tableOfEquivalences[9][9] = 1.0; // US teaspoon
    _tableOfEquivalences[9][10] = 0.333333; // US tablespoon
    _tableOfEquivalences[9][11] = 0.166667; // US fluid ounce
    _tableOfEquivalences[9][12] = 0.0205372; // US legal cup
    _tableOfEquivalences[9][13] = 0.0104167; // US pint
    _tableOfEquivalences[9][14] = 0.00520833; // US quart
    _tableOfEquivalences[9][15] = 0.00130208; // US gallon

    // us tablespoon
    _tableOfEquivalences[10][0] = 2.49802; // imperial teaspoon
    _tableOfEquivalences[10][1] = 0.832674; // imperial tablespoon
    _tableOfEquivalences[10][2] = 0.520421; // fluid ounce
    _tableOfEquivalences[10][3] = 0.0520421; // Cup
    _tableOfEquivalences[10][4] = 0.0260211; // Imperial pint
    _tableOfEquivalences[10][5] = 0.0130105; // Quart
    _tableOfEquivalences[10][6] = 0.00325263; // Imperial gallon
    _tableOfEquivalences[10][7] = 0.0147868; //Liter
    _tableOfEquivalences[10][8] = 14.7868; // Milliliter
    _tableOfEquivalences[10][9] = 3.0; // US teaspoon
    _tableOfEquivalences[10][10] = 1.0; // US tablespoon
    _tableOfEquivalences[10][11] = 0.5; // US fluid ounce
    _tableOfEquivalences[10][12] = 0.0616115; // US legal cup
    _tableOfEquivalences[10][13] = 0.03125; // US pint
    _tableOfEquivalences[10][14] = 0.015625; // US quart
    _tableOfEquivalences[10][15] = 0.00390625; // US gallon

    // FLUID OUNCE
    _tableOfEquivalences[11][0] = 4.99604; // imperial teaspoon
    _tableOfEquivalences[11][1] = 1.66535; // imperial tablespoon
    _tableOfEquivalences[11][2] = 1.04084; // fluid ounce
    _tableOfEquivalences[11][3] = 0.104084; // Cup
    _tableOfEquivalences[11][4] = 0.0520421; // Imperial pint
    _tableOfEquivalences[11][5] = 0.0260211; // Quart
    _tableOfEquivalences[11][6] = 0.00650527; // Imperial gallon
    _tableOfEquivalences[11][7] = 0.0295735; //Liter
    _tableOfEquivalences[11][8] = 29.5735; // Milliliter
    _tableOfEquivalences[11][9] = 6.0; // US teaspoon
    _tableOfEquivalences[11][10] = 2.0; // US tablespoon
    _tableOfEquivalences[11][11] = 1.0; // US fluid ounce
    _tableOfEquivalences[11][12] = 0.123223; // US legal cup
    _tableOfEquivalences[11][13] = 0.0625; // US pint
    _tableOfEquivalences[11][14] = 0.03125; // US quart
    _tableOfEquivalences[11][15] = 0.0078125; // US gallon

    // US LEGAL CUP
    _tableOfEquivalences[12][0] = 40.5447; // imperial teaspoon
    _tableOfEquivalences[12][1] = 13.5149; // imperial tablespoon
    _tableOfEquivalences[12][2] = 8.44682; // fluid ounce
    _tableOfEquivalences[12][3] = 0.844682; // Cup
    _tableOfEquivalences[12][4] = 0.422341; // Imperial pint
    _tableOfEquivalences[12][5] = 0.21117; // Quart
    _tableOfEquivalences[12][6] = 0.0527926; // Imperial gallon
    _tableOfEquivalences[12][7] = 0.24; //Liter
    _tableOfEquivalences[12][8] = 240.0; // Milliliter
    _tableOfEquivalences[12][9] = 48.6922; // US teaspoon
    _tableOfEquivalences[12][10] = 16.2307; // US tablespoon
    _tableOfEquivalences[12][11] = 8.11537; // US fluid ounce
    _tableOfEquivalences[12][12] = 1.0; // US legal cup
    _tableOfEquivalences[12][13] = 0.50721; // US pint
    _tableOfEquivalences[12][14] = 0.253605; // US quart
    _tableOfEquivalences[12][15] = 0.0634013; // US gallon

    // US PINT

    _tableOfEquivalences[13][0] = 79.9367; // imperial teaspoon
    _tableOfEquivalences[13][1] = 26.6456; // imperial tablespoon
    _tableOfEquivalences[13][2] = 16.6535; // fluid ounce
    _tableOfEquivalences[13][3] = 1.66535; // Cup
    _tableOfEquivalences[13][4] = 0.832674; // Imperial pint
    _tableOfEquivalences[13][5] = 0.416337; // Quart
    _tableOfEquivalences[13][6] = 0.104084; // Imperial gallon
    _tableOfEquivalences[13][7] = 0.473176; //Liter
    _tableOfEquivalences[13][8] = 473.176; // Milliliter
    _tableOfEquivalences[13][9] = 96.0; // US teaspoon
    _tableOfEquivalences[13][10] = 32.0; // US tablespoon
    _tableOfEquivalences[13][11] = 16.0; // US fluid ounce
    _tableOfEquivalences[13][12] = 1.97157; // US legal cup
    _tableOfEquivalences[13][13] = 1.0; // US pint
    _tableOfEquivalences[13][14] = 0.5; // US quart
    _tableOfEquivalences[13][15] = 0.125; // US gallon

    // US LIQUID QUART
    _tableOfEquivalences[14][0] = 159.873; // imperial teaspoon
    _tableOfEquivalences[14][1] = 53.2911; // imperial tablespoon
    _tableOfEquivalences[14][2] = 33.307; // fluid ounce
    _tableOfEquivalences[14][3] = 3.3307; // Cup
    _tableOfEquivalences[14][4] = 1.66535; // Imperial pint
    _tableOfEquivalences[14][5] = 0.832674; // Quart
    _tableOfEquivalences[14][6] = 0.208169; // Imperial gallon
    _tableOfEquivalences[14][7] = 0.946353; //Liter
    _tableOfEquivalences[14][8] = 946.353; // Milliliter
    _tableOfEquivalences[14][9] = 192.0; // US teaspoon
    _tableOfEquivalences[14][10] = 64.0; // US tablespoon
    _tableOfEquivalences[14][11] = 32.0; // US fluid ounce
    _tableOfEquivalences[14][12] = 3.94314; // US legal cup
    _tableOfEquivalences[14][13] = 2.0; // US pint
    _tableOfEquivalences[14][14] = 1.0; // US quart
    _tableOfEquivalences[14][15] = 0.25; // US gallon

    // US GALLON

    _tableOfEquivalences[15][0] = 639.494; // imperial teaspoon
    _tableOfEquivalences[15][1] = 213.165; // imperial tablespoon
    _tableOfEquivalences[15][2] = 133.228; // fluid ounce
    _tableOfEquivalences[15][3] = 13.3228; // Cup
    _tableOfEquivalences[15][4] = 6.66139; // Imperial pint
    _tableOfEquivalences[15][5] = 3.3307; // Quart
    _tableOfEquivalences[15][6] = 0.832674; // Imperial gallon
    _tableOfEquivalences[15][7] = 3.78541; //Liter
    _tableOfEquivalences[15][8] = 3785.41; // Milliliter
    _tableOfEquivalences[15][9] = 768.0; // US teaspoon
    _tableOfEquivalences[15][10] = 256.0; // US tablespoon
    _tableOfEquivalences[15][11] = 128.0; // US fluid ounce
    _tableOfEquivalences[15][12] = 15.7725; // US legal cup
    _tableOfEquivalences[15][13] = 8.0; // US pint
    _tableOfEquivalences[15][14] = 4.0; // US quart
    _tableOfEquivalences[15][15] = 1.0; // US gallon
  }
}
