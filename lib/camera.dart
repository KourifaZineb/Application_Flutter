// import 'dart:io';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
// import 'dart:typed_data';
// import 'package:image/image.dart' as img; // Import for image manipulation

// class CameraPage extends StatefulWidget {
//   @override
//   _CameraPageState createState() => _CameraPageState();
// }

// class _CameraPageState extends State<CameraPage> {
//   File? imageFile;
//   String? visionTextOCR; // Use String for web mock-up
//   Uint8List? webImage;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Camera'),
//         backgroundColor: Colors.deepOrange,
//       ),
//       body: Container(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(10),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//                   onPressed: () {
//                     openDialog(context);
//                   },
//                   child: Text('Pick Image', style: TextStyle(color: Colors.white, fontSize: 22)),
//                 ),
//               ),
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(8.0),
//                 child: SingleChildScrollView(
//                   child: Text(visionTextOCR ?? 'No text recognized'),
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
//                       image: kIsWeb
//                           ? (webImage != null ? MemoryImage(webImage!) : AssetImage('images/profil.jpg'))
//                           : (imageFile != null ? FileImage(imageFile!) : AssetImage('images/profil.jpg')) as ImageProvider,
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
//                 if (!kIsWeb) {
//                   var file = await ImagePicker().pickImage(source: ImageSource.gallery);
//                   if (file != null) {
//                     var croppedFile = await ImageCropper().cropImage(
//                       sourcePath: file.path,
//                       aspectRatioPresets: [
//                         CropAspectRatioPreset.square,
//                         CropAspectRatioPreset.ratio3x2,
//                         CropAspectRatioPreset.original,
//                         CropAspectRatioPreset.ratio4x3,
//                         CropAspectRatioPreset.ratio16x9
//                       ],
//                       androidUiSettings: AndroidUiSettings(
//                           toolbarTitle: 'Cropper',
//                           toolbarColor: Colors.deepOrange,
//                           toolbarWidgetColor: Colors.white,
//                           initAspectRatio: CropAspectRatioPreset.original,
//                           lockAspectRatio: false),
//                       iosUiSettings: IOSUiSettings(
//                         minimumAspectRatio: 1.0,
//                       ),
//                     );
//                     if (croppedFile != null) {
//                       VisionText visionText = await textRecognition(File(croppedFile.path));
//                       setState(() {
//                         imageFile = File(croppedFile.path);
//                         visionTextOCR = visionText.text;
//                       });
//                     }
//                   }
//                 } else {
//                   final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//                   if (pickedFile != null) {
//                     final bytes = await pickedFile.readAsBytes();
//                     final croppedBytes = cropImageWeb(bytes);
//                     // Simulate text recognition result for web
//                     setState(() {
//                       webImage = croppedBytes;
//                       visionTextOCR = 'Recognized text on web';
//                     });
//                   }
//                 }
//               },
//             ),
//             TextButton(
//               child: Text('Camera'),
//               onPressed: () async {
//                 Navigator.of(context).pop();
//                 if (!kIsWeb) {
//                   var file = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 400, maxHeight: 400);
//                   if (file != null) {
//                     var croppedFile = await ImageCropper().cropImage(
//                       sourcePath: file.path,
//                       aspectRatioPresets: [
//                         CropAspectRatioPreset.square,
//                         CropAspectRatioPreset.ratio3x2,
//                         CropAspectRatioPreset.original,
//                         CropAspectRatioPreset.ratio4x3,
//                         CropAspectRatioPreset.ratio16x9
//                       ],
//                       androidUiSettings: AndroidUiSettings(
//                           toolbarTitle: 'Cropper',
//                           toolbarColor: Colors.deepOrange,
//                           toolbarWidgetColor: Colors.white,
//                           initAspectRatio: CropAspectRatioPreset.original,
//                           lockAspectRatio: false),
//                       iosUiSettings: IOSUiSettings(
//                         minimumAspectRatio: 1.0,
//                       ),
//                     );
//                     if (croppedFile != null) {
//                       VisionText visionText = await textRecognition(File(croppedFile.path));
//                       setState(() {
//                         imageFile = File(croppedFile.path);
//                         visionTextOCR = visionText.text;
//                       });
//                     }
//                   }
//                 } else {
//                   final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 400, maxHeight: 400);
//                   if (pickedFile != null) {
//                     final bytes = await pickedFile.readAsBytes();
//                     final croppedBytes = cropImageWeb(bytes);
//                     // Simulate text recognition result for web
//                     setState(() {
//                       webImage = croppedBytes;
//                       visionTextOCR = 'Recognized text on web';
//                     });
//                   }
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Uint8List cropImageWeb(Uint8List imageData) {
//     img.Image? originalImage = img.decodeImage(imageData);
//     if (originalImage == null) {
//       return imageData;
//     }

//     int x = (originalImage.width - originalImage.height) ~/ 2;
//     int y = 0;
//     int size = originalImage.height;

//     img.Image croppedImage = img.copyCrop(originalImage, x, y, size, size);

//     return Uint8List.fromList(img.encodeJpg(croppedImage));
//   }

//   Future<VisionText> textRecognition(File imageFile) async {
//     final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
//     final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
//     final VisionText visionText = await textRecognizer.processImage(visionImage);
//     return visionText;
//   }
  
// }
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  Uint8List? imageBytes;
  String recognizedText = 'Aucun texte reconnu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reconnaissance de Texte'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageBytes != null) Image.memory(imageBytes!),
            SizedBox(height: 20),
            Text(recognizedText),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Choisir une Image'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageBytes = await pickedFile.readAsBytes();
      setState(() {});
      recognizeTextFromImage(imageBytes!);
    }
  }

  Future<void> recognizeTextFromImage(Uint8List bytes) async {
    const apiKey = 'YOUR_GOOGLE_CLOUD_VISION_API_KEY';  // Assurez-vous que cette clé est correcte
    final uri = Uri.parse('https://vision.googleapis.com/v1/images:annotate?key=$apiKey');
    final request = {
      "requests": [
        {
          "image": {"content": base64Encode(bytes)},
          "features": [{"type": "TEXT_DETECTION"}]
        }
      ]
    };

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(request)
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final textAnnotations = jsonResponse['responses'][0]['textAnnotations'];
        setState(() {
          recognizedText = textAnnotations.isNotEmpty ? textAnnotations[0]['description'] : 'Aucun texte détecté';
        });
      } else {
        throw Exception('Failed to decode text. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        recognizedText = 'Erreur de reconnaissance de texte: $e';
      });
    }
  }
}
