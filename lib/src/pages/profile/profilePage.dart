import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:medrec/src/pages/chart/bloodPresure.dart';
import 'package:medrec/src/pages/forms/blood_presure_input.dart';
import 'package:medrec/src/pages/profile/edit_profile.dart';
import 'package:medrec/src/pages/qr/generate_qr.dart';
import 'package:medrec/src/pages/qr/scan_qr.dart';
import 'package:medrec/src/services/database_services.dart';
import 'package:medrec/src/widgets/menu/bottomMenu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';


class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>{
  final datef = new DateFormat('dd-MMM-yyyy');

  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  String qrcode;
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return new Scaffold(
         appBar : new AppBar(
           title: Center(
             child :Text("Your Profile",)) ,
          //elevation: 0.7,
          backgroundColor:  Colors.blue,
          
         ),
        
        body: FutureBuilder(
          future: _getUserProfile(),
          builder: (context,snap){
            switch (snap.connectionState) {
                case ConnectionState.none: {

                } 
                break;        
                case ConnectionState.waiting:{
                  return LinearProgressIndicator();
                }
                break;
                case ConnectionState.done:{
                  String _height = " ";
                  String _weight = " ";
                  //if(snap.data["weight"]!=null)_weight=snap.data["weight"];
                  //if(snap.data["height"]!=null)_height=snap.data["weight"];
                  snap.data["weight"]!=null?_weight=snap.data["weight"]:_weight="";
                  snap.data["height"]!=null?_height=snap.data["height"]:_height="";
                  return SlidingUpPanel(
                    renderPanelSheet: false,
                    panel: _floatingPanel(),
                    collapsed: _floatingCollapsed(),
                    body: 

                          new Container(
                            color: Colors.white,
                          
                            child: Stack(
                              children: <Widget>[
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: 
                                    Column(
                                children: <Widget>[
                                  new Container(
                                    height: 250.0,
                                    color: Colors.white,
                                    child: new Column(
                                      children: <Widget>[
                                        
                                        Padding(
                                          padding: EdgeInsets.only(top: 30.0),
                                          child: new Stack(fit: StackFit.loose, children: <Widget>[
                                            new Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                new Container(
                                                    width: 140.0,
                                                    height: 140.0,
                                                    decoration: new BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: new DecorationImage(
                                                        image: new ExactAssetImage(
                                                            'assets/img/patient.png'),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(top: 70.0, right: 100.0),
                                                child: new Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    new CircleAvatar(
                                                      backgroundColor: Colors.red,
                                                      radius: 25.0,
                                                      child: new Icon(
                                                        Icons.camera_alt,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ]),
                                        )
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    color: Color(0xffFFFFFF),
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 125.0),
                                      child: new Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0,),
                                              child: new Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      new Text(
                                                        'Parsonal Information',
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                  new Column(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      _status ? _getEditIcon() : new Container(),
                                                    ],
                                                  )
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 25.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      new Text(
                                                        'Name',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 2.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Flexible(
                                                    child: new TextField(
                                                      decoration: const InputDecoration(
                                                        hintText: "Enter Your Name",
                                                      ),
                                                      enabled: !_status,
                                                      autofocus: !_status,
                                                      controller: TextEditingController(text: snap.data["fullname"]),

                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 25.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      new Text(
                                                        'Place of Birth',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 2.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Flexible(
                                                    child: new TextField(
                                                      decoration: const InputDecoration(
                                                          hintText: "Enter Place of Birth"),
                                                      enabled: !_status,
                                                      controller: TextEditingController(text: snap.data["placeofbirth"]),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 25.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      new Text(
                                                        'Date of Birth',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 2.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Flexible(
                                                    child: new TextField(
                                                      decoration: const InputDecoration(
                                                          hintText: "Enter Date of Birth"),
                                                      enabled: !_status,
                                                      controller: snap.data["dateofbirth"]!=null?TextEditingController(text:datef.format(DateTime.parse(snap.data["dateofbirth"].toDate().toString()) )):TextEditingController(text:""),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 25.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      new Text(
                                                        'National Identity Number (KTP)',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 2.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Flexible(
                                                    child: new TextField(
                                                      decoration: const InputDecoration(
                                                          hintText: "Enter Identity Number (KTP)"),
                                                      enabled: !_status,
                                                      controller: TextEditingController(text:snap.data["ktp"].toString() ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 25.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      new Text(
                                                        'Address',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 2.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Flexible(
                                                    child: new TextField(
                                                      decoration: const InputDecoration(
                                                          hintText: "Enter Adress"),
                                                      enabled: !_status,
                                                      controller: TextEditingController(text: snap.data["address"]),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 25.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      new Text(
                                                        'Mobile',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 2.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Flexible(
                                                    child: new TextField(
                                                      decoration: const InputDecoration(
                                                          hintText: "Enter Mobile Number"),
                                                      enabled: !_status,
                                                      controller: TextEditingController(text: snap.data["phone"]),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 25.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Container(
                                                      child: new Text(
                                                        'Blood Type',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                    flex: 2,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: new Text(
                                                        'Height/Weight',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                    flex: 2,
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 2.0,bottom: 30),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(right: 10.0),
                                                      child: new TextField(
                                                        decoration: const InputDecoration(
                                                            hintText: "Blood Type"),
                                                        enabled: !_status,
                                                        controller: TextEditingController(text: snap.data["bloodtype"]),
                                                      ),
                                                    ),
                                                    flex: 2,
                                                  ),
                                                  Flexible(
                                                    child: new TextField(
                                                      decoration: const InputDecoration(
                                                          hintText: "Height/Weight"),
                                                      enabled: !_status,
                                                     controller: TextEditingController(text: _height+"/"+_weight),
                                                    ),
                                                    flex: 2,
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 25.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      new Text(
                                                        'Allergic',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 2.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  new Flexible(
                                                    child: new TextField(
                                                      decoration: const InputDecoration(
                                                          hintText: "Enter allergic"),
                                                      enabled: !_status,
                                                      controller: TextEditingController(text: snap.data["allergic"]),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 25.0),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Container(
                                                      child: new Text(
                                                        'Emergency Contact Name',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                    flex: 2,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: new Text(
                                                        'Emergency Contact No',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                    flex: 2,
                                                  ),
                                                ],
                                              )),
                                          
                                              Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 25.0, top: 2.0,bottom: 30),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(right: 10.0),
                                                      child: new TextField(
                                                        decoration: const InputDecoration(
                                                            hintText: "Name"),
                                                        enabled: !_status,
                                                        controller: TextEditingController(text: snap.data["emergencycontactname"]),
                                                      ),
                                                    ),
                                                    flex: 2,
                                                  ),
                                                  Flexible(
                                                    child: new TextField(
                                                      decoration: const InputDecoration(
                                                          hintText: "Phone Number"),
                                                      enabled: !_status,
                                                      controller: TextEditingController(text: snap.data["emergencycontactnumber"]),
                                                    ),
                                                    flex: 2,
                                                  ),
                                                  //
                                                  
                                                ],
                                              )),
                                              //
                                              Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0, right: 20.0, top: 15.0,bottom: 30),
                                              child: new Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(right: 5.0),
                                                      child: new OutlineButton(
                                                        child: new Text("Blood Presure History"),
                                                        onPressed: (){
                                                          Navigator.push(context, MaterialPageRoute(
                                                            builder: (BuildContext context) => BloodPresureInput()
                                                          ));},
                                                        borderSide: BorderSide(
                                                          color: Colors.red, //Color of the border
                                                          style: BorderStyle.solid, //Style of the border
                                                          width: 0.8, //width of the border
                                                        ),
                                                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                                                      )/*new TextField(
                                                        decoration: const InputDecoration(
                                                            hintText: "Name"),
                                                        enabled: !_status,
                                                      ),*/
                                                    ),
                                                    flex: 2,
                                                  ),
                                                  /*Flexible(
                                                    child: new TextField(
                                                      decoration: const InputDecoration(
                                                          hintText: "Phone Number"),
                                                      enabled: !_status,
                                                    ),
                                                    flex: 2,
                                                  ),*/
                                                  
                                                ],
                                              )),
                                              //
                                          !_status ? _getActionButtons() : new Container(),
                                          
                                        ],
                                      ),
                                      
                                    ),
                                    
                                  ),
                                  
                                
                                ],
                              ),)
                                ),
                                Positioned(
                                bottom: 0,
                                width: media.width,
                                height: 70,
                                child: BottomBar(activeInndex: 3 ,),
                              ),
                              ],)
                            
                          )
                      );


                }
              case ConnectionState.active:
                // TODO: Handle this case.
                break;
            }
          }
          ),
        
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) => EditProfilePage()
                                ));
        /*setState(() {
          _status = false;
        });*/
      },
    );
  }

  Widget _floatingPanel(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.grey,
          ),
        ]
      ),
      margin: const EdgeInsets.all(24.0),
      child: 
         Column(
           //crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child:GenerateQRScreen(),
            ),
            
            Padding(padding: EdgeInsets.all(20)),
            FlatButton(
              onPressed: () async {
                try {
                    ScanResult barcode = await BarcodeScanner.scan();
                    setState(() {
                      this.qrcode = barcode.toString();
                    });
                  } on PlatformException catch (error) {
                    if (error.code == BarcodeScanner.cameraAccessDenied) {
                      setState(() {
                        this.qrcode = 'camera not allowed from user';
                      });
                    } else {
                      setState(() {
                        this.qrcode = 'Error: $error';
                      });
                    }
                  }
               /* Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => QRScanPage()
                ));*/
              }, 
              child: Text("Scan QR : $qrcode"),
              color: Colors.blue[100],
              )
          ],
        //)
        
        /*Text(
          "This is the floating Widget",
          style: TextStyle(color: Colors.white),
        )*///Image.asset("assets/icon/icon_scan.png"),
      ),
    );
  }

  Widget _floatingCollapsed(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
      child: Center(
        child: Column(
          children: [
            Image.asset("assets/icon/icon_scan.png",scale: 5,),
            Text(
              "Swipe up and Scan Me",
              style: TextStyle(color: Colors.white),
            ),
            
          ],
        )
        
        /**/,
      ),
    );
  }

  Future<DocumentSnapshot> _getUserProfile() async {
    
   DocumentSnapshot snapshot= await DatabaseServices.getUserProfile(FirebaseAuth.instance.currentUser.uid);
   //print(snapshot.data());
   return snapshot;
      
  }
}
