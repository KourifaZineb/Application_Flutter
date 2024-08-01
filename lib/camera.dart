// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';

// class CameraPage extends StatefulWidget {
//   @override
//   _CameraPageState createState() => _CameraPageState();
// }

// class _CameraPageState extends State<CameraPage> {
//   late File imageFile;
//   late VisionText visionTextOCR;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Camera'), backgroundColor: Colors.deepOrange),
//       body: Container(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                 width: double.infinity, padding: EdgeInsets.all(10),
//                 child: MaterialButton(
//                   color: Colors.blue,
//                   onPressed: () { openDialog(context); },
//                   child: Text('Pick Image', style: TextStyle(color: Colors.white, fontSize: 22)),
//                 ),
//               ),
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(8.0),
//                 child: SingleChildScrollView(
//                   child: Text(visionTextOCR == null ? '' : visionTextOCR.text),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   padding: EdgeInsets.all(20),
//                   width: double.infinity,
//                   height: 400,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.deepOrangeAccent, width: 1),
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: imageFile != null ? FileImage(imageFile) : AssetImage('images/profile.jpg') as ImageProvider,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<VisionText> textRecognition(File imageFile) async {
//     final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
//     final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
//     final VisionText visionText = await textRecognizer.processImage(visionImage);
//     return visionText;
//   }

//   Future<void> openDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Make a Choice'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Gallery'),
//               onPressed: () async {
//                 Navigator.of(context).pop();
//                 var picker = ImagePicker();
//                 var pickedFile = await picker.pickImage(source: ImageSource.gallery);
//                 if (pickedFile != null) {
//                   File croppedFile = await ImageCropper.cropImage(sourcePath: pickedFile.path);
//                   VisionText visionText = await textRecognition(croppedFile);
//                   setState(() {
//                     imageFile = File(pickedFile.path);
//                     visionTextOCR = visionText;
//                   });
//                 }
//               },
//             ),
//             TextButton(
//               child: Text('Camera'),
//               onPressed: () async {
//                 Navigator.of(context).pop();
//                 var picker = ImagePicker();
//                 var pickedFile = await picker.pickImage(source: ImageSource.camera, maxWidth: 400, maxHeight: 400);
//                 if (pickedFile != null) {
//                   File croppedFile = await ImageCropper.cropImage(sourcePath: pickedFile.path);
//                   VisionText visionText = await textRecognition(croppedFile);
//                   print(visionText.text);
//                   setState(() {
//                     imageFile = File(pickedFile.path);
//                     visionTextOCR = visionText;
//                   });
//                 }
//               },
//             ),
//           ],
//         );
//       }
//     );
//   }
// }
