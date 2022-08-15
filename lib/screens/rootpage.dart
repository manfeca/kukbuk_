import 'package:flutter/material.dart';
import 'package:kukbuk/kukbukAppTheme.dart';
import 'package:kukbuk/screens/calculator_view.dart';
import '../blocs/homepage_provider.dart';
import '../screens/homepage.dart';
import '../screens/shopping_list.dart';
import 'package:provider/provider.dart';

import 'notes_screen.dart';

class RootPage extends StatelessWidget {
  final PageController controller = PageController(
    initialPage: 0,
    keepPage: false,
  );

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomePageProvider>(context);

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Theme(
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
          ), // sets the inactive color of the `BottomNavigationBar`

          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            //  backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: KukbukAppTheme.white,
            selectedItemColor: KukbukAppTheme.lightGrey,
            showUnselectedLabels: true,
            currentIndex: bloc.homepageNavigationBarCurrentIndex,
            onTap: (value) {
              // Set the active icon in the navigation bar
              bloc.homepageNavigationBarCurrentIndex = value;

              switch (value) {
                case 0:
                  controller.jumpToPage(value);
                  break;
                case 1:
                  controller.jumpToPage(value);

                  break;

                case 2:
                  controller.jumpToPage(value);
                  break;

                case 3:
                  controller.jumpToPage(value);
                  break;
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  semanticLabel: "Home",
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  semanticLabel: "Shopping list",
                ),
                label: "Shopping list",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.note_outlined,
                  semanticLabel: "Notes",
                ),
                label: "Notes",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calculate_outlined,
                  semanticLabel: "Tools",
                ),
                label: "Tools",
              ),
            ],
          ),
        ),
        body: PageView(
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomePage(),
            ShoppingList(),
            Notes(),
            CalculatorView(),
          ],
        ),
      ),
    );
  }
}
