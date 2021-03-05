import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

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
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: InkWell(
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onTap: () {
                  controller.toggle();
                },
              ),
            ),
            body: PageView(
              controller: PageController(),
              children: [
                Image.network(
                  "https://images.unsplash.com/photo-1614886750264-afed539cf2bb?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                  fit: BoxFit.cover,
                ),
                Image.network(
                  "https://images.unsplash.com/photo-1614945083613-7763b4897841?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                  fit: BoxFit.cover,
                ),
                Image.network(
                  "https://images.unsplash.com/photo-1614788404413-ca65466f81f8?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMnx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
                  fit: BoxFit.cover,
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.file_download,
                color: Colors.white,
              ),
              onPressed: () async {
                int location = WallpaperManager.HOME_SCREEN;
                var file = await DefaultCacheManager().getSingleFile(
                    "https://images.unsplash.com/photo-1614788404413-ca65466f81f8?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyMnx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60");

                final String result =
                    await WallpaperManager.setWallpaperFromFile(
                        file.path, location);
                print(result);
              },
            ),
          );
        },
      ),
    );
  }
}
