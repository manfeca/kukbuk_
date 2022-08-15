import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kukbuk/models/note_model.dart';
import 'package:kukbuk/resources/repository.dart';

class NotesProvider extends ChangeNotifier {
  RecipeDbProvider recipeDBProvider = recipeDbProvider;

  List<NoteModel>? _notesList;

  List<NoteModel>? get notesList => _notesList;

  StreamController<List<NoteModel>?> _streamController =
      new StreamController<List<NoteModel>?>.broadcast();

  Stream<List<NoteModel>?> get notesListStream => _streamController.stream;

  _init() async {
    _notesList = await recipeDbProvider.fetchListOfNotes();

    _streamController.sink.add(_notesList);
  }

  updateNotesList() async {
    _notesList = await recipeDbProvider.fetchListOfNotes();
    _streamController.sink.add(_notesList);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  TextEditingController? textEditingControllerNewNote;
  TextEditingController? textEditingControllerTitleOfNote;

  NotesProvider() {
    _init();

    textEditingControllerNewNote = new TextEditingController();
    textEditingControllerTitleOfNote = new TextEditingController();
  }

  clearTextFieldsContent() {
    textEditingControllerNewNote!.clear();
    textEditingControllerTitleOfNote!.clear();
  }

  Future<void> saveNote(NoteModel? noteModel) async {
    if (noteModel == null) {
      noteModel = new NoteModel(null, textEditingControllerTitleOfNote!.text,
          textEditingControllerNewNote!.text, false);

      return await recipeDBProvider.insertNote(noteModel);
    } else {
      noteModel.content = textEditingControllerNewNote!.text;
      noteModel.title = textEditingControllerTitleOfNote!.text;

      return await recipeDBProvider.updateNote(noteModel);
    }
  }

  Future<void> deleteNote(NoteModel? noteModel) async {
    await recipeDBProvider.deleteNote(noteModel!.id);
    updateNotesList();
    notifyListeners();
  }
}
