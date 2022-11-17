import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final String imageUrl, title, content;
  Post({required this.imageUrl, required this.title, required this.content});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("Nazaj"),
          elevation: 0,
          backgroundColor: Color(0xFFFFFFFF).withOpacity(0.4),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.3,
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.only(
                      bottomRight: const Radius.circular(80.0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20,),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.title,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFFF79635),),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(widget.content)
                    ],
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
