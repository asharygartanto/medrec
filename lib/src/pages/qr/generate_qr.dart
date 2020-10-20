
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';



class GenerateQRScreen extends StatefulWidget {
  @override
  _GenerateQRScreenState createState() => _GenerateQRScreenState();
}

class _GenerateQRScreenState extends State<GenerateQRScreen> {
  String _code = "";
  @override
  Widget build(BuildContext context)  {
    _genCode().then((String result){
    setState(() {
      _code = result;
        });
    });
   
    final qrFutureBuilder = FutureBuilder(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = 140.0;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: _code,
            version: QrVersions.auto,
            color: Color(0xff000000),
            emptyColor: Color(0xffebebeb),
            // size: 320.0,
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.square(30),
            ),
          ),
        );
      },
    );

    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Container(
          height: 180,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    width: 140,
                    child: qrFutureBuilder,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                    .copyWith(bottom: 10),
                child: Text("User ID : "+_code,style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<String> _genCode() async{
    //final prefs = await SharedPreferences.getInstance();
    //String userId = prefs.getString('userid') ?? null;
    return ("David") ;
  } 

  Future<ui.Image> _loadOverlayImage() async {
    final completer = Completer<ui.Image>();
    final byteData = await rootBundle.load('assets/img/medical2.png');
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
}
