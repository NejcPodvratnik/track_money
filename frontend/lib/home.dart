import 'package:flutter/material.dart';
import 'novica.dart';
import 'vnos.dart';
import 'statistika.dart';
import 'prijava.dart';
import 'fetch_posts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: MediaQuery.of(context).size.width * 0.45,
            child: FutureBuilder(
                    initialData: [],
                    future: FetchWpPosts(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data != null) {
                        print(snapshot);
                        return ListView.builder(
                          //shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map wpPost = snapshot.data![index];

                            return PostTile(
                                href: wpPost["urlToImage"],
                                title: wpPost["title"],
                                content: wpPost["content"]);
                          },
                        );
                      }

                      return CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
         // ),
        //],
      //),
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

class PostTile extends StatefulWidget {
  final String href, title, content;
  PostTile(
      {required this.content,
        required this.href,
        required this.title});

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Post(
                  imageUrl: widget.href,
                  title: widget.title,
                  content: widget.content,
                )));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            //width: 300,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  FittedBox(
                    child:
                    Image.network(widget.href),
                    fit: BoxFit.fitWidth,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.bottomLeft,
                    child: Padding(
                        padding: EdgeInsets.only(
                            bottom: 10.0, left: 20.0, right: 20.0),
                        child: Text.rich(TextSpan(
                            style: TextStyle(color: Colors.white),
                            children: [
                              TextSpan(
                                text: widget.title,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ])) //Your widget here,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
