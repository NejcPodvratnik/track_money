import 'package:flutter/material.dart';
import 'package:frontend/registracija.dart';
import 'package:frontend/home.dart';
import 'package:frontend/pozabljeno_geslo.dart';

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
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                },
                child: const Text('Prijava')),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Registracija()));
                },
                child: const Text('Registracija')),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PozabljenoGeslo()));
                },
                child: const Text('Ste pozabili geslo?'))
          ],
        ),
      ),
    );
  }
}
