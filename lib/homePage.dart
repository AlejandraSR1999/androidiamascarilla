import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:face_mask_detector_app/main.dart' ;
import 'package:tflite/tflite.dart' ;
import 'package:face_mask_detector_app/data.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{ final Uri _url =
Uri.parse('https://apiexamenfinal2021.azurewebsites.net/api/Data');

Future<String> _sendData(String evento) async {
  Data data = Data(
    nameDevice: "HuaweiPruebaMascarilla",
    eventDate: DateTime.now(),
    eventDescription: evento,

  );
  var response = await http.post(
    _url,
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    },
    body: dataToJson(data),
  );
  print("${response.statusCode}: ${response.body}");
  return response.body;
}
  CameraImage imgCamera;
  CameraController cameraController;
  bool isWorking = false;
  String result="";

  initCamera()
  {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);

    cameraController.initialize().then((value)
    {
      if(!mounted)
      {
        return;
      }

      setState(() {
        cameraController.startImageStream((imageFromStream) =>
        {
          if(!isWorking)
            {
              isWorking = true,
              imgCamera = imageFromStream,
              runModelOnFrame(),
            }
        });
      });
    });
  }

  loadModel() async
  {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  runModelOnFrame() async
  {
    if(imgCamera != null)
    {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: imgCamera.planes.map((plane)
        {
          return plane.bytes;
        }).toList(),
        imageHeight: imgCamera.height,
        imageWidth: imgCamera.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 1,
        threshold: 0.1,
        asynch: true,
      );

      result = "";

      recognitions.forEach((response)
      {
        result += response["label"] + "\n";
      });

      setState(() {
        _sendData(result.toString());

      });

      isWorking = false;
    }
  }

  @override
  void initState() {
    super.initState();

    initCamera();
    loadModel();
  }

  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Center(
                child: Text(
                  result,
                  style: TextStyle(
                    backgroundColor: Colors.black54,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Positioned(
                top: 0,
                left: 0,
                width: size.width,
                height: size.height-100,
                child: Container(
                  height: size.height-100,
                  child: (!cameraController.value.isInitialized)
                      ? Container()
                      : AspectRatio(
                    aspectRatio: cameraController.value.aspectRatio,
                    child: CameraPreview(cameraController),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
