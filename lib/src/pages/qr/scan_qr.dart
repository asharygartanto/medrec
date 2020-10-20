
import 'dart:async';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';


class ScanCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      //title: 'QRCode Reader Demo',
      home: new QRScanPage(),
    );
  }
}

class QRScanPage extends StatefulWidget {
  QRScanPage({Key key, this.title}) : super(key: key);

  final String title;

  final Map<String, dynamic> pluginParameters = {
  };

  @override
  _QRScanPageState createState() => new _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  Future<String> _barcodeString;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Silakan Scan QR Code'),
        backgroundColor: Colors.blue,
        
      ),
      body: new Center(
          child: new FutureBuilder<String>(
              future: _barcodeString,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return new Text(snapshot.data != null ? snapshot.data : '',style: new TextStyle(
                    color: Colors.black87,
                    fontFamily: "NeoSansBold",
                    fontSize: 18.0));
              })) ,
      
      
    );
  }
}
