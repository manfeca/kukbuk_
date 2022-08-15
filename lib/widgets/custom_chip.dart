import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final IconData icon;
  final String? category;
  final Color? backgroundColor;
  final Color mainColor;

  CustomChip({
    required this.icon,
    required this.category,
    required this.backgroundColor,
    required this.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: backgroundColor,
      avatar: Icon(
        icon,
        semanticLabel: this.category,
        color: mainColor,
      ),
      label: Text(
        category!,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: mainColor,
        ),
      ),
    );
  }
}
