import 'package:flutter/material.dart';
import 'package:wallpapers/components/my_spacer.dart';
import 'package:wallpapers/components/my_text.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _changeWallpaper = true,
      _saveLikedWallpaper = false,
      _applyForBoth = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpacer(80),
        HeadingText("Auto change new wallpaper"),
        Switch(
          value: _changeWallpaper,
          onChanged: (onChanged) {
            setState(() {
              _changeWallpaper = !_changeWallpaper;
            });
          },
        ),
        HeadingText("Save favorite wallpapers to device"),
        Switch(
          value: _saveLikedWallpaper,
          onChanged: (onChanged) {
            setState(() {
              _saveLikedWallpaper = !_saveLikedWallpaper;
            });
          },
        ),
        HeadingText("Apply wallpaper to both HomeScreen and LockScreen"),
        Switch(
          value: _applyForBoth,
          onChanged: (onChanged) {
            setState(() {
              _applyForBoth = !_applyForBoth;
            });
          },
        ),
      ],
    );
  }
}
