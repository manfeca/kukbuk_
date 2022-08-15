import 'package:flutter/material.dart';
import '../blocs/recipe_provider.dart';
import '../models/recipe_model.dart';
import 'package:provider/provider.dart';

class RecipeFormProvider extends ChangeNotifier {
  // ====================
  // category array
  //======================
  final List<String> _foodCategoriesList = [
    "Appetizer",
    "Beverage",
    "Bread",
    "Cake",
    "Cream",
    "Dessert",
    "Fish",
    "Meat",
    "Pasta",
    "Rice",
    "Salad",
    "Sauce",
    "Seafood",
    "Soup",
    "Stew",
    "Vegetarian"
  ];

  // ===========
  // DIFFICULTY
  // ===========

  final List<String> _recipeDifficultyList = [
    "Easy",
    "Moderate",
    "Advanced",
  ];

  // ============
  // SERVINGS
  // ============

  final List<String?> _numberOfServingsList = [
    "1 person",
    "2 persons",
    "4 persons",
    "6 persons",
    "8 persons",
    "10 persons",
    "12 persons",
  ];

  // =============
  // DEFAULT IMAGE
  // =============

  final String placeHolderImage = "assets/images/placeholder.jpg";

  // variable that test if
  // a recipe is being edited
  // default false.

  bool _isEditingRecipe = false;

  RecipeModel? tempRecipeModel;

  bool get isEditingStep => _isEditingStep;

  bool get isEditingIngredient => _isEditingIngredient;

  editRecipe(RecipeModel recipeModel) {
    _isEditingRecipe = true;
    tempRecipeModel = recipeModel;

    textEditingControllerTitle.text = recipeModel.name!;
    textEditingControllerImagePicker.text = recipeModel.imageFile!;
    selectedCategory = recipeModel.category;

    selectedDifficulty = recipeModel.difficulty;
    switch (recipeModel.difficulty) {
      case "Easy":
        selectedDifficulty = recipeDifficultyList.elementAt(0);
        break;
      case "Moderate":
        selectedDifficulty = recipeDifficultyList.elementAt(1);
        break;
      case "Advanced":
        selectedDifficulty = recipeDifficultyList.elementAt(2);
        break;
    }

    selectedDuration = recipeModel.duration;

    switch (recipeModel.servings) {
      case 1:
        selectedServings = numberOfServingsList.elementAt(0);
        break;
      case 2:
        selectedServings = numberOfServingsList.elementAt(1);
        break;
      case 4:
        selectedServings = numberOfServingsList.elementAt(2);
        break;

      case 6:
        selectedServings = numberOfServingsList.elementAt(3);
        break;
      case 8:
        selectedServings = numberOfServingsList.elementAt(4);
        break;
      case 10:
        selectedServings = numberOfServingsList.elementAt(5);
        break;
      case 12:
        selectedServings = numberOfServingsList.elementAt(6);
        break;
    }
    selectedImagePath = recipeModel.imageFile;

    for (String item in recipeModel.ingredients as Iterable<dynamic>) {
      ingredientsList!.add(item);
    }

    for (String item in recipeModel.steps as Iterable<dynamic>) {
      stepsList!.add(item);
    }
  } //

  // variables that control whether
  // a dismissible ingredient or step
  // is being edited.

  bool _isEditingIngredient = false;
  int _editingIngredientIndex = -1;

  bool _isEditingStep = false;
  int _editingStepIndex = -1;

  // variables that hold the
  // the completed form fields
  // and dropdown menus.

  String? _selectedCategory;
  String? _selectedDifficulty;
  String? _selectedDuration;
  String? _selectedServings;
  String? _selectedImagePath;
  List<String>? _ingredientsList;
  List<String>? _stepsList;

  // Add ingredient method

  addIngredient(String value) {
    if (_ingredientsList == null) {
      _ingredientsList = <String>[];
    }

    if (_isEditingIngredient) {
      try {
        _ingredientsList!.insert(_editingIngredientIndex, value);
        // ignore: non_constant_identifier_names
      } catch (Exception) {
        print("Exception caught!!!");
        _ingredientsList!.add(value);
      }
    } else {
      _ingredientsList!.add(value);
    }
    _isEditingIngredient = false;
    _editingIngredientIndex = -1;
    print(_ingredientsList);
    print(_ingredientsList!.length);
    notifyListeners();
  } //

  // Edit ingredient method

  editIngredient(int index) {
    _isEditingIngredient = true;
    _editingIngredientIndex = index;
  }

  // Delete ingredient method
  deleteIngredient(int index) {
    if (_ingredientsList!.isNotEmpty && index < _ingredientsList!.length) {
      _ingredientsList!.removeAt(index);
    }
    notifyListeners();
  }

// Add step method
  addStep(String value) {
    if (_stepsList == null) {
      _stepsList = <String>[];
    }
    if (_isEditingStep) {
      try {
        _stepsList!.insert(_editingStepIndex, value);
        // ignore: non_constant_identifier_names
      } catch (Exception) {
        print("I caught you!! what a headache you gave me!!!");
        _stepsList!.add(value);
      }
    } else {
      if (!_stepsList!.contains(value)) {
        _stepsList!.add(value);
      }
    }
    _isEditingStep = false;
    _editingStepIndex = -1;
    notifyListeners();
  }

  // Edit ingredient method
  editStep(int index) {
    _isEditingStep = true;
    _editingStepIndex = index;
  }

