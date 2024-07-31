import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  int counter;
  Quiz(this.counter);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Counter=${widget.counter}',
              style: TextStyle(fontSize: 22),
            ),
            ElevatedButton(
              child: Text('Add'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                setState(() {
                  ++widget.counter;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
