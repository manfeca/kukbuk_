import 'package:flutter/material.dart';

class SectionHeadingText extends StatelessWidget {
  final String title;
  final AlignmentGeometry alignment;
  final Color? textColor;

//  final Color textColor;

  SectionHeadingText({
    required this.title,
    this.alignment = Alignment.center,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              color: textColor,
            ),
      ),
    );
  }
}
