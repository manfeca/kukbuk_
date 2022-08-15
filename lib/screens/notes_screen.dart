import 'package:flutter/material.dart';
import 'package:kukbuk/blocs/notes_provider.dart';
import 'package:kukbuk/kukbukAppTheme.dart';
import 'package:kukbuk/models/note_model.dart';
import 'package:kukbuk/widgets/dismissible_bckg_container.dart';
import 'package:kukbuk/widgets/drawer.dart';
import 'package:kukbuk/widgets/note_sheet.dart';
import 'package:provider/provider.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
/*  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitTwo,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState.adListener,
        )..load();
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notes"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<NotesProvider>(context, listen: false)
                .clearTextFieldsContent();

            // CREATE NOTE
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteSheet(null),
              ),
            );
          },
          child: Icon(
            Icons.note_add_outlined,
            size: 28.0,
            semanticLabel: "Add note",
          ),
        ),
        drawer: MyAppDrawer(),
        body: Column(
          children: [
            /*  if (banner == null)
              SizedBox(
                height: 50,
              )
            else
              Container(
                height: 50,
                child: AdWidget(ad: banner!),
                margin: EdgeInsets.only(
                  top: 4.0,
                  bottom: 4.0,
                ),
              ),*/
            Expanded(
              child: Container(
                child: Consumer<NotesProvider>(
                  builder: (context, value, child) {
                    return StreamBuilder(
                      initialData: value.notesList,
                      stream: value.notesListStream,
                      builder:
                          (context, AsyncSnapshot<List<NoteModel>?> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text(
                              "Your notes list is empty.",
                              textAlign: TextAlign.center,
                              style: KukbukAppTheme.bodyTextStyle2,
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key("${snapshot.data!.elementAt(index).id}"),
                              child: Card(
                                elevation: 4.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      width: 1.0,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.notes,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    onTap: () {
                                      NoteModel noteModel =
                                          snapshot.data!.elementAt(index);

                                      value.textEditingControllerTitleOfNote!
                                          .text = noteModel.title!;

                                      value.textEditingControllerNewNote!.text =
                                          noteModel.content!;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NoteSheet(noteModel),
                                        ),
                                      );
                                    },
                                    onLongPress: () {
                                      NoteModel noteModel =
                                          snapshot.data!.elementAt(index);
                                      noteModel.isChecked = true;
                                    },
                                    title: Text(
                                      "${snapshot.data!.elementAt(index).title}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              direction: DismissDirection.horizontal,
                              background: DismissibleBackgroundContainer(
                                backgroundType: BackgroundType.Delete,
                              ),
                              onDismissed: (direction) {
                                value.deleteNote(
                                    snapshot.data!.elementAt(index));
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
