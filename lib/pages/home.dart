import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:wallpapers/components/image_preview.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showHeart;
  // AnimationController animationController;

  List images = [
    "https://i.ibb.co/WVf4KHN/IMG-20210306-223230-520.jpg",
    "https://i.ibb.co/ZKGFx26/IMG-20210306-223253-574.jpg",
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
            body: PageView.builder(
              controller: PageController(),
              pageSnapping: true,
              itemCount: images.length,
              itemBuilder: (context, index) {
                // return GestureDetector(
                //   child: Image.network(
                //     images[index],
                //     fit: BoxFit.cover,
                //   ),
                //   onDoubleTap: () {
                //     setState(() {
                //       showHeart = true;
                //     });
                //   },
                // );
                return ImagePreview(
                  // showHeart: showHeart,
                  imageUrl: images[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
