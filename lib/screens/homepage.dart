import 'package:flutter/material.dart';
import 'package:kukbuk/widgets/drawer.dart';
import '../blocs/homepage_provider.dart';
import '../blocs/recipe_details_provider.dart';
import '../blocs/recipe_provider.dart';
import '../models/recipe_model.dart';
import '../screens/recipe_details.dart';
import '../widgets/recipe_card.dart';
import 'package:provider/provider.dart';
import 'package:kukbuk/kukbukAppTheme.dart';

import '../screens/recipe_form_new.dart';

enum MenuSelection { favorites, full_list }

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    var bloc = Provider.of<HomePageProvider>(context);

    return SafeArea(
      child: Scaffold(
        // ==========
        //    FAB
        // ==========
        floatingActionButton: FloatingActionButton(
          //   backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Icon(
            Icons.add,
            size: 28.0,
            semanticLabel: "Add ingredient",
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeForm(),
              ),
            );
          },
        ),
        drawer: MyAppDrawer(),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                // If is Favourite screen show the correct title
                /*    title: Text(
                  "kukbuk",
                ),
 */
                title: bloc.isSearchButtonPressed == true
                    ? TextField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle:
                              TextStyle(color: KukbukAppTheme.nearlyWhite),
                          prefixIcon: Icon(
                            Icons.search,
                            color: KukbukAppTheme.white,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: KukbukAppTheme.lightGrey,
                            ),
                            onPressed: () {
                              bloc.isSearchButtonPressed = false;
                              /*   Provider.of<RecipeProvider>(context,
                                      listen: false)
                                  .updateStream(); */
                            },
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        onSubmitted: (value) async {
                          print("Value of search text field: $value");
                          Provider.of<RecipeProvider>(context, listen: false)
                              .searchInListOfRecipes(value);

                          ScaffoldMessenger.of(context)
                              .showSnackBar(new SnackBar(
                            content: Text(
                                "Your search returned  ${Provider.of<RecipeProvider>(context, listen: false).searchResult.length} results"),
                            duration: Duration(seconds: 4),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(top: 16.0),
                          ));
                        },
                      )
                    : Text("kukbuk"),

                forceElevated: innerBoxIsScrolled,
                floating: true,
                stretch: false,

                actions: [
                  if (!bloc.isSearchButtonPressed)
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        bloc.isSearchButtonPressed = true;
                      },
                    ),
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    onSelected: (dynamic value) {
                      if (value == MenuSelection.favorites) {
                        Provider.of<RecipeProvider>(context, listen: false)
                            .updateStreamWithFavourites();
                      } else if (value == MenuSelection.full_list) {
                        // Implement deleted
                        Provider.of<RecipeProvider>(context, listen: false)
                            .updateStream();
                      }
                    },
                    itemBuilder: (context) => <PopupMenuEntry<MenuSelection>>[
                      PopupMenuItem(
                        value: MenuSelection.favorites,
                        child: ListTile(
                          leading: Icon(
                            Icons.favorite,
                          ),
                          title: Text("Show favorites"),
                        ),
                      ),
                      PopupMenuItem(
                        value: MenuSelection.full_list,
                        child: ListTile(
                          leading: Icon(
                            Icons.list,
                          ),
                          title: Text("Show all recipes"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ];
          },
          body: Container(
            width: MediaQuery.of(context).size.width,
            // Build the list of recipes
            child: _buildList(context, bloc),
          ),
        ),
      ),
    );
  }

  Widget _buildList(context, HomePageProvider bloc) {
    return Consumer<RecipeProvider>(
      builder: (context, value, child) {
        return StreamBuilder(
            initialData: value.recipes,
            stream: value.recipesListStream,
            builder: (context, AsyncSnapshot<List<RecipeModel>?> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(
                    child: Text(
                      "Your recipes list is empty.",
                      textAlign: TextAlign.center,
                      style: KukbukAppTheme.bodyTextStyle2,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Provider.of<RecipeDetailsProvider>(context, listen: false)
                          .navigationBarcurrentIndex = 0;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetails(recipeModel: snapshot.data![index]),
                        ),
                      );
                    },
                    splashColor: Colors.orange[300],
                    child: RecipeCard(recipeModel: snapshot.data![index]),
                  );
                },
              );
            });
      },
    );
  }
} // end class
