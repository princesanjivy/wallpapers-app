import 'package:flutter/material.dart';
import 'package:wallpapers/components/my_spacer.dart';
import 'package:wallpapers/components/my_text.dart';

class AboutDev extends StatefulWidget {
  @override
  _AboutDevState createState() => _AboutDevState();
}

class _AboutDevState extends State<AboutDev> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      padding: EdgeInsets.all(16),
      children: [
        VerticalSpacer(16),
        HeadingText("Real Good Quote"),
        VerticalSpacer(8),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              width: 120,
              height: 120,
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        VerticalSpacer(8),
        ContentText(
            "An Instagram blog maintained by @psa_28, which delivers a variety of beautifully designed quotes.\nDo follow @realgoodquote"),
        VerticalSpacer(16),
        HeadingText("Developer"),
        VerticalSpacer(8),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              width: 120,
              height: 120,
              child: Image.asset(
                "assets/images/sanjivy.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        VerticalSpacer(8),
        Center(
          child: HeadingText("Prince Sanjivy"),
        ),
        VerticalSpacer(8),
        ContentText(
          "A passionate coder in Python who loves to build apps and games for Android and Web.",
        ),
        VerticalSpacer(8),
// Todo Place social media icons
        VerticalSpacer(32),
        ElevatedButton(
          onPressed: () {
            showLicensePage(
              context: context,
              applicationName: "RealGoodQuote Wallpapers",
            );
          },
          child: Text(
            "OPEN SOURCE LICENSES",
            style: TextStyle(
              letterSpacing: 1.4,
            ),
          ),
        ),
        VerticalSpacer(16),
      ],
    );
  }
}
