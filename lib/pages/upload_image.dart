import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:wallpapers/components/my_spacer.dart';
import 'package:wallpapers/components/my_text.dart';
import 'package:wallpapers/constants.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  String buttonText = "Select Image";
  bool showImage = false;
  Uint8List imageBytes;
  PickedFile pickedFile;

  _selectImage() async {
    pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    pickedFile.readAsBytes().then(
      (value) async {
        setState(() {
          imageBytes = value;
          showImage = true;
          buttonText = "Upload Image";
        });
      },
    );
  }

  _uploadImage() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        title: HeadingText("Please wait! Uploading..."),
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

          await FirebaseFirestore.instance.collection("wallpapers").add(
            {
              "id": data["data"]["id"],
              "url": data["data"]["url"],
            },
          );

          ///Updating to new wallpaper
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          if (sharedPreferences.getBool(KEY_CHANGE_WALLPAPER) == true) {
            int location = WallpaperManager.HOME_SCREEN;
            var file = await DefaultCacheManager().getSingleFile(
              data["data"]["url"],
            );

            final String result = await WallpaperManager.setWallpaperFromFile(
                file.path, location);
            print(result);
            // if (result == "Wallpaper set") {
            //   Toast.show(
            //     "Wallpaper applied successfully",
            //     context,
            //     duration: Toast.LENGTH_LONG,
            //     gravity: Toast.CENTER,
            //     backgroundColor: Colors.white70,
            //     textColor: Colors.black,
            //   );
            // } else {
            //   Toast.show(
            //     "Some error occurred",
            //     context,
            //     duration: Toast.LENGTH_LONG,
            //     gravity: Toast.CENTER,
            //     backgroundColor: Colors.white70,
            //     textColor: Colors.black,
            //   );
            // }
          }
        },
      );
    });
    Toast.show(
      "Image uploaded successfully",
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.CENTER,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );

    setState(() {
      buttonText = "Select Image";
      showImage = false;
      imageBytes = null;
      pickedFile = null;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Upload Image",
              style: GoogleFonts.sofia(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: HeadingText("Do you really want to leave?"),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();

                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text("Yes"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No"),
                ),
              ],
            ),
          );

          return Future.value(false);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showImage
                  ? Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: Image.memory(
                          imageBytes,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : ContentText("Selected image appear here!"),
              VerticalSpacer(16),
              ElevatedButton(
                child: Text(buttonText),
                onPressed: !showImage ? _selectImage : _uploadImage,
              ),
              VerticalSpacer(32),
            ],
          ),
        ),
      ),
    );
  }
}
