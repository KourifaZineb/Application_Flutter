// import 'package:flutter/material.dart';
// import './quiz.dart';
// import './weather.dart';

// void main() => runApp(const MaterialApp(
// home: MyApp(),
// ));

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//       title: const Text('First App'),
//       backgroundColor: Colors.orange,
//     ),
//     body: const Center(
//     child: Text(
//       'Hello',
//       style: TextStyle(fontSize: 30),
//       textAlign: TextAlign.center,
//     )),
//     drawer: Drawer(
//       child: ListView(
//         children: <Widget>[
//           new DrawerHeader(
//             child: Center(
//               child: CircleAvatar(
//                 radius: 50,backgroundImage: NetworkImage('https://.../profile.png'),
//               ),
//             ),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [Colors.orange, Colors.white])
//             ),
//           ),
//           ListTile(
//             title: Text(
//               'Quiz', style: TextStyle(fontSize: 18),
//             ),
//             trailing: Icon(Icons.arrow_right),
//             onTap: () {
//             Navigator.of(context).pop();
//             Navigator.push(
//             context, MaterialPageRoute(builder: (context) => Quiz()));
//             }),
//           ListTile(
//           title: Text(
//             'Weather',style: TextStyle(fontSize: 18),
//           ),
//           trailing: Icon(Icons.arrow_right),
//           onTap: () {
//             Navigator.of(context).pop();
//             Navigator.push(
//               context, MaterialPageRoute(builder: (context) => Weather()));
//           })
//         ],
//       ),
//     ),
//   );
    
//   }
// }

import 'package:flutter/material.dart';
import './quiz.dart';
import './weather_form.dart';

void main() => runApp(const MaterialApp(
  home: MyApp(),
));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First App'),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text(
          'Hello',
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://.../profile.png'),
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.orange, Colors.white]),
              ),
            ),
            ListTile(
              title: Text(
                'Quiz', style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Quiz()));
              }),
            ListTile(
              title: Text(
                'Weather', style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => WeatherForm()));
              }),
            ListTile(
              title: Text(
                'Gallery', style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                // Replace with the appropriate widget for Gallery
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Container()));
              }),
            ListTile(
              title: Text(
                'Camera', style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                // Replace with the appropriate widget for Camera
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Container()));
              }),
          ],
        ),
      ),
    );
  }
}
