import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kukbuk/kukbukAppTheme.dart';
import '../models/recipe_model.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel recipeModel;

  const RecipeCard({required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      /*   margin: EdgeInsets.only(
        right: 8.0,
        left: 8.0,
        top: 8.0,
        bottom: 8.0,
      ), */
      // elevation: 10,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200.0,

                // ==========================
                // Get image from recipemodel
                // ==========================
                child: ClipRRect(
                  //     borderRadius: BorderRadius.only(
                  // topLeft: Radius.circular(20.0),
                  //topRight: Radius.circular(20.0),
                  //    bottomLeft: Radius.circular(20.0),
                  //    bottomRight: Radius.circular(20.0),
                  // ),
                  child: recipeModel.imageFile!.contains("assets")
                      ? Image.asset(recipeModel.imageFile!, fit: BoxFit.cover)
                      : Image.file(
                          File(recipeModel.imageFile!),
                          fit: BoxFit.cover,
                        ),
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
                  title: Text(
                    recipeModel.name!,
                    textAlign: TextAlign.center,
                    style: KukbukAppTheme.recipeTitleStyle,
                  ),
                  trailing: (recipeModel.favourite == true
                      ? Icon(Icons.favorite, color: Colors.white)
                      : null),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
