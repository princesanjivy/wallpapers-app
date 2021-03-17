import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpapers/components/my_spacer.dart';
import 'package:wallpapers/components/my_text.dart';
import 'package:wallpapers/constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _changeWallpaper,
      _saveLikedWallpaper,
      _saveToDevice,
      _applyForBoth,
      _removeAds;

  SharedPreferences sharedPreferences;

  Future<bool> _getValue() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getBool(KEY_CHANGE_WALLPAPER) == null) {
      sharedPreferences.setBool(KEY_CHANGE_WALLPAPER, true);
    }
    if (sharedPreferences.getBool(KEY_SAVE_WALLPAPER) == null) {
      sharedPreferences.setBool(KEY_SAVE_WALLPAPER, true);
    }
    if (sharedPreferences.getBool(KEY_SAVE_TO_DEVICE) == null) {
      sharedPreferences.setBool(KEY_SAVE_TO_DEVICE, false);
    }
    if (sharedPreferences.getBool(KEY_APPLY_FOR_BOTH) == null) {
      sharedPreferences.setBool(KEY_APPLY_FOR_BOTH, false);
    }
    if (sharedPreferences.getBool(KEY_REMOVE_ADS) == null) {
      sharedPreferences.setBool(KEY_REMOVE_ADS, false);
    }

    _changeWallpaper = sharedPreferences.getBool(KEY_CHANGE_WALLPAPER);
    _saveLikedWallpaper = sharedPreferences.getBool(KEY_SAVE_WALLPAPER);
    _saveToDevice = sharedPreferences.getBool(KEY_SAVE_TO_DEVICE);
    _applyForBoth = sharedPreferences.getBool(KEY_APPLY_FOR_BOTH);
    _removeAds = sharedPreferences.getBool(KEY_REMOVE_ADS);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _getValue(),
        builder: (context, futureSnapshot) {
          if (!futureSnapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return futureSnapshot.data
              ? Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            showLicensePage(
                                context: context,
                                applicationName: "RealGoodQuote Wallpapers");
                            // showAboutDialog(
                            //   context: context,
                            //   applicationIcon: Center(
                            //     child: Image.asset(
                            //       "assets/images/logo.png",
                            //       width: 80,
                            //       height: 80,
                            //     ),
                            //   ),
                            //   useRootNavigator: false,
                            // );
                          },
                          child: Text("Click ME")),
                      VerticalSpacer(30),
                      HeadingText("Auto change new wallpaper"),
                      Switch(
                        value: _changeWallpaper,
                        onChanged: (onChanged) {
                          setState(() {
                            _changeWallpaper = !_changeWallpaper;
                          });
                          sharedPreferences.setBool(KEY_CHANGE_WALLPAPER,
                              !sharedPreferences.getBool(KEY_CHANGE_WALLPAPER));
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
                          sharedPreferences.setBool(KEY_SAVE_WALLPAPER,
                              !sharedPreferences.getBool(KEY_SAVE_WALLPAPER));
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
                          sharedPreferences.setBool(KEY_SAVE_TO_DEVICE,
                              !sharedPreferences.getBool(KEY_SAVE_TO_DEVICE));
                        },
                      ),
                      VerticalSpacer(16),
                      HeadingText(
                          "Apply wallpaper to both HomeScreen and LockScreen"),
                      Switch(
                        value: _applyForBoth,
                        onChanged: (onChanged) {
                          setState(() {
                            _applyForBoth = !_applyForBoth;
                          });
                          sharedPreferences.setBool(KEY_APPLY_FOR_BOTH,
                              !sharedPreferences.getBool(KEY_APPLY_FOR_BOTH));
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
                          sharedPreferences.setBool(KEY_REMOVE_ADS,
                              !sharedPreferences.getBool(KEY_REMOVE_ADS));
                        },
                      ),
                    ],
                  ),
                )
              : Container();
        });
  }
}
