import 'dart:convert';

class RecipeModel {
  int? id;
  String? name;
  String? difficulty;
  String? duration;
  int? servings;
  String? category;
  bool? favourite;

//---------------------
  List<dynamic>? ingredients;
  List<dynamic>? steps;
// ---------------------
  String? imageFile;

  RecipeModel();

  RecipeModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        name = parseJson['name'],
        difficulty = parseJson['difficulty'],
        duration = parseJson['duration'],
        servings = parseJson['servings'],
        category = parseJson["category"],
        ingredients = parseJson['ingredients'],
        steps = parseJson['steps'],
        favourite = false,
        imageFile = parseJson['imageFile'] ?? "assets/images/placeholder.jpg";

  RecipeModel.fromDb(Map<String, dynamic> parseJson) {
    id = parseJson['id'];
    name = parseJson['name'];
    difficulty = parseJson['difficulty'];
    duration = parseJson['duration'];
    servings = parseJson['servings'];
    category = parseJson["category"];
    ingredients = json.decode(parseJson['ingredients']);
    steps = json.decode(parseJson['steps']);
    String val = parseJson["favourite"];
    favourite = val.toLowerCase() == 'true' ? true : false;
    imageFile = parseJson['imageFile'] ?? " ";
  }

  Map<String, dynamic> toMap() {
    String value = favourite! ? 'true' : 'false';
    return <String, dynamic>{
      'id': id,
      'name': name,
      'difficulty': difficulty,
      'duration': duration,
      'servings': servings,
      'category': category,
      'ingredients': json.encode(ingredients),
      'steps': json.encode(steps),
      'favourite': value,
      'imageFile': imageFile,
    };
  }

  String toString() {
    return """id: [$id], name: [$name], difficulty: [$difficulty], 
    duration: [$duration], servings: [$servings], category: [$category],
    ingredients: $ingredients, steps $steps, favourite: [$favourite],
    imageFile: [$imageFile]""";
  }
}
