import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpapers/components/fullscreen_view.dart';
import 'package:wallpapers/components/my_text.dart';
import 'package:wallpapers/constants.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  Future<List<String>> getFavoriteImages() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getStringList(KEY_FAVORITES) == null)
      return [];
    else
      return sharedPreferences.getStringList(KEY_FAVORITES);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getFavoriteImages(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return snapshot.data.length == 0
            ? Center(child: ContentText("Nothing to show"))
            : StaggeredGridView.countBuilder(
                padding: EdgeInsets.all(12),
                crossAxisCount: 4,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data[index].toString(),
                      placeholder: (context, value) =>
                          Center(child: CircularProgressIndicator()),
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenView(
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data[index].toString(),
                            placeholder: (context, value) =>
                                Center(child: CircularProgressIndicator()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              );
      },
    );
  }
}
