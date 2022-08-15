import 'package:flutter/material.dart';
import 'package:kukbuk/blocs/settings_provider.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class MyAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 6.0,
      child: ListView(
        children: [
          DrawerHeader(
            curve: Curves.decelerate,
            duration: Duration(milliseconds: 2000),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/ic_launcher.png",
                ),
                Text(
                  "kukbuk",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "A free cookbook app",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(
              Mdi.themeLightDark,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text("Dark theme"),
            trailing: Switch(
              value: Provider.of<SettingsProvider>(context).themeMode,
              activeColor: Colors.green,
              onChanged: (value) async {
                await Provider.of<SettingsProvider>(context, listen: false)
                    .setDarkModeSetting(value);
              },
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text("Share this app"),
            onTap: () {
              Share.share(
                  'Hey, check this app at https://play.google.com/store/apps/details?id=com.manfeca.kukbuk');
            },
          ),
        ],
      ),
    );
  }
}
