import 'package:flutter/material.dart';
import 'blocs/settings_provider.dart';
import 'blocs/volume_unit_converter_provider.dart';
import 'blocs/gas_mark_provider.dart';
import 'blocs/mass_unit_converter_provider.dart';
import 'blocs/notes_provider.dart';
import 'blocs/recipe_details_provider.dart';
import 'blocs/recipe_provider.dart';
import 'widgets/myapp.dart';
import 'package:provider/provider.dart';

import 'blocs/homepage_provider.dart';
import 'blocs/recipe_form_provider.dart';
import 'blocs/shoppinglist_provider.dart';

void main() {
 // WidgetsFlutterBinding.ensureInitialized();
 // final initFuture = MobileAds.instance.initialize();
 // final adState = AdState(initFuture);

  runApp(
    MultiProvider(
      providers: [
   //     Provider.value(value: adState),
        ChangeNotifierProvider(
          create: (_) => RecipeDetailsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RecipeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ShoppingListProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RecipeFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => VolumeUnitConverterProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MassUnitConverterProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GasMarkProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}
