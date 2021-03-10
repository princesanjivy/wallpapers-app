import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpapers/constants.dart';

class Favorites extends StatelessWidget {
  Future<List<String>> getFavoriteImages() async {
    print("hello");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getStringList(SHARED_PREF_KEY) == null)
      return [];
    else
      return sharedPreferences.getStringList(SHARED_PREF_KEY);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: getFavoriteImages(),
        builder: (context, snapshot) {
          print("bye1");
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          print("bye");
          return Center(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 9 / 16,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => Image.network(
                snapshot.data[index].toString(),
                fit: BoxFit.cover,
              ),
            ),
          );
        });
  }
}
