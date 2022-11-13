import 'package:flutter/material.dart';
import 'home.dart';
import 'vnos.dart';
import 'prijava.dart';

class Statistika extends StatefulWidget {
  const Statistika({Key? key}) : super(key: key);

  @override
  _StatistikaState createState() => _StatistikaState();
}

class _StatistikaState extends State<Statistika> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.orange,),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Domov',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Vnos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              label: 'Statistika',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face),
              label: 'Odjava',
            ),
          ],
          currentIndex: 2,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.orangeAccent,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
  void _onItemTapped(int index) {
    if(index == 0){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Home()));
    }
    if(index == 1){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Vnos()));
    }
    if(index == 3){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Prijava()));
    }
  }
}
