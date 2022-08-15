import 'package:flutter/material.dart';
import 'package:kukbuk/blocs/notes_provider.dart';
import 'package:kukbuk/models/note_model.dart';
import 'package:provider/provider.dart';

class NoteSheet extends StatelessWidget {
  final NoteModel? noteModel;

  NoteSheet(this.noteModel);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              /*     await Provider.of<NotesProvider>(context, listen: false)
                  .updateNotesList(); */
              Provider.of<NotesProvider>(context, listen: false)
                  .clearTextFieldsContent();
              Navigator.pop(context);
              // Update stream of notes
            },
          ),
          title: Text("Create a note"),
          actions: [
            TextButton(
              child: Text(
                "SAVE",
                style: TextStyle(color: Colors.white),
              ),
              // RECORD note in database

              onPressed: () async {
                await Provider.of<NotesProvider>(context, listen: false)
                    .saveNote(noteModel);
                await Provider.of<NotesProvider>(context, listen: false)
                    .updateNotesList();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Consumer<NotesProvider>(
            builder: (context, bloc, child) {
              return Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(
                      top: 4.0,
                      right: 16.0,
                      left: 16.0,
                    ),
                    child: TextField(
                      controller: bloc.textEditingControllerTitleOfNote,

                      textDirection: TextDirection.ltr,
                      autocorrect: false,
                      autofocus: false,
                      expands: false,
                      minLines: 1,
                      maxLines: 1,
                      //   maxLength: 60,
                      cursorWidth: 2.0,
                      enableInteractiveSelection: true,
                      enabled: true,
                      textAlign: TextAlign.justify,
                      decoration: InputDecoration(
                        hintText: "Enter title",
                      ),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
                    child: TextField(
                      // CONTROLLER
                      controller: bloc.textEditingControllerNewNote,

                      textDirection: TextDirection.ltr,
                      autocorrect: false,
                      autofocus: true,
                      expands: false,
                      maxLines: null,
                      cursorWidth: 2.0,

                      enableInteractiveSelection: true,
                      enabled: true,
                      textAlign: TextAlign.left,

                      decoration: InputDecoration(
                        hintText: "Enter text",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      //STYLE
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
