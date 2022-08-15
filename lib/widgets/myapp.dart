import 'package:flutter/material.dart';
import 'package:kukbuk/blocs/settings_provider.dart';

import 'package:provider/provider.dart';
import '../screens/rootpage.dart';

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kukbuk :: A free cookbook app',
      theme: Provider.of<SettingsProvider>(context).selectedTheme,
      home: RootPage(),
    );
  }
}
