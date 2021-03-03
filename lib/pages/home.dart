import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: PageController(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            child: Image.network(
              "https://soruce.unsplash.com/random",
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
