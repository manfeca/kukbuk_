// THIS CLASS IS NOT USED

import 'dart:io';

import 'package:flutter/material.dart';
import '../models/recipe_model.dart';

class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final double? expandedHeight;
  final RecipeModel? recipeModel;

  CustomSliverAppBar({this.recipeModel, this.expandedHeight});

  @override
  double get maxExtent => expandedHeight!;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      // fit: StackFit.expand,
      // overflow: Overflow.clip,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: expandedHeight,
          child: recipeModel!.imageFile!.contains("assets")
              ? Image.asset(recipeModel!.imageFile!, fit: BoxFit.cover)
              : Image.file(
                  File(recipeModel!.imageFile!),
                  fit: BoxFit.contain,
                ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                tileMode: TileMode.clamp,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.5),
                  Theme.of(context).primaryColor.withOpacity(1.0),
                ]),
          ),
          child: ListTile(
            /*  leading: Icon(
                Icons.restaurant_menu,
                color: Theme.of(context).primaryColorDark,
                size: 26.0,
              ), */
            title: Text(
              recipeModel!.name!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            trailing: (recipeModel!.favourite == true
                ? Icon(Icons.favorite, color: Colors.white)
                : null),
          ),
        ),
      ],
    );
  }
}
