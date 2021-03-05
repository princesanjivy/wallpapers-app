import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SimpleHiddenDrawer(
      contentCornerRadius: 30,
      slidePercent: 65,
      menu: ElevatedButton(
        child: Text("Settings"),
        onPressed: () {
          SimpleHiddenDrawerController controller;
          controller.setSelectedMenuPosition(0);
        },
      ),
      screenSelectedBuilder: (position, controller) {
        return Scaffold(
          appBar: AppBar(
            leading: Icon(
              Icons.menu,
              color: Colors.blue,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: PageView(
            controller: PageController(),
            children: [
              Center(
                child: Text("Hello"),
              ),
              Center(
                child: Text("Hello"),
              ),
              Center(
                child: Text("Hello"),
              ),
            ],
          ),
        );
      },
    );
  }
}
