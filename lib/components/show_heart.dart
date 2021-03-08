import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HeartAnimation extends StatefulWidget {
  final bool showHeart;

  HeartAnimation({
    this.showHeart,
  });

  @override
  _HeartAnimationState createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this);
    animationController.addListener(() {
      setState(() {
        // if (animationController.isCompleted) showHeart = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset("assets/lottiefiles/hearts.json");
  }
}

// showHeart
// ? Lottie.asset(
// "assets/lottiefiles/heart.json",
// controller: animationController,
// onLoaded: (composition) {
// animationController
// ..duration = composition.duration
// ..value = composition.startFrame
// ..forward();
// },
// )
// : Container(),
