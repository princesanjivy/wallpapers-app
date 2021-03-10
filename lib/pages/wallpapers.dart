import 'package:flutter/material.dart';
import 'package:wallpapers/components/image_preview.dart';

class WallpapersPage extends StatelessWidget {
  final List images;

  WallpapersPage({
    this.images,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
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
    );
  }
}
