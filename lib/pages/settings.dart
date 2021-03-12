import 'package:flutter/material.dart';
import 'package:wallpapers/components/my_spacer.dart';
import 'package:wallpapers/components/my_text.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _changeWallpaper = true,
      _saveLikedWallpaper = true,
      _saveToDevice = false,
      _applyForBoth = false,
      _removeAds = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalSpacer(30),
          HeadingText("Auto change new wallpaper"),
          Switch(
            value: _changeWallpaper,
            onChanged: (onChanged) {
              setState(() {
                _changeWallpaper = !_changeWallpaper;
              });
            },
          ),
          VerticalSpacer(16),
          HeadingText("Save favorite wallpapers to device"),
          Switch(
            value: _saveLikedWallpaper,
            onChanged: (onChanged) {
              setState(() {
                _saveLikedWallpaper = !_saveLikedWallpaper;
              });
            },
          ),
          VerticalSpacer(16),
          HeadingText("Save wallpapers to device"),
          Switch(
            value: _saveToDevice,
            onChanged: (onChanged) {
              setState(() {
                _saveToDevice = !_saveToDevice;
              });
            },
          ),
          VerticalSpacer(16),
          HeadingText("Apply wallpaper to both HomeScreen and LockScreen"),
          Switch(
            value: _applyForBoth,
            onChanged: (onChanged) {
              setState(() {
                _applyForBoth = !_applyForBoth;
              });
            },
          ),
          VerticalSpacer(16),
          HeadingText("Remove ads"),
          Switch(
            value: _removeAds,
            onChanged: (onChanged) {
              setState(() {
                _removeAds = !_removeAds;
              });
            },
          ),
        ],
      ),
    );
  }
}
