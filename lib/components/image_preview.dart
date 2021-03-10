import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpapers/constants.dart';

class ImagePreview extends StatefulWidget {
  final String imageUrl;
  // final bool showHeart;

  ImagePreview({
    this.imageUrl,
    // this.showHeart,
  });

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview>
    with TickerProviderStateMixin {
  AnimationController animationController;
  bool showHeart;

  @override
  void initState() {
    super.initState();
    // print("hello");
    // print(widget.showHeart);

    showHeart = false;

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
    // print("INSIDE BUILD: ${widget.showHeart}");
    return GestureDetector(
      onDoubleTap: () async {
        print(widget.imageUrl);
        setState(() {
          showHeart = true;
        });

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        if (sharedPreferences.getStringList(SHARED_PREF_KEY) == null ||
            sharedPreferences.getStringList(SHARED_PREF_KEY).isEmpty) {
          await sharedPreferences
              .setStringList(SHARED_PREF_KEY, [widget.imageUrl]);
        } else {
          List<String> temp = sharedPreferences.getStringList(SHARED_PREF_KEY);
          temp.add(widget.imageUrl);

          await sharedPreferences.setStringList(SHARED_PREF_KEY, temp);
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: widget.imageUrl,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(
                value: progress.progress,
              ),
            ),
          ),
          Visibility(
            visible: showHeart,
            // visible: true,
            child: Lottie.asset(
              "assets/lottiefiles/like.json",
              controller: animationController,
              repeat: false,
              onLoaded: (composition) {
                animationController
                  ..duration = composition.duration
                  ..value = composition.startFrame
                  ..forward();
              },
            ),
          ),
        ],
      ),
    );
  }
}
