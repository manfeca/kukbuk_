import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../models/ingredient_text_model.dart';
import '../resources/repository.dart';

class ShoppingListProvider extends ChangeNotifier {
  final myBuffer = new List.empty();

  List<IngredientTextModel>? _shoppingList;

  List<IngredientTextModel>? get shoppingList => _shoppingList;

  StreamController<List<IngredientTextModel>?> _streamController =
      new StreamController<List<IngredientTextModel>?>.broadcast();

  Stream<List<IngredientTextModel>?> get shoppingListStream =>
      _streamController.stream;

  ShoppingListProvider() {
    _init();
  }

  _init() async {
    _shoppingList = await recipeDbProvider.fetchShoppingListIngredients();

    _streamController.sink.add(_shoppingList);
  }

  Future<void> addIngredientToShoppingList(String text) async {
    await recipeDbProvider.insertIngredient(
        IngredientTextModel(name: text, strikethroughtext: false));
    await updateShoppingList();
  }

  Future<void> updateIngredient(IngredientTextModel ingredientTextModel) async {
    await recipeDbProvider.updateIngredient(ingredientTextModel);
    await updateShoppingList();
  }

  Future<void> deleteIngredient(int? id) async {
    await recipeDbProvider.deleteIngredient(id);
    await updateShoppingList();
  }

  updateShoppingList() async {
    _shoppingList = await recipeDbProvider.fetchShoppingListIngredients();
    _streamController.sink.add(_shoppingList);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  final TextEditingController _textController = new TextEditingController();
  TextEditingController get textController => _textController;
}
