import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  List items = [
    "Wallpapers",
    "Favorites",
    "Rate & Review",
    "Settings",
    "About"
  ];

  SimpleHiddenDrawerController hiddenDrawerController;

  @override
  void didChangeDependencies() {
    hiddenDrawerController = SimpleHiddenDrawerController.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < items.length; i++)
          TextButton(
            child: Text(
              items[i],
              style: TextStyle(
                fontSize: 15.6,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              hiddenDrawerController.setSelectedMenuPosition(i);
            },
          ),
      ],
    );
  }
}
