import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: PageController(),
        children: [
          for (var i = 0; i < 10; i++)
            Container(
              color: Color(
                (Random().nextDouble() * 0xFFFFFF).toInt(),
              ).withOpacity(1),
            ),
        ],
      ),
    );
  }
}
