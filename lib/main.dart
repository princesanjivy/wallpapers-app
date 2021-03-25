import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:wallpapers/constants.dart';
import 'package:wallpapers/pages/home.dart';
import 'package:workmanager/workmanager.dart';

// void printHello() async {
//   // await Firebase.initializeApp();
//   //
//   // await FirebaseFirestore.instance.collection("test").add({
//   //   "data": Random().nextInt(50).toString(),
//   //   "time": DateTime.now().hour.toString() + DateTime.now().minute.toString()
//   // });
//   // print("Data inserted");
// }

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    // print("Hey Prince!"); //simpleTask will be emitted here.

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString(KEY_NEW_WALLPAPER));

    await Firebase.initializeApp();
    await FirebaseFirestore.instance
        .collection("new_wallpaper")
        .doc("0")
        .get()
        .then((value) async {
      // print(value.get("id"));
      if (value.get("id") != sharedPreferences.getString(KEY_NEW_WALLPAPER)) {
        // print("HELLO");
        int location = WallpaperManager.HOME_SCREEN;
        var file = await DefaultCacheManager().getSingleFile(
          value.get("url"),
        );

        final String result =
            await WallpaperManager.setWallpaperFromFile(file.path, location);
        print(result);
        sharedPreferences.setString(KEY_NEW_WALLPAPER, value.get("id"));
      }
    });

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Admob.initialize();

  Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager.registerPeriodicTask(
    "351",
    "prince",
    frequency: Duration(
      minutes: 16,
    ),
  );
  // final int helloAlarmID = 0;
  // await AndroidAlarmManager.initialize();
  // await AndroidAlarmManager.periodic(
  //     Duration(minutes: 1), helloAlarmID, printHello,
  //     wakeup: true);

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
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionHandleColor: Colors.black,
          selectionColor: Colors.grey,
        ),
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
            color: Colors.white,
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
