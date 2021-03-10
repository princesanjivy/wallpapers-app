import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpapers/components/menu.dart';
import 'package:wallpapers/pages/favorites.dart';
import 'package:wallpapers/pages/wallpapers.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showHeart;
  // AnimationController animationController;

  List images = [
    "https://images.unsplash.com/photo-1614934688741-9264558f3b56?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
    "https://images.unsplash.com/photo-1612487528552-afee375003d8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max",
    "https://images.unsplash.com/photo-1614934688741-9264558f3b56?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
  ];

  @override
  void initState() {
    super.initState();

    showHeart = false;

    // animationController = AnimationController(vsync: this);
    // animationController.addListener(() {
    //   setState(() {
    //     if (animationController.isCompleted) showHeart = false;
    //   });
    // });
  }

  @override
  void dispose() {
    super.dispose();

    // animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SimpleHiddenDrawer(
        contentCornerRadius: 30,
        slidePercent: 60,
        menu: DrawerMenu(),
        screenSelectedBuilder: (position, controller) {
          Widget body;

          switch (position) {
            case 0:
              body = WallpapersPage(images: images);
              break;
            case 1:
              body = Center(
                  child: ElevatedButton(
                child: Text("Clear Prefs"),
                onPressed: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.clear();
                },
              ));
              break;
            case 2:
              body = Favorites();
              break;
          }
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: InkWell(
                child: Icon(
                  Icons.menu,
                  color: Colors.black87,
                ),
                onTap: () {
                  controller.toggle();
                },
              ),
            ),
            body: body,
          );
        },
      ),
    );
  }
}
