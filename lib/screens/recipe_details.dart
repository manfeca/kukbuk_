import 'package:flutter/material.dart';
import 'package:kukbuk/blocs/settings_provider.dart';
import 'package:kukbuk/kukbukAppTheme.dart';
import 'package:kukbuk/resources/utility.dart';
import '../blocs/homepage_provider.dart';
import '../blocs/recipe_details_provider.dart';
import '../blocs/recipe_form_provider.dart';
import '../blocs/recipe_provider.dart';
import '../blocs/shoppinglist_provider.dart';
import '../models/recipe_model.dart';
import '../screens/recipe_form_new.dart';
import '../widgets/carousel.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/custom_chip.dart';
import 'package:provider/provider.dart';

enum MenuSelection { edit, delete }

class RecipeDetails extends StatelessWidget {
  final RecipeModel recipeModel;

  RecipeDetails({required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    final recipeProviderBloc = Provider.of<RecipeProvider>(context);
    final homePageProvider = Provider.of<HomePageProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Consumer<RecipeDetailsProvider>(
          builder: (context, value, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: Theme.of(context).primaryColor,
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                primaryColor: KukbukAppTheme.white,
                textTheme: Theme.of(context).textTheme.copyWith(
                      caption: new TextStyle(
                        color: KukbukAppTheme.white,
                      ),
                    ),
              ), // sets the,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: KukbukAppTheme.white,
                selectedItemColor: KukbukAppTheme.lightGrey,
                showUnselectedLabels: true,
                currentIndex: value.navigationBarcurrentIndex,
                onTap: (valor) {
                  if (valor == 1) {
                    value.stepsPosition = 0;
                  }
                  value.navigationBarcurrentIndex = valor;
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.fastfood_outlined,
                      semanticLabel: "Ingredients",
                    ),
                    label: "Ingredients",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.view_list_outlined,
                      semanticLabel: "Preparation",
                    ),
                    label: "Preparation",
                  ),
                ],
              ),
            );
          },
        ),
        body: NestedScrollView(
          // Setting floatHeaderSlivers to true is required in order to float
          // the outer slivers over the inner scrollable.
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              /*    SliverPersistentHeader(
                delegate: CustomSliverAppBar(
                    recipeModel: recipeModel, expandedHeight: 300.0),
                pinned: true,
              ), */
              SliverAppBar(
                title: Text("Recipe details"),
                expandedHeight: MediaQuery.of(context).size.height * 0.4,

                // title: const Text('Recipe details'),

                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    if (homePageProvider.getShowFavorites == true) {
                      recipeProviderBloc.updateStreamWithFavourites();
                    }

                    Navigator.pop(context);
                  },
                ),
                floating: true,
                stretch: true,
                pinned: true,
                // expandedHeight: MediaQuery.of(context).size.height * 0.3,
                flexibleSpace: FlexibleSpaceBar(
                  background: CustomAppBarWidget(recipeModel: recipeModel),
                ),

                //RecipeCard(recipeModel: recipeModel),

                forceElevated: innerBoxIsScrolled,
                actions: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: recipeModel.favourite == true
                          ? Icon(
                              Icons.favorite,
                            )
                          : Icon(
                              Icons.favorite_outline,
                            ),
                      onPressed: () {
                        if (recipeModel.favourite == true) {
                          recipeModel.favourite = false;
                          recipeProviderBloc.updateRecipe(recipeModel);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              //  behavior: SnackBarBehavior.floating,
                              duration: Duration(
                                seconds: 2,
                              ),
                              content: Text(
                                "Deleted from favorites",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else {
                          recipeModel.favourite = true;
                          recipeProviderBloc.updateRecipe(recipeModel);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              //  behavior: SnackBarBehavior.floating,
                              duration: Duration(
                                milliseconds: 1000,
                              ),
                              content: Text(
                                "Added to favorites",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    onSelected: (dynamic value) {
                      if (value == MenuSelection.edit) {
                        Provider.of<RecipeFormProvider>(context, listen: false)
                            .editRecipe(recipeModel);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeForm(),
                          ),
                        );
                      } else if (value == MenuSelection.delete) {
                        // Implement deleted
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                  "Delete recipe?",
                                  textAlign: TextAlign.left,
                                ),
                                actions: [
                                  TextButton(
                                    child: Text("CANCEL"),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  TextButton(
                                    child: Text("DELETE"),
                                    onPressed: () {
                                      Provider.of<RecipeProvider>(
                                        context,
                                        listen: false,
                                      ).deleteRecipe(recipeModel);

                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    itemBuilder: (context) => <PopupMenuEntry<MenuSelection>>[
                      PopupMenuItem(
                        value: MenuSelection.edit,
                        child: ListTile(
                          leading: Icon(
                            Icons.edit,
                          ),
                          title: Text("Edit"),
                        ),
                      ),
                      PopupMenuItem(
                        value: MenuSelection.delete,
                        child: ListTile(
                          leading: Icon(
                            Icons.delete,
                          ),
                          title: Text("Delete"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ];
          },

          body: Center(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: settingsProvider.themeMode == true
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomChip(
                        category: recipeModel.category,
                        icon: Icons.list,
                        backgroundColor: settingsProvider.themeMode == true
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
                        mainColor: settingsProvider.themeMode == true
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                      CustomChip(
                        category: recipeModel.difficulty,
                        icon: Icons.signal_cellular_4_bar_outlined,
                        backgroundColor: settingsProvider.themeMode == true
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
                        mainColor: settingsProvider.themeMode == true
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                      CustomChip(
                        category: recipeModel.duration,
                        icon: Icons.timer,
                        backgroundColor: settingsProvider.themeMode == true
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
                        mainColor: settingsProvider.themeMode == true
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                      CustomChip(
                        category: "${recipeModel.servings}",
                        icon: Icons.people,
                        backgroundColor: settingsProvider.themeMode == true
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
                        mainColor: settingsProvider.themeMode == true
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  //       color: Colors.white,
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                    top: 16.0,
                    bottom: 16.0,
                  ),
                  child: Provider.of<RecipeDetailsProvider>(context)
                              .navigationBarcurrentIndex ==
                          0
                      ? null
                      /* Text(
                          "Ingredients",
                          style: TextStyle(
                            // Heading
                            // color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            fontStyle: FontStyle.normal,
                          ),
                        ) */
                      : Carousel(
                          carouselSize: recipeModel.steps!.length,
                          position: Provider.of<RecipeDetailsProvider>(context)
                              .stepsPosition,
                        ),

                  /*    Text(
                          "Preparation",
                          style: TextStyle(
                            // Heading
                            // color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            fontStyle: FontStyle.normal,
                          ),), */
                ),
                Expanded(
                    child: Container(

                        // ),
                        width: MediaQuery.of(context).size.width,
                        // padding: EdgeInsets.all(8.0),
                        child: buildListView(context))),
              ],
            ),
          ),
        ),
      ),
    );
    //);
  }

  Widget buildListView(context) {
    final bloc = Provider.of<ShoppingListProvider>(context);
    return Consumer<RecipeDetailsProvider>(
      // ignore: missing_return
      builder: (context, value, child) {
        return value.navigationBarcurrentIndex == 0
            ? buildContainerIngredientList(bloc)
            : buildPageViewStepsList(value);
      },
    );
  }

  PageView buildPageViewStepsList(RecipeDetailsProvider value) {
    return PageView.builder(
      onPageChanged: (index) => value.stepsPosition = index,
      itemCount: recipeModel.steps!.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, indice) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 1500),
          curve: Curves.bounceIn,
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          margin: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            // bottom: 16.0,
          ),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Step ${indice + 1}",
                style: KukbukAppTheme.recipeDetailStepHeading.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              Divider(
                thickness: 2.0,
                indent: 40.0,
                endIndent: 40.0,
                height: 8.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Padding(padding: EdgeInsets.all(4.0)),
              // A listView has prevented the overflow of the application with long text form recipe
              Expanded(
                child: Container(
                  child: ListView(
                    children: [
                      recipeModel.steps != null
                          ? Text(
                              recipeModel.steps![indice],
                              style: KukbukAppTheme.bodyTextStyle2,
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              "You haven't added any step yet",
                              textAlign: TextAlign.center,
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container buildContainerIngredientList(ShoppingListProvider bloc) {
    return Container(
      //    margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: ListView.builder(
          itemCount: recipeModel.ingredients!.length,
          itemBuilder: (context, index) {
            return ListTile(
              isThreeLine: false,
              leading: Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: recipeModel.ingredients != null
                  ? Text(
                      recipeModel.ingredients![index],
                      textAlign: TextAlign.start,
                      style: KukbukAppTheme.bodyTextStyle2,
                    )
                  : Text(
                      "You haven't added any ingredient yet",
                      textAlign: TextAlign.center,
                    ),
              trailing: IconButton(
                icon: Icon(
                  Icons.add_shopping_cart_outlined,
                  color: Colors.green,
                ),
                onPressed: () {
                  bloc.addIngredientToShoppingList(
                      Utility.firstToUpper(recipeModel.ingredients![index]));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Added ${recipeModel.ingredients![index]} to shopping list"),
                    duration: Duration(milliseconds: 500),
                  ));
                },
              ),
            );
          }),
    );
  } // end function

  // end else

}
