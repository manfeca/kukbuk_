class NoteModel {
  int? id;
  String? title;
  String? content;
  bool? isChecked;

  NoteModel(this.id, this.title, this.content, this.isChecked);

  NoteModel.fromDb(Map<String, dynamic> parseJson) {
    id = parseJson["id"];
    title = parseJson["title"] ?? " ";
    content = parseJson["content"] ?? " ";
    String val = parseJson["selected"];
    isChecked = val.toLowerCase() == "true" ? true : false;
  }

  Map<String, dynamic> toMap() {
    String value = isChecked! ? 'true' : 'false';
    return <String, dynamic>{
      "id": id,
      "title": title,
      "content": content,
      "selected": value,
    };
  }

  String toString() {
    return """id: $id, title: $title, content: $content """;
  }
} // end c