import 'package:flutter/material.dart';
import 'prijava.dart';

class PozabljenoGeslo extends StatefulWidget {
  const PozabljenoGeslo({Key? key}) : super(key: key);

  @override
  _PozabljenoGesloState createState() => _PozabljenoGesloState();
}

class _PozabljenoGesloState extends State<PozabljenoGeslo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
              onPressed: (){Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Prijava()));},
              child: Text('Pošlji'))
        ],
      ),

    );
  }
}
