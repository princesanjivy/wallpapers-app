import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  bool showHeart = false;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this);
    animationController.addListener(() {
      setState(() {
        if (animationController.isCompleted) showHeart = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
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
              // elevation: 0,
              // backgroundColor: Colors.transparent,
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
                GestureDetector(
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        "https://images.unsplash.com/photo-1614886750264-afed539cf2bb?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                        fit: BoxFit.cover,
                      ),
                      showHeart
                          ? Lottie.asset(
                              "assets/lottiefiles/heart.json",
                              controller: animationController,
                              onLoaded: (composition) {
                                animationController
                                  ..duration = composition.duration
                                  ..value = composition.startFrame
                                  ..forward();
                              },
                            )
                          : Container(),
                    ],
                  ),
                  onDoubleTap: () {
                    setState(() {
                      showHeart = true;
                    });
                  },
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
          );
        },
      ),
    );
  }
}
