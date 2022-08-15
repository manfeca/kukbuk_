import 'dart:async';
import 'package:kukbuk/models/note_model.dart';

import '../models/ingredient_text_model.dart';
import '../models/recipe_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final RecipeDbProvider recipeDbProvider = RecipeDbProvider();

class RecipeDbProvider {
  int counter = 0;
  int cingredients = 0;

  Future<Database>? database;

  RecipeDbProvider();

  Future<void> createDatabase() async {
    print("CREATING DATABASE.....");
    database = openDatabase(
      join(await (getDatabasesPath() as FutureOr<String>), 'mycookbook.db'),
      onCreate: _onCreate,
      version: 1,
    );
    print("Done.");

  }

  _onCreate(Database database, int version) async {
    await database.execute("""
      CREATE TABLE Recipes
      (
        id INTEGER PRIMARY KEY,
        name TEXT,
        difficulty TEXT, 
        duration INTEGER,
        servings INTEGER,
        category TEXT,
        ingredients BLOB,
        steps BLOB,
        imageFile TEXT,
        favourite TEXT
      )
    """);
    await database.execute("""
      CREATE TABLE Ingredients
      (
        
       id INTEGER PRIMARY KEY,
         name TEXT NOT NULL,
         strikethroughtext TEXT
     
      )
    """);

    await database.execute("""
      CREATE TABLE Notes
      (
        
       id INTEGER PRIMARY KEY,
         title TEXT,
         content TEXT,
         selected TEXT
      )
    """);
  }

  // Future<void> createDatabaseIngredients() async {
  //   print("CREATING DATABASE 2.....");
  //   database = openDatabase(
  //     join(await getDatabasesPath(), 'mycookbook.db'),
  //     onCreate: (db, version) {
  //       return db.execute("""
  //     CREATE TABLE Ingredients
  //     (

  //      id INTEGER PRIMARY KEY,
  //        name TEXT,
  //        strikethroughtext INTEGER

  //     )
  //   """);
  //     },
  //     version: 1,
  //   );
  //   print("Done.");
  // }

  // createTableIngredients() async {
  //   final Database db = await database;
  //   db.execute("""
  //       CREATE TABLE Ingredients(
  //       id INTEGER PRIMARY KEY,
  //       name TEXT,
  //       strikethroughtext INTEGER
  //     )
  //    """);
  // }

  Future<void> insertRecipe(RecipeModel recipeModel) async {
    final Database db = await database!;
    db.insert(
      "Recipes",
      recipeModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Inserted $recipeModel");
  }

  Future<void> insertIngredient(IngredientTextModel ingredientTextModel) async {
    final Database db = await database!;
    db.insert(
      "Ingredients",
      ingredientTextModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Inserted ingredient: ${ingredientTextModel.name}");
  }

  Future<void> insertNote(NoteModel noteModel) async {
    final Database db = await database!;
    db.insert(
      "Notes",
      noteModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Inserted a new note: $noteModel");
  }

  Future<void> updateNote(NoteModel noteModel) async {
    final db = await database!;
    await db.update(
      "Notes",
      noteModel.toMap(),
      where: "id = ?",
      whereArgs: [noteModel.id],
    );
    print("Updated a new note: ${noteModel.content}");
  }

  Future<void> deleteNote(int? id) async {
    final db = await database!;
    await db.delete(
      'Notes',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<NoteModel>?> fetchListOfNotes() async {
    final db = await database!;
    final List<Map<String, dynamic>> maps = await db.query('Notes');
    if (maps.length == 0) {
      return null;
    } else {
      return List.generate(maps.length, (i) {
        print(NoteModel.fromDb(maps[i]));
        return NoteModel.fromDb(maps[i]);
      });
    }
  }

  // Fetch recipe from db
  Future<RecipeModel?> fetchRecipe(int? id) async {
    final db = await database!;
    final maps = await db.query(
      "Recipes",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.length > 0) {
      print("Fetching: ${RecipeModel.fromDb(maps.first)}");
      return RecipeModel.fromDb(maps.first);
    } else {
      return null;
    }
  } // fetchItem

  Future<List<RecipeModel>?> fetchListOfRecipes() async {
    print("Counter: $counter");
    ++counter;
    final db = await database!;
    final List<Map<String, dynamic>> maps = await db.query('Recipes');
    if (maps.length == 0) {
      return null;
    } else {
      return List.generate(maps.length, (i) {
        print(RecipeModel.fromDb(maps[i]));
        return RecipeModel.fromDb(maps[i]);
      });
    }
  }

  Future<List<IngredientTextModel>?> fetchShoppingListIngredients() async {
    print("Counter Ingredient: $cingredients ");
    ++cingredients;
    final db = await database!;
    final List<Map<String, dynamic>> maps = await db.query("Ingredients");
    if (maps.length == 0) {
      return null;
    } else {
      return List.generate(maps.length, (i) {
        return IngredientTextModel.fromDb(maps[i]);
      });
    }
  }

  Future<void> updateIngredient(IngredientTextModel ingredientTextModel) async {
    final db = await database!;
    await db.update(
      "Ingredients",
      ingredientTextModel.toMap(),
      where: "id = ?",
      whereArgs: [ingredientTextModel.id],
    );
  }

  Future<void> updateRecipe(RecipeModel recipeModel) async {
    final db = await database!;

    await db.update(
      'Recipes',
      recipeModel.toMap(),
      where: "id = ?",
      whereArgs: [recipeModel.id],
    );
    print(":: Updated recipe :: ");
  }

  Future<void> deleteRecipe(int? id) async {
    final db = await database!;

    await db.delete(
      'Recipes',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteIngredient(int? id) async {
    final db = await database!;

    await db.delete(
      'Ingredients',
      where: "id = ?",
      whereArgs: [id],
    );
    print("Ingredient deleted");
  }
} // end class
