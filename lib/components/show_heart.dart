import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HeartAnimation extends StatefulWidget {
  @override
  _HeartAnimationState createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation> {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset("assets/lottiefiles/hearts.json");
  }
}
