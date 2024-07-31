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
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

class Weather extends StatefulWidget {
  final String city;

  Weather({required this.city});

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  List<dynamic> weatherData = []; // Initialiser avec une liste vide

  Future<void> getData(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body)['list'];
        });
      } else {
        print('Failed to load weather data');
      }
    } catch (err) {
      print('Error: $err');
    }
  }

  @override
  void initState() {
    super.initState();
    String url = 'https://api.openweathermap.org/data/2.5/forecast?q=${widget.city}&appid=13304dbe4af419771e4d7f19a24ee64f';
    print(url);
    getData(url);
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
                return Card(
                  color: Colors.deepOrangeAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage('images/${weatherData[index]['weather'][0]['main'].toLowerCase()}.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    DateFormat('E dd/MM/yyyy').format(
                                      DateTime.fromMicrosecondsSinceEpoch(weatherData[index]['dt'] * 1000000),
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${DateFormat('HH:mm').format(
                                      DateTime.fromMicrosecondsSinceEpoch(weatherData[index]['dt'] * 1000000),
                                    )} | ${weatherData[index]['weather'][0]['main']}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${weatherData[index]['main']['temp'].round()} °C",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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
