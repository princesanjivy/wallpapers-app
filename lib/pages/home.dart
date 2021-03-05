import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SimpleHiddenDrawer(
        contentCornerRadius: 30,
        slidePercent: 60,
        menu: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text("Settings"),
              onPressed: () {},
            ),
            TextButton(
              child: Text("Rate & Review"),
              onPressed: () {},
            ),
            TextButton(
              child: Text("Credits"),
              onPressed: () {},
            ),
            TextButton(
              child: Text("About"),
              onPressed: () {},
            ),
          ],
        ),
        screenSelectedBuilder: (position, controller) {
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                child: Icon(
                  Icons.menu,
                  color: Colors.blue,
                ),
                onTap: () {
                  controller.toggle();
                },
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
      ),
    );
  }
}
