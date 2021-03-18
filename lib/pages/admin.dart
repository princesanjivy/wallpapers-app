import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:wallpapers/components/my_spacer.dart';
import 'package:wallpapers/components/my_text.dart';
import 'package:wallpapers/pages/upload_image.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool loading = false;

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
              "Admin Login",
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
                  onPressed: () {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeadingText("Enter login credentials"),
            VerticalSpacer(16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _emailController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
            ),
            VerticalSpacer(16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _passwordController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
              ),
            ),
            VerticalSpacer(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text);

                      setState(() {
                        loading = false;
                      });

                      _emailController.clear();
                      _passwordController.clear();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadImage(),
                        ),
                      );
                    } catch (e) {
                      Toast.show(
                        "Invalid Credentials",
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.CENTER,
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                      );

                      setState(() {
                        loading = false;
                      });
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                HorizontalSpacer(16),
                ElevatedButton(
                  onPressed: () async {},
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            VerticalSpacer(16),
            loading ? CircularProgressIndicator() : Container(),
          ],
        ),
      ),
    );
  }
}
