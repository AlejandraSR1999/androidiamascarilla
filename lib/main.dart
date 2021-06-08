import 'package:face_mask_detector_app/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';



List<CameraDescription> cameras;

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face Mask Detection',

      home: MySplashPage(),

    );
  }
}

