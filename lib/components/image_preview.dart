import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:wallpapers/components/bottom_panel.dart';
import 'package:wallpapers/components/my_spacer.dart';
import 'package:wallpapers/components/my_text.dart';
import 'package:wallpapers/constants.dart';
import 'package:wallpapers/helpers/save_image.dart';

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
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  AdmobInterstitial _interstitial;

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

    _interstitial = AdmobInterstitial(
        adUnitId: "ca-app-pub-3940256099942544/10331"
            "73712");
    _interstitial.load();
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
    _interstitial.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("INSIDE BUILD: ${widget.showHeart}");
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GestureDetector(
          onDoubleTap: () async {
            print(widget.imageUrl);
            setState(() {
              showHeart = true;
            });

            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();

            if (sharedPreferences.getStringList(KEY_FAVORITES) == null ||
                sharedPreferences.getStringList(KEY_FAVORITES).isEmpty) {
              await sharedPreferences
                  .setStringList(KEY_FAVORITES, [widget.imageUrl]);
            } else {
              List<String> temp =
                  sharedPreferences.getStringList(KEY_FAVORITES);
              temp.add(widget.imageUrl);

              await sharedPreferences.setStringList(KEY_FAVORITES, temp);
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: widget.imageUrl,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContentText("Loading wallpaper"),
                    VerticalSpacer(12),
                    CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: showHeart,
                // visible: true,
                child: Lottie.asset(
                  "assets/lottiefiles/heart.json",
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
        ),
        BottomPanel(
          apply: () async {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => SimpleDialog(
                title: HeadingText("Applying wallpaper"),
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            );

            int location = WallpaperManager.HOME_SCREEN;
            var file = await DefaultCacheManager().getSingleFile(
              widget.imageUrl,
            );

            final String result = await WallpaperManager.setWallpaperFromFile(
                file.path, location);
            print(result);
            if (result == "Wallpaper set") {
              Navigator.pop(context);

              Toast.show(
                "Wallpaper applied successfully",
                context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.CENTER,
                backgroundColor: Colors.white70,
                textColor: Colors.black,
              );
            } else {
              Toast.show(
                "Some error occurred",
                context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.CENTER,
                backgroundColor: Colors.white70,
                textColor: Colors.black,
              );
            }
          },
          save: () async {
            print(widget.imageUrl);

            FileInfo imageFile =
                await DefaultCacheManager().downloadFile(widget.imageUrl);
            SaveImageToDir(
              imageFile.file,
              widget.imageUrl.substring(
                  widget.imageUrl.lastIndexOf("/"), widget.imageUrl.length),
            ).saveImageToDir();

            Toast.show(
              "Image saved!",
              context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: Colors.white70,
              textColor: Colors.black,
            );

            if (await _interstitial.isLoaded) {
              _interstitial.show();
              return "Ad is showing";
            } else {
              return "Ad is not loaded!";
            }
          },
        ),
      ],
    );
  }
}
