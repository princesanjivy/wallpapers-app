import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:wallpapers/components/image_preview.dart';
import 'package:wallpapers/components/my_spacer.dart';

class WallpapersPage extends StatefulWidget {
  @override
  _WallpapersPageState createState() => _WallpapersPageState();
}

class _WallpapersPageState extends State<WallpapersPage> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  SimpleHiddenDrawerController hiddenDrawerController;

  int _pageIndex;

  @override
  void didChangeDependencies() {
    hiddenDrawerController = SimpleHiddenDrawerController.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _pageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (moveEvent) {
        if (moveEvent.delta.dx > 0) {
          if (_pageIndex == 0) {
            hiddenDrawerController.open();
          }
        } else {}
      },
      child: StreamBuilder<QuerySnapshot>(
          stream: firebaseFirestore.collection("wallpapers").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Fetching wallpapers\nPlease wait!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    VerticalSpacer(12),
                    CircularProgressIndicator(),
                  ],
                ),
              );

            return PageView.builder(
              pageSnapping: true,
              itemCount: snapshot.data.size,
              onPageChanged: (pageIndex) {
                _pageIndex = pageIndex;
              },
              itemBuilder: (context, index) {
                return ImagePreview(
                    imageUrl: snapshot.data.docs[index].get("url"));
              },
            );
          }),
    );
  }
}
