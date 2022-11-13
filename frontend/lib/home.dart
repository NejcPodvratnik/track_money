import 'package:flutter/material.dart';
import 'vnos.dart';
import 'statistika.dart';
import 'prijava.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.orangeAccent,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    if(index == 1){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Vnos()));
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
