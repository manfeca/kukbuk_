import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:kukbuk/blocs/settings_provider.dart';
import 'package:kukbuk/resources/utility.dart';
import '../blocs/recipe_form_provider.dart';
import '../widgets/dismissible_bckg_container.dart';
import '../widgets/durationpickerdialog.dart';
import '../widgets/section_heading_text.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RecipeForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RecipeFormProvider bloc1 =
        Provider.of<RecipeFormProvider>(context, listen: false);
    var settingsProvider = Provider.of<SettingsProvider>(context);

    const edgeInsets = const EdgeInsets.only(
      left: 16.0,
      right: 16.0,
      top: 16.0,
      bottom: 16.0,
    );

    return SafeArea(
      child: Scaffold(
        // AppBar

        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              bloc1.clearFields();
              Navigator.pop(context);
            },
          ),
          title: const Text("Add a recipe"),
          actions: <Widget>[
            Builder(
              builder: (context) {
                return TextButton(
                  child: Text(
                    "SAVE",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    bool result = bloc1.isFormValid();
                    if (result) {
                      bloc1.saveForm(context);

                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Recipe saved",
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center,
                            ),
                            content: TextButton(
                              onPressed: () {
                                bloc1.clearFields();

                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //  behavior: SnackBarBehavior.,
                        duration: Duration(
                          seconds: 2,
                        ),
                        content: Text(
                          "Please, complete all the fields.",
                          textAlign: TextAlign.center,
                        ),
                      ));
                    }
                  },
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Consumer<RecipeFormProvider>(
            builder: (context, bloc, child) {
              return Column(
                children: [
                  SizedBox(
                    height: 8.0,
                  ),
                  SectionHeadingText(
                    title: "Recipe details",
                    alignment: Alignment.center,
                  ),

                  Card(
                    elevation: 4.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      /*    padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0), */
                      decoration: BoxDecoration(
                        //   color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        /*   border: Border.all(
                          color: settingsProvider.themeMode == true
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          width: 1.0,
                        ), */
                      ),
                      child: Column(
                        children: [
                          // ======================
                          // Recipe Title TextField
                          // ======================

                          Container(
                            margin: EdgeInsets.only(
                              top: 8.0,
                              left: 8.0,
                              right: 8.0,

                              // bottom: 2.0,
                            ),
                            child: TextField(
                              controller: bloc.textEditingControllerTitle,
                              autofocus: false,
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                hintText: "Enter title",
                                icon: Icon(
                                  Icons.title,
                                  //   color: Theme.of(context).colorScheme.secondary;,
                                ),
                                enabled: true,
                              ),
                              maxLength: 100,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              //    maxLines: 2,
                              enableInteractiveSelection: true,
                            ),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                            ),
                            // height: MediaQuery.of(context).size.height,
                            child: Row(
                              //  crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // CATEGORY ---
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.format_list_bulleted,
                                            /*    color:
                                                Theme.of(context).colorScheme.secondary;, */
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: DropdownButton<String>(
                                                /*   underline: Container(
                                                  height: 2,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ), */
                                                items: bloc.foodCategoriesList
                                                    .map((String category) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: category,
                                                    child: new Text(category),
                                                  );
                                                }).toList(),
                                                value: bloc.selectedCategory,
                                                icon: Icon(
                                                  Icons.arrow_drop_down,
                                                  /*  color: Theme.of(context)
                                                      .primaryColor, */
                                                ),
                                                onChanged: (String? value) {
                                                  bloc.selectedCategory = value;
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // end CATEGORY
                                    //----------------
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    // SERVINGS
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.people,
                                            /*  color:
                                                Theme.of(context).colorScheme.secondary;, */
                                          ),
                                          //                color:
                                          //                 Theme.of(context).primaryColor,

                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                          ),
                                          Container(
                                            child: DropdownButton<String>(
                                                /*    underline: Container(
                                                  height: 2,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ), */
                                                items: bloc.numberOfServingsList
                                                    .map((String? serving) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: serving,
                                                    child: new Text(serving!),
                                                  );
                                                }).toList(),
                                                value: bloc.selectedServings,
                                                icon: Icon(
                                                  Icons.arrow_drop_down,
                                                  /*   color: Theme.of(context)
                                                      .primaryColor, */
                                                ),
                                                onChanged: (String? value) {
                                                  bloc.selectedServings = value;
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // end SERVINGS
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // DIFFICULTY
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .signal_cellular_4_bar_outlined,
                                          ),
                                          //    color:
                                          //          Theme.of(context).primaryColor,

                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: DropdownButton<String>(
                                                /*      underline: Container(
                                                  height: 2,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ), */
                                                items: bloc.recipeDifficultyList
                                                    .map((
                                                  String category,
                                                ) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: category,
                                                    child: new Text(category),
                                                  );
                                                }).toList(),
                                                value: bloc.selectedDifficulty,
                                                icon: Icon(
                                                  Icons.arrow_drop_down,
                                                  /*      color: Theme.of(context)
                                                      .primaryColor, */
                                                ),
                                                onChanged: (String? value) {
                                                  bloc.selectedDifficulty =
                                                      value;
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // end DIFFICULTY
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    // TIMER
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.timer,
                                            /*   color:
                                                Theme.of(context).colorScheme.secondary;, */
                                          ),
                                          /*   color:
                                                Theme.of(context).primaryColor, */

                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: TextButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        DurationPickerWidget());
                                              },
                                              child: Container(
                                                child: Text(
                                                  bloc.selectedDuration!,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: settingsProvider
                                                                .themeMode ==
                                                            true
                                                        ? Colors.white
                                                        : Theme.of(context)
                                                            .primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),

                                    // end TIMER
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.folder_open_outlined,
                                  /*     color: Theme.of(context).colorScheme.secondary;, */
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 16.0,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: TextField(
                                      controller:
                                          bloc.textEditingControllerImagePicker,
                                      onChanged: (value) {
                                        bloc.textEditingControllerImagePicker
                                            .text = value;
                                      },
                                      readOnly: true,
                                      showCursor: false,
                                      onTap: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.image,
                                          allowMultiple: false,
                                        );
                                        if (result != null) {
                                          PlatformFile file =
                                              result.files.first;
                                          bloc.selectedImagePath = file.path;
                                          bloc.textEditingControllerImagePicker
                                              .text = file.path!;
                                          print(file.path);
                                        } else {
                                          bloc.selectedImagePath =
                                              bloc.placeHolderImage;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*     SizedBox(
                    height: 20.0,
                  ),*/
                  SectionHeadingText(
                    title: "Ingredients",
                    alignment: Alignment.center,
                  ),
                  Card(
                    elevation: 4.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: bloc.ingredientsList!.map((item) {
                              return Dismissible(
                                key: UniqueKey(),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 4.0,
                                    left: 4.0,
                                    right: 4.0,
                                    //  bottom: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                      top: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                      right: BorderSide(
                                        color: Colors.green,
                                        width: 2.0,
                                      ),
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.check,
                                      // size: 12.0,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    title: Text(
                                      item,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                direction: DismissDirection.horizontal,
                                secondaryBackground:
                                    DismissibleBackgroundContainer(
                                  backgroundType: BackgroundType.Edit,
                                ),
                                background: DismissibleBackgroundContainer(
                                  backgroundType: BackgroundType.Delete,
                                ),
                                onDismissed: (direction) {
                                  switch (direction) {
                                    case DismissDirection.startToEnd:
                                      bloc.deleteIngredient(
                                        bloc.ingredientsList!.indexOf(item),
                                      );
                                      break;
                                    case DismissDirection.endToStart:
                                      bloc.editIngredient(
                                          bloc.ingredientsList!.indexOf(item));
                                      bloc.deleteIngredient(
                                        bloc.ingredientsList!.indexOf(item),
                                      );
                                      bloc.textEditingControllerAddIngredientTextField
                                          .clear();
                                      bloc.textEditingControllerAddIngredientTextField
                                          .text = item;
                                      break;

                                    default:
                                  }

                                  print(bloc.ingredientsList);
                                },
                              );
                            }).toList(),
                          ),
                          Container(
                            margin: edgeInsets,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: TextField(
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.fastfood_outlined,
                                        ),
                                        hintText: "Add ingredient",
                                      ),
                                      keyboardType: TextInputType.text,
                                      controller: bloc
                                          .textEditingControllerAddIngredientTextField,
                                      maxLength: 80,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      onSubmitted: (value) {
                                        if (!Utility.isBlankString(value)) {
                                          bloc.addIngredient(
                                              Utility.firstToUpper(value));
                                          bloc.textEditingControllerAddIngredientTextField
                                              .clear();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                /*         IconButton(
                                  icon: Icon(
                                    Icons.add_circle_rounded,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    var value = bloc
                                        .textEditingControllerAddIngredientTextField
                                        .text;

                                    if (!Utility.isBlankString(value)) {
                                      bloc.addIngredient(
                                          Utility.firstToUpper(value));
                                      bloc.textEditingControllerAddIngredientTextField
                                          .clear();
                                    }
                                  },
                                ), */
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // =============================
                  // COOKING STEPS BLOCK
                  // =============================
                  SectionHeadingText(
                    title: "Preparation",
                    alignment: Alignment.center,
                  ),

                  Card(
                    elevation: 4.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: bloc.stepsList!.map((item) {
                              return Dismissible(
                                key: UniqueKey(),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 4.0,
                                    // bottom: 8.0,
                                    left: 4.0,
                                    right: 4.0,
                                  ),
                                  padding: EdgeInsets.only(top: 8.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                      left: BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                      right: BorderSide(
                                        color: Colors.green,
                                        width: 2.0,
                                      ),
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Step ${bloc.stepsList!.indexOf(item) + 1}",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: edgeInsets,
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                direction: DismissDirection.horizontal,
                                secondaryBackground:
                                    DismissibleBackgroundContainer(
                                  backgroundType: BackgroundType.Edit,
                                ),
                                background: DismissibleBackgroundContainer(
                                  backgroundType: BackgroundType.Delete,
                                ),
                                /*    onDismissed: (direction) {
                                  bloc.deleteStep(bloc.stepsList.indexOf(item));
                                  print(bloc.stepsList);
                                }, */
                                onDismissed: (direction) {
                                  switch (direction) {
                                    case DismissDirection.startToEnd:
                                      bloc.deleteStep(
                                        bloc.stepsList!.indexOf(item),
                                      );
                                      break;
                                    case DismissDirection.endToStart:
                                      bloc.editStep(
                                          bloc.stepsList!.indexOf(item));
                                      bloc.deleteStep(
                                        bloc.stepsList!.indexOf(item),
                                      );
                                      bloc.textEditingControllerAddStepTextField
                                          .clear();
                                      bloc.textEditingControllerAddStepTextField
                                          .text = item;
                                      break;

                                    default:
                                  }

                                  print(bloc.stepsList);
                                },
                              );
                            }).toList(),
                          ),

                          // =============
                          // STEPS TEXTFIELD
                          // =============

                          Container(
                            margin: edgeInsets,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: TextField(
                                      controller: bloc
                                          .textEditingControllerAddStepTextField,
                                      minLines: 1,
                                      maxLines: 10,
                                      maxLength: 500,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.view_list_outlined,
                                        ),
                                        hintText: "Add step",
                                      ),
                                      keyboardType: TextInputType.text,
                                      onSubmitted: (value) {
                                        if (!Utility.isBlankString(value)) {
                                          bloc.addStep(
                                              Utility.firstToUpper(value));
                                          bloc.textEditingControllerAddStepTextField
                                              .clear();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                /* IconButton(
                                  icon: Icon(
                                    Icons.add_circle_rounded,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    var value = bloc
                                        .textEditingControllerAddStepTextField
                                        .text;

                                    if (!Utility.isBlankString(value)) {
                                      bloc.addStep(value)(
                                          Utility.firstToUpper(value));
                                      bloc.textEditingControllerAddStepTextField
                                          .clear();
                                    }
                                  },
                                ), */
                              ],
                            ),
                          ),
                        ],
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
  } // end build

} // end class
