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
              child: Image.network("Settings"),
              onPressed: () {},
            ),
            TextButton(
              child: Image.network("Rate & Review"),
              onPressed: () {},
            ),
            TextButton(
              child: Image.network("Credits"),
              onPressed: () {},
            ),
            TextButton(
              child: Image.network("About"),
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
                  child: Image.network(
                      "https://images.unsplash.com/photo-1614886750264-afed539cf2bb?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80"),
                ),
                Center(
                  child: Image.network(
                      "https://images.unsplash.com/photo-1614945083613-7763b4897841?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80"),
                ),
                Center(
                  child: Image.network(
                      "https://images.unsplash.com/photo-1614788404413-ca65466f81f8?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMnx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                print("Options");
              },
            ),
          );
        },
      ),
    );
  }
}
