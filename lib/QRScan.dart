import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QRCodePage extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageData;
  String _qrCodeResult = "Aucun QR code scanné";

  Future<void> _pickAndScanImage() async {
    final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      final Uint8List imageData = await selectedImage.readAsBytes();
      setState(() {
        _imageData = imageData;
        _qrCodeResult = "Image chargée, décodage en cours...";
      });

      String? decodedText = await _decodeQRCode(imageData);
      setState(() {
        _qrCodeResult = decodedText ?? "Aucun QR code trouvé";
      });
    }
  }

  Future<String?> _decodeQRCode(Uint8List imageData) async {
    final String apiEndpoint = 'https://api.qrserver.com/v1/read-qr-code/';
    final http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(apiEndpoint));
    request.files.add(http.MultipartFile.fromBytes('file', imageData, filename: 'qr.png'));

    try {
      final http.StreamedResponse response = await request.send();
      final String responseString = await response.stream.bytesToString();
      print("Full Response: $responseString");  // This will help you see the full response from the server
      final List<dynamic> result = json.decode(responseString);

      if (result.isNotEmpty && result[0]['symbol'][0]['data'] != null) {
        return result[0]['symbol'][0]['data'];
      }
    } catch (e) {
      print("Erreur lors du décodage: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scanner de QR Code')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickAndScanImage,
              child: Text('Charger et Scanner une Image'),
            ),
            SizedBox(height: 20),
            _imageData != null ? Image.memory(_imageData!) : Text("Aucune image sélectionnée"),
            SizedBox(height: 20),
            Text(_qrCodeResult),
          ],
        ),
      ),
    );
  }
}
