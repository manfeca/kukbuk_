import 'dart:io';

import 'package:flutter/material.dart';
import '../models/recipe_model.dart';

class CustomAppBarWidget extends StatelessWidget {
  final RecipeModel? recipeModel;

  CustomAppBarWidget({required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      // fit: StackFit.loose,
      //overflow: Overflow.visible,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: recipeModel!.imageFile!.contains("assets")
              ? Image.asset(recipeModel!.imageFile!, fit: BoxFit.cover)
              : Image.file(
                  File(recipeModel!.imageFile!),
                  fit: BoxFit.cover,
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
                //     fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            /*   trailing: (recipeModel.favourite == true
                ? Icon(Icons.favorite, color: Colors.white)
                : null), */
          ),
        ),
      ],
    );
  }
}
