import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpapers/constants.dart';
import 'package:wallpapers/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Admob.initialize();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

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

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
        textTheme: GoogleFonts.tenorSansTextTheme(
          Theme.of(context).textTheme,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
          ),
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          textTheme: GoogleFonts.sofiaTextTheme(
            Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(Colors.grey[500]),
            // foregroundColor: MaterialStateProperty.all<Color>(appbarColor),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
        ),
      ),
      home: Home(),
    );
  }
}
