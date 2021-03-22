import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String text;

  HeadingText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 17.2,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class ContentText extends StatelessWidget {
  final String text;

  ContentText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w200,
        wordSpacing: 1.4,
      ),
    );
  }
}
