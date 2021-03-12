import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:wallpapers/components/image_preview.dart';

class WallpapersPage extends StatefulWidget {
  final List images;

  WallpapersPage({
    this.images,
  });

  @override
  _WallpapersPageState createState() => _WallpapersPageState();
}

class _WallpapersPageState extends State<WallpapersPage> {
  SimpleHiddenDrawerController hiddenDrawerController;

  int _pageIndex;

  @override
  void didChangeDependencies() {
    hiddenDrawerController = SimpleHiddenDrawerController.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _pageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (moveEvent) {
        if (moveEvent.delta.dx > 0) {
          // print("swipe right");
          if (_pageIndex == 0) {
            // print("show menu");
            hiddenDrawerController.open();
          }
        } else {
          // print("swipe left");
        }
      },
      child: PageView.builder(
        pageSnapping: true,
        itemCount: widget.images.length,
        onPageChanged: (pageIndex) {
          // print(pageIndex);
          _pageIndex = pageIndex;
        },
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
            imageUrl: widget.images[index],
          );
        },
      ),
    );
  }
}
