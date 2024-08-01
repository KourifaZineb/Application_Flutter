import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // To determine the platform
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  XFile? imageFile; // Using XFile to support both web and mobile
  String? visionTextOCR; // Assuming you process and store text as string

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera'), backgroundColor: Colors.deepOrange),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: double.infinity, padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () => openDialog(context),
                  child: Text('Pick Image', style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
              ),
              Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Text(visionTextOCR ?? 'No text recognized'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepOrangeAccent, width: 1),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: imageFile != null
                        ? (kIsWeb ? NetworkImage(imageFile!.path) : FileImage(File(imageFile!.path)) as ImageProvider)
                        : AssetImage('images/profile.jpg'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Make a Choice'),
          actions: <Widget>[
            TextButton(
              child: Text('Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    imageFile = pickedFile;
                    // Assume you process it here and get some text
                    visionTextOCR = "Sample text from processing the image";
                  });
                }
              },
            ),
            TextButton(
              child: Text('Camera'),
              onPressed: () async {
                Navigator.of(context).pop();
                XFile? pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  maxWidth: 400,
                  maxHeight: 400,
                );
                if (pickedFile != null) {
                  setState(() {
                    imageFile = pickedFile;
                    // Assume you process it here and get some text
                    visionTextOCR = "Sample text from processing the image";
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }
}
