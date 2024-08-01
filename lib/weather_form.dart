import 'package:flutter/material.dart';
import './weather.dart';

class WeatherForm extends StatefulWidget {
  @override
  _WeatherFormState createState() => _WeatherFormState();
}

class _WeatherFormState extends State<WeatherForm> {
  String city = '';  // Initialize city to an empty string to ensure it is never null.
  TextEditingController cityEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(city.isEmpty ? 'Enter a City' : city),  // Display 'Enter a City' if city is empty
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(hintText: 'Type a City...'),
              controller: cityEditingController,
              onChanged: (String value) {
                setState(() {
                  city = value;  // Update city with the value entered
                });
              },
              onSubmitted: (String value) {
                if (value.isNotEmpty) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Weather(value)));
                  cityEditingController.clear();  // Clear text field after submission
                }
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                if (city.isNotEmpty) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Weather(city)));
                  cityEditingController.clear();  // Clear text field after pressing the button
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.deepOrangeAccent,  // Text color
              ),
              child: Text('Get Weather'),
            ),
          ),
        ],
      ),
    );
  }
}
