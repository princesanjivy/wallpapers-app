import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:wallpapers/components/menu.dart';
import 'package:wallpapers/components/my_text.dart';
import 'package:wallpapers/constants.dart';
import 'package:wallpapers/pages/favorites.dart';
import 'package:wallpapers/pages/settings.dart';
import 'package:wallpapers/pages/wallpapers.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List images = [
    "https://i.ibb.co/xgYzJYk/IMG-20210306-223056-403.jpg",
    "https://images.unsplash.com/photo-1610609626939-f128da9a7d95?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
    "https://images.unsplash.com/photo-1610507121055-429412085fba?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDF8fHxlbnwwfHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1610609626993-58a8929bf3e7?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=334&q=80",
    "https://images.unsplash.com/photo-1555980021-02eb1d774f8e?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=337&q=80",
  ];

  List menuItemsName = [
    "Wallpapers",
    "Favorites",
    "Rate & Review",
    "Settings",
    "About",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SimpleHiddenDrawer(
        contentCornerRadius: 30,
        slidePercent: 60,
        menu: DrawerMenu(),
        screenSelectedBuilder: (position, controller) {
          Widget body;

          switch (position) {
            case 0:
              body = WallpapersPage();
              break;
            case 1:
              body = Favorites();
              break;
            case 3:
              body = SettingsPage();
              break;
            case 4:
              body = Center(
                child: ElevatedButton(
                  child: Text("Clear Prefs"),
                  onPressed: () async {
                    // SharedPreferences sharedPreferences =
                    //     await SharedPreferences.getInstance();
                    // sharedPreferences.clear();

                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: adminEmail, password: adminPassword);

                    final pickedFile = await ImagePicker()
                        .getImage(source: ImageSource.gallery);

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => SimpleDialog(
                        title: HeadingText("Please wait"),
                        children: [
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    );

                    await pickedFile.readAsBytes().then((value) async {
                      var request = http.MultipartRequest(
                        "POST",
                        Uri.parse(
                            "https://api.imgbb.com/1/upload?expiration=600&key=a02671eb5d1fb97fbb43de60da54af7d"),
                      )..files.add(
                          http.MultipartFile.fromString(
                            "image",
                            Base64Encoder().convert(value),
                          ),
                        );

                      var response = await request.send();
                      response.stream.bytesToString().then(
                        (value) async {
                          Map data = jsonDecode(value);
                          print(data["data"]["id"]);
                          print(data["data"]["url"]);

                          await FirebaseFirestore.instance
                              .collection("wallpapers")
                              .add(
                            {
                              "id": data["data"]["id"],
                              "url": data["data"]["url"],
                            },
                          ).then((value) async {
                            await FirebaseAuth.instance.signOut();
                          });
                        },
                      );
                    });

                    Navigator.pop(context);
                  },
                ),
              );
              break;
          }
          return Scaffold(
            extendBodyBehindAppBar: position == 0 ? true : false,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Padding(
                padding: EdgeInsets.all(12),
                child: InkWell(
                  child: SvgPicture.asset(
                    "assets/svg/menu.svg",
                    width: 28,
                    height: 28,
                    color: position == 0 ? Colors.white : Colors.black,
                  ),
                  onTap: () {
                    controller.toggle();
                  },
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    menuItemsName[position],
                    style: GoogleFonts.sofia(
                      color: position == 0 ? Colors.white : Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            body: body,
          );
        },
      ),
    );
  }
}
