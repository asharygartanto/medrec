
import 'dart:async';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';


class CircularMenu2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      //title: 'QRCode Reader Demo',
      home: new CircularMenuPage(),
    );
  }
}

class CircularMenuPage extends StatefulWidget {
  CircularMenuPage({Key key, this.title}) : super(key: key);

  final String title;

  

  @override
  _CircularMenuPageState createState() => new _CircularMenuPageState();
}

class _CircularMenuPageState extends State<CircularMenuPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FabCircularMenu(
        ringDiameter: 340,
        ringWidth: 36,
        ringColor: Colors.red[300],
        fabCloseColor: Colors.red[300],
        fabOpenColor: Colors.red[300],
        fabColor: Colors.white,
          children: <Widget>[
            IconButton(icon: Icon(Icons.add_a_photo,color: Colors.white,), onPressed: () {
              
            }),
            IconButton(icon: Icon(Icons.add_a_photo,color: Colors.white,), onPressed: () {
            //new Image.asset("assets/icons/icon_scan.png"),onPressed: () {//Icon(Icons.code), onPressed: () {
               
              
            })
          ]
        )
      
    );
  }
}
