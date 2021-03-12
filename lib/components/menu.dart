import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpapers/components/my_spacer.dart';

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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        VerticalSpacer(50),
        Padding(
          padding: EdgeInsets.all(12),
          child: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.contain,
            width: 120,
            height: 120,
          ),
        ),
        Center(
          widthFactor: 1,
          heightFactor: 1.5,
          child: Column(
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
                  onPressed: () async {
                    if (i != 2) {
                      hiddenDrawerController.setSelectedMenuPosition(i);
                    } else {
                      await launch(
                        "https://play.google.com/store/apps/dev?id=6439925551269057866",
                      );
                      hiddenDrawerController.close();
                    }
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
