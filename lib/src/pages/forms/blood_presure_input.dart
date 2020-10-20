import 'package:flutter/material.dart';
import 'package:medrec/src/pages/chart/bloodPresure.dart';

class BloodPresureInput extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Padding(padding: EdgeInsets.only(top: 140.0)),
          new Text('Your Blood Presure Today is?',
            style: new TextStyle(color: Colors.blue, fontSize: 25.0),),
          new Padding(padding: EdgeInsets.only(top: 50.0)),
          new TextFormField(
            decoration: new InputDecoration(
            labelText: "Enter Your Blood Presure",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
          ),
        ),
        OutlineButton(
        child: new Text("Save"),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => BloodPresureChart()
          ));},
        borderSide: BorderSide(
          color: Colors.red, //Color of the border
          style: BorderStyle.solid, //Style of the border
          width: 0.8, //width of the border
        ),
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
        )
        ],
      ),
    );
  }

}