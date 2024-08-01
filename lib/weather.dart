// import 'package:flutter/material.dart';

// class Weather extends StatelessWidget {
//   int counter;
//   Weather(this.counter);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             Text(
//               'Counter=$counter',
//               style: TextStyle(fontSize: 22),
//             ),
//             ElevatedButton(
//               child: Text('Add'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//               ),
//               onPressed: () {
//                 ++counter;
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Weather extends StatefulWidget {
  final String city;
  Weather(this.city);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  List<dynamic> weatherData = [];  // Initialiser avec une liste vide

  void getData(String url) {
    http.get(Uri.parse(url), headers: {'Accept': 'application/json'}).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body)['list'];
        });
      } else {
        print("Failed to load data");
      }
    }).catchError((err) {
      print(err);
    });
  }

  @override
  void initState() {
    super.initState();
    // Assurez-vous que l'URL est correct et utilisez 'https'
    String url = 'https://api.openweathermap.org/data/2.5/forecast?q=${widget.city}&appid=d9b2a3cf047cbaba8508a96d7f813fd4';
    print(url);
    this.getData(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city),
        backgroundColor: Colors.orange,
      ),
      body: weatherData.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: weatherData.length,
            itemBuilder: (context, index) {
              var item = weatherData[index];
              var mainWeather = item['weather'][0]['main'].toLowerCase();
              var imagePath = 'images/$mainWeather.png';
              var formattedDate = DateFormat('E dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000));
              var formattedTime = DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000));
              return Card(
                color: Colors.deepOrangeAccent,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage(imagePath),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  formattedDate,
                                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '$formattedTime | $mainWeather',
                                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${item['main']['temp'].round()} °C",
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
