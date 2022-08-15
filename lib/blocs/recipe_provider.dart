// Initialize list from database

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/recipe_model.dart';
import '../resources/repository.dart';

class RecipeProvider extends ChangeNotifier {
  RecipeDbProvider recipeDBProvider = recipeDbProvider;

  StreamController<List<RecipeModel>?> _listOfRecipes =
      new StreamController<List<RecipeModel>?>.broadcast();

  Stream<List<RecipeModel>?> get recipesListStream => _listOfRecipes.stream;

  List<RecipeModel>? recipes;
  List<RecipeModel>? get listOfrecipes => recipes;
  List<RecipeModel> favRecipes = <RecipeModel>[];
  List<RecipeModel> _searchResult = <RecipeModel>[];
  List<RecipeModel> get searchResult => _searchResult;

  RecipeProvider() {
    _init();
  }

  _init() async {
    // Create and initialize database for the first time
    await recipeDBProvider.createDatabase();

    // Fetch the list of recipes if already in database
    recipes = await recipeDBProvider.fetchListOfRecipes();

    // if there's no records in database, parse local json recipes
    // and insert them in database.

    if (recipes == null) {
      await _readJsonFiles();

      // Fetch the json records already in database
      recipes = await recipeDBProvider.fetchListOfRecipes();
    }

    // Add list to stream sink
    _listOfRecipes.sink.add(recipes);
  } // end _init

  Future _readJsonFiles() async {
    String source = await rootBundle.loadString('assets/json/en_recipes.json');
    Map<String, dynamic>? data = await jsonDecode(source);

    // Add hardcoded recipes to list
    for (int i = 0; i < 5; i++) {
      RecipeModel recipe = RecipeModel.fromJson(data!["recipes"][i]);
      await recipeDBProvider.insertRecipe(recipe);
      // Add to the stream
    }
  } // end _readJsonFiles()

  deleteRecipe(RecipeModel recipeModel) async {
    await recipeDBProvider.deleteRecipe(recipeModel.id);
    updateStream();
  }

  // Add a recipe to te database and update the stream object
  addRecipe(RecipeModel recipeModel) async {
    await recipeDBProvider.insertRecipe(recipeModel);
    updateStream();
  }

  fetchRecipe(RecipeModel recipeModel) async {
    await recipeDBProvider.fetchRecipe(recipeModel.id);
    //
  }

  updateRecipe(RecipeModel recipeModel) async {
    await recipeDBProvider.updateRecipe(recipeModel);

    updateStream();
  }

  // Fetch list of recipes from database and update the stream object
  void updateStream() async {
    recipes = await recipeDBProvider.fetchListOfRecipes();

    _listOfRecipes.sink.add(recipes);

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _listOfRecipes.close();
  }

  void updateStreamWithFavourites() async {
    if (recipes != null && recipes!.isNotEmpty) {
      favRecipes.clear();
      int counter = 0;

      for (var e in recipes!) {
        if (e.favourite == true) {
          favRecipes.add(e);
          counter++; // Check the amount of favourities
        }
      } // end

      // if counter is > 0 then update with favourites, else do nothing.
      if (counter > 0) {
        _listOfRecipes.sink.add(favRecipes);
      }

      notifyListeners();
    } // end if
  }

  Future<void> searchInListOfRecipes(String value) async {
    _searchResult.clear();

    for (var e in recipes!) {
      if (e.name!.toLowerCase().contains(value.toLowerCase()) ||
          e.category!.toLowerCase().contains(value.toLowerCase()) ||
          e.difficulty!.toLowerCase().contains(value.toLowerCase()) ||
          e.duration!.toLowerCase().contains(value.toLowerCase()) ||
          e.ingredients!
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()) ||
          e.steps!.toString().toLowerCase().contains(value.toLowerCase())) {
        print("name contains $value");
        _searchResult.add(e);
      }
    }
    _listOfRecipes.sink.add(_searchResult);
    notifyListeners();
  }
}

  // recipes = await recipeDBProvider.fetchListOfRecipes();


