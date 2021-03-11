import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpapers/components/my_spacer.dart';

class BottomPanel extends StatelessWidget {
  final Function apply;
  final Function save;

  BottomPanel({
    this.apply,
    this.save,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      height: 120,
      color: Colors.black54,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            child: SvgPicture.asset(
              "assets/svg/save.svg",
              width: 28,
              height: 28,
              color: Colors.white,
            ),
            onTap: save,
          ),
          HorizontalSpacer(28),
          GestureDetector(
            child: SvgPicture.asset(
              "assets/svg/wallpaper.svg",
              width: 28,
              height: 28,
              color: Colors.white,
            ),
            onTap: apply,
          ),
        ],
      ),
    );
  }
}
