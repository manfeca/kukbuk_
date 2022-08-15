class IngredientTextModel {
  int? id;
  String? name;
  bool? strikethroughtext;

  IngredientTextModel({this.id, this.name, this.strikethroughtext});

  IngredientTextModel.fromDb(Map<String, dynamic> parseJson) {
    id = parseJson["id"];
    name = parseJson["name"];
    String val = parseJson["strikethroughtext"];
    strikethroughtext = val.toLowerCase() == 'true' ? true : false;
  }

  Map<String, dynamic> toMap() {
    String value = strikethroughtext! ? 'true' : 'false';
    return <String, dynamic>{
      "id": id,
      "name": name,
      "strikethroughtext": value,
    };
  }
} // end class
