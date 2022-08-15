import 'package:flutter/material.dart';

class KukbukAppTheme {
  KukbukAppTheme._();

  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color lightGrey = Color(0xFF848484);
  static const Color red = Color(0xFFB71C1C);
  static const Color blueGrey = Color(0xFF263238);
// TextStyles

  static const TextStyle bodyTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
  );

  static const TextStyle bodyTextStyle2 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
  );

  static const TextStyle recipeTitleStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.white,
  );

  static const TextStyle recipeDetailStepHeading = TextStyle(
    color: KukbukAppTheme.red, //Theme.of(context).primaryColorDark,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontSize: 20.0,
  );

  static const TextStyle textFieldTextStyle = TextStyle(fontSize: 16.0);

  static InputDecoration getTextFieldLightDecoration(BuildContext context) =>
      InputDecoration(
        fillColor: Colors.blueGrey[50], //Colors.grey[200],
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
      );

  static InputDecoration getTextFieldDarkDecoration(BuildContext context) =>
      InputDecoration(
        fillColor: Colors.black,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
          //  borderRadius: BorderRadius.circular(10.0),
        ),
      );

  static BoxDecoration getTextFieldLikeDecorationLight(BuildContext context) =>
      BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1.0,
        ),
      );

  static BoxDecoration getTextFieldLikeDecorationDark(BuildContext context) =>
      BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1.0,
        ),
      );
}
