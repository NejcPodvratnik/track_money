import 'package:flutter/material.dart';
import 'home.dart';
import 'statistika.dart';
import 'prijava.dart';

class Vnos extends StatefulWidget {
  const Vnos({Key? key}) : super(key: key);

  @override
  _VnosState createState() => _VnosState();
}

class _VnosState extends State<Vnos> {
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
          currentIndex: 1,
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
    if(index == 2){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Statistika()));
    }
    if(index == 3){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Prijava()));
    }
  }
}
