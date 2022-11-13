import 'package:flutter/material.dart';
import 'home.dart';

class Registracija extends StatefulWidget {
  const Registracija({Key? key}) : super(key: key);

  @override
  _RegistracijaState createState() => _RegistracijaState();
}

class _RegistracijaState extends State<Registracija> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
              onPressed: (){Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home()));},
              child: Text('Registracija'))
        ],
      ),

    );
  }
}
