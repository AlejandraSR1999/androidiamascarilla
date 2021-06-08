import 'package:face_mask_detector_app/homePage.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';



class MySplashPage extends StatefulWidget {

  @override
  _MySplashPageState createState() => _MySplashPageState();
}

class _MySplashPageState extends State<MySplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 15 ,
      navigateAfterSeconds: HomePage() ,
      title: Text(
        'Face Mask Detector App',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
      ) ,
      image: Image.asset("assets/splash.png"),
      photoSize: 130,
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
      loadingText: Text(
        "By Alejandra Salazar",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
     ),
      ),
    );
  }
}

