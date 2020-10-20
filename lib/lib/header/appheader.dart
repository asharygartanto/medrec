import 'package:flutter/material.dart';
import 'package:medrec/lib/header/flag.dart';

import 'logout.dart';

class MedRecAppBar extends AppBar {
  MedRecAppBar()
      : super(
            elevation: 0.25,
            backgroundColor: Colors.blue,
            flexibleSpace: _buildAppBar(),
            automaticallyImplyLeading: false);

  //Widget build(BuildContext context) {
  static Widget _buildAppBar() {
    return new Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0,top: 30.0),
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  "",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                new Container(
                  child: new Row(
                    children: <Widget>[
                      /*IconButton(
                        icon: Icon(Icons.exit_to_app),
                        onPressed: (){

                        },
                      )*/
                      //QRMain(),
                      //Flag(),
                      Logout()
                      
                    ],
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
              ],
            )

            //UserNameHeader(),
          ],
        ));
  }

}