  // Delete step method
  deleteStep(int index) {
    if (_stepsList!.isNotEmpty && index < _stepsList!.length) {
      _stepsList!.removeAt(index);
    }
    notifyListeners();
  }

  set isEditingIngredient(bool value) {
    _isEditingIngredient = value;
  }

  set isEditingStep(bool value) {
    _isEditingStep = value;
  }

  set isEditingRecipe(bool value) {
    _isEditingRecipe = value;
  }

  set selectedServings(String? value) {
    _selectedServings = value;
    notifyListeners();
  }

  set selectedDuration(String? value) {
    _selectedDuration = value;
    notifyListeners();
  }

  set selectedCategory(String? value) {
    _selectedCategory = value;
    notifyListeners();
  }

  set selectedDifficulty(String? value) {
    _selectedDifficulty = value;
    notifyListeners();
  }

  set selectedImagePath(String? value) {
    _selectedImagePath = value;
    notifyListeners();
  }

  String? get selectedServings => _selectedServings;
  String? get selectedDuration => _selectedDuration;
  String? get selectedCategory => _selectedCategory;
  String? get selectedDifficulty => _selectedDifficulty;
  String? get selectedImagePath => _selectedImagePath;

  List<String> get foodCategoriesList => _foodCategoriesList;

  List<String> get recipeDifficultyList => _recipeDifficultyList;

  List<String?> get numberOfServingsList => _numberOfServingsList;

  List<String>? get ingredientsList => _ingredientsList;

  List<String>? get stepsList => _stepsList;

  TextEditingController textEditingControllerTitle = TextEditingController();

  TextEditingController textEditingControllerDurationHours =
      TextEditingController();
  TextEditingController textEditingControllerDurationMinutes =
      TextEditingController();
  TextEditingController textEditingControllerImagePicker =
      TextEditingController();

  TextEditingController textEditingControllerAddIngredientTextField =
      new TextEditingController();

  TextEditingController textEditingControllerAddStepTextField =
      new TextEditingController();

  RecipeFormProvider() {
    _selectedCategory = _foodCategoriesList.first;
    _selectedDifficulty = _recipeDifficultyList.first;
    _selectedDuration = "0:00'";
    _selectedServings = _numberOfServingsList.first;
    _selectedImagePath = placeHolderImage;

    _ingredientsList = <String>[];
    _stepsList = <String>[];

    textEditingControllerImagePicker.text = _selectedImagePath!;
  }

  // end

  bool isBlankString(String value) {
    return (value.trim().isEmpty);
  }

  bool isFormValid() {
    return !isBlankString(textEditingControllerTitle.text) &&
        ingredientsList!.isNotEmpty &&
        stepsList!.isNotEmpty;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void clearFields() {
    _ingredientsList!.clear(); // Empty ingredient array
    _stepsList!.clear(); // Empty steps array
    _selectedCategory = _foodCategoriesList.first;
    _selectedDifficulty = _recipeDifficultyList.first;
    _selectedDuration = "0:00'";
    _selectedServings = _numberOfServingsList.first;
    _selectedImagePath = placeHolderImage;
    textEditingControllerImagePicker.text = _selectedImagePath!;

    textEditingControllerTitle.clear();
    textEditingControllerAddIngredientTextField.clear();

    textEditingControllerAddStepTextField.clear();

    tempRecipeModel = null;
    _isEditingIngredient = false;
    _editingIngredientIndex = -1;
    _isEditingRecipe = false;
    _isEditingStep = false;
    _editingStepIndex = -1;
  }

  void saveForm(BuildContext context) async {
    if (_isEditingRecipe == false) {
      tempRecipeModel = new RecipeModel();
      tempRecipeModel!.id = null;
      tempRecipeModel!.favourite = false;
      tempRecipeModel!.ingredients = <String>[];
      tempRecipeModel!.steps = <String>[];
    }

    tempRecipeModel!.name = textEditingControllerTitle.text;
    switch (numberOfServingsList.indexOf(selectedServings)) {
      case 0:
        tempRecipeModel!.servings = 1;
        break;
      case 1:
        tempRecipeModel!.servings = 2;
        break;
      case 2:
        tempRecipeModel!.servings = 4;
        break;
      case 3:
        tempRecipeModel!.servings = 6;
        break;
      case 4:
        tempRecipeModel!.servings = 8;
        break;
      case 5:
        tempRecipeModel!.servings = 10;
        break;
      case 6:
        tempRecipeModel!.servings = 12;
        break;
    }

    tempRecipeModel!.category = selectedCategory;
    tempRecipeModel!.difficulty = selectedDifficulty;
    tempRecipeModel!.imageFile = selectedImagePath;
    tempRecipeModel!.duration = selectedDuration;

    tempRecipeModel!.ingredients = <String>[];

    for (String item in _ingredientsList!) {
      tempRecipeModel!.ingredients!.add(item);
    }

    tempRecipeModel!.steps = <String>[];

    for (String item in _stepsList!) {
      tempRecipeModel!.steps!.add(item);
    }

    //tempRecipeModel.steps = _stepsList;

    if (_isEditingRecipe) {
      await Provider.of<RecipeProvider>(context, listen: false)
          .updateRecipe(tempRecipeModel!);
      isEditingRecipe = false;
    } else {
      await Provider.of<RecipeProvider>(context, listen: false)
          .addRecipe(tempRecipeModel!);
    }
  }
}
