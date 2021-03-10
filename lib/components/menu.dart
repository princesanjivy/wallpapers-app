import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
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
        TextButton(
          child: Text("Wallpapers"),
          onPressed: () {
            hiddenDrawerController.setSelectedMenuPosition(0);
          },
        ),
        TextButton(
          child: Text("Rate & Review"),
          onPressed: () {
            hiddenDrawerController.setSelectedMenuPosition(1);
          },
        ),
        TextButton(
          child: Text("Credits"),
          onPressed: () {
            hiddenDrawerController.setSelectedMenuPosition(2);
          },
        ),
        // TextButton(
        //   child: Text("About"),
        //   onPressed: () {},
        // ),
      ],
    );
  }
}
