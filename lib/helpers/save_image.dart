import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image/image.dart';

class SaveImageToDir {
  final File file;
  final String name;
  String path;
  static const platform = const MethodChannel("com.princeappstudio.saveimage");
  SaveImageToDir(this.file, this.name);

  void saveImageToDir() async {
    var dir = "/storage/emulated/0/Pictures";

    var pictDir = await Directory('$dir/RGQWallpapers').create(recursive: true);
    Image image = decodeImage(file.readAsBytesSync());

    path = file.path.toString();
    print(path);
    path = path.substring(path.lastIndexOf("/"), path.length);
    print(path);

    final File myFile = File("${pictDir.path}$name")
      ..writeAsBytesSync(encodeJpg(image));

    try {
      String result =
          await platform.invokeMethod("saveimage", {"file": myFile.path});
      print(result);
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
