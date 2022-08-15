import 'package:flutter/material.dart';
import 'package:kukbuk/kukbukAppTheme.dart';
import 'package:kukbuk/resources/utility.dart';
import 'package:kukbuk/widgets/drawer.dart';
import '../blocs/shoppinglist_provider.dart';
import '../models/ingredient_text_model.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ShoppingList extends StatefulWidget {
  //String? ingredient;

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  String? ingredient;
  /*BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitOne,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState.adListener,
        )..load();
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ShoppingListProvider>(context);

    return SafeArea(
      child: Scaffold(
        // ====================================
        // FAB: ADD AN ITEM TO THE SHOPPIN LIST
        // ====================================

        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            semanticLabel: "Add item",
            size: 28.0,
          ),

          // ==================================================
          // Show a dialog with a textfield to enter ingredient
          // ==================================================

          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: Text(
                    "Add item to shopping list",
                    //   style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  children: [
                    Container(
                      margin: EdgeInsets.all(16.0),
                      child: TextField(
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        controller: bloc.textController,
                        onSubmitted: (value) async {
                          // Check for empty or null string
                          if (Utility.isBlankString(value) == false) {
                            await bloc.addIngredientToShoppingList(
                                Utility.firstToUpper(ingredient!));
                            bloc.textController.clear();

                            Navigator.pop(context);
                          } //
                        },
                        onChanged: (value) {
                          ingredient = value;
                        },
                      ),
                    ),
                    ButtonBar(
                      children: [
                        TextButton(
                          child: Text("CANCEL"),
                          onPressed: () {
                            bloc.textController.clear();
                            ingredient = null;
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text("ADD"),
                          onPressed: () async {
                            if (Utility.isBlankString(ingredient) == false) {
                              await bloc.addIngredientToShoppingList(
                                  Utility.firstToUpper(ingredient!));
                              bloc.textController.clear();
                              ingredient = null;
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        ),
        drawer: MyAppDrawer(),

        // ============================================
        // Show the shopping list in a listview in body
        // ============================================
        appBar: AppBar(
          title: Text("Shopping list"),
          //  expandedHeight: MediaQuery.of(context).size.height * 0.2,

          actions: [
            IconButton(
              icon: Icon(
                Icons.delete,
              ),
              onPressed: () {
                bloc.shoppingList!.forEach((IngredientTextModel e) async {
                  if (e.strikethroughtext == true) {
                    await bloc.deleteIngredient(e.id);
                    print("Items deleted");
                  }
                });
              },
            ),
          ],
        ),

        body: Column(
          children: [
            /*   if (banner == null)
              SizedBox(
                height: 50,
              )
            else
              Container(
                height: 50,
                margin: EdgeInsets.only(
                  top: 4.0,
                  bottom: 4.0,
                ),
                child: AdWidget(ad: banner!),
              ),*/
            Expanded(
              child: Container(
                child: Consumer<ShoppingListProvider>(
                  builder: (context, value, child) {
                    // bloc.updateShoppingList();
                    return StreamBuilder<List<IngredientTextModel>?>(
                        initialData: value.shoppingList,
                        stream: value.shoppingListStream,
                        builder: (context,
                            AsyncSnapshot<List<IngredientTextModel>?>
                                snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: Text(
                                "Your shopping list is empty.",
                                textAlign: TextAlign.center,
                                style: KukbukAppTheme.bodyTextStyle2,
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Card(
                                    elevation: 4.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: CheckboxListTile(
                                        secondary: Icon(
                                          Icons.check,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                        value: snapshot.data!
                                            .elementAt(index)
                                            .strikethroughtext,
                                        onChanged: (value) {
                                          bloc.updateIngredient(
                                            IngredientTextModel(
                                              id: snapshot.data!
                                                  .elementAt(index)
                                                  .id,
                                              name: snapshot.data!
                                                  .elementAt(index)
                                                  .name,
                                              strikethroughtext: value == true
                                                  ? snapshot.data!
                                                      .elementAt(index)
                                                      .strikethroughtext = true
                                                  : snapshot.data!
                                                          .elementAt(index)
                                                          .strikethroughtext =
                                                      false,
                                            ),
                                          );
                                        },
                                        title: Text(
                                          "${snapshot.data!.elementAt(index).name}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 20.0,
                                            color: snapshot.data!
                                                        .elementAt(index)
                                                        .strikethroughtext ==
                                                    true
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                : null,
                                            decoration: snapshot.data!
                                                        .elementAt(index)
                                                        .strikethroughtext ==
                                                    true
                                                ? TextDecoration.lineThrough
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  /*     Divider(
                                      color: Colors.grey,
                                      //  thickness: 1.0,
                                    ), */
                                ],
                              );
                            },
                          );
                        });
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
