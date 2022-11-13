import 'package:flutter/material.dart';
import 'package:money_tracker/registracija.dart';
import 'home.dart';
import 'pozabljeno_geslo.dart';

class Prijava extends StatefulWidget {
  const Prijava({Key? key}) : super(key: key);

  @override
  _PrijavaState createState() => _PrijavaState();
}

class _PrijavaState extends State<Prijava> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: (){Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home()));},
                child: Text('Prijava')),
            TextButton(
                onPressed: (){Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Registracija()));},
                child: Text('Registracija')),
            TextButton(
                onPressed: (){Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PozabljenoGeslo()));},
                child: Text('Ste pozabili geslo?'))
          ],
        ),
      ),

    );
  }


}