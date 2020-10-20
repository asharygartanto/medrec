import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medrec/src/services/database_services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ViewRecordPage  extends StatefulWidget{
  final String recordid;

  const ViewRecordPage ({ Key key, this.recordid }): super(key: key);
  @override
  State createState() => new ViewRecordPageState();
}

class ViewRecordPageState extends State<ViewRecordPage> {
  

  @override
  Widget build (BuildContext ctxt) {
      return new Scaffold(
        appBar: AppBar(),
        body: 
         FutureBuilder(
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
                  return  Column(
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Inpatient or Outpatient',
                                prefixIcon: SizedBox(),
                              ),
                              controller: snap.data["inoroutpatient"],
                            ),
                            TextField(
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Anamnesis',
                                prefixIcon: Icon(Icons.text_fields),
                              ),
                              controller: snap.data["anamnesis"],
                            ),
                            
                            TextField(
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Physical Examination',
                                prefixIcon: Icon(Icons.text_fields),
                              ),
                              controller: snap.data["physicalExamination"],
                            ),
                            TextField(
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Diagnosis',
                                prefixIcon: Icon(Icons.text_fields),
                              ),
                              controller: snap.data["diagnosis"],
                            ),
                            TextField(
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Medical Treatment',
                                prefixIcon: Icon(Icons.text_fields),
                              ),
                              controller: snap.data["medicalTreatment"],
                            ),
                            TextField(
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Medicine',
                                prefixIcon: Icon(Icons.text_fields),
                              ),
                              controller: snap.data["medicine"],
                            ),
                            TextField(
                              maxLines: 1,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Doctor',
                                prefixIcon: Icon(Icons.person),
                              ),
                              controller: snap.data["docter"],
                            ),
                            TextField(
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Hospital / Clinic',
                                prefixIcon: Icon(Icons.local_hospital),
                              ),
                              controller: snap.data["hospital"],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 20.0, top: 15.0,bottom: 30),
                             ),
                          ],
                        );
                      
                }break;
                default:{

                }
                break;
          }

           },
           future: _getSickRecord(this.recordid),
           ),
      );
  }

  Future<List> _getSickRecord(String recordid) async {
    
   QuerySnapshot snapshot= await DatabaseServices.getSickRecord(recordid);
   //print(snapshot.docs);
   //snapshot.docs.forEach((res) {
   // print(res.data());
  //});
  //snapshot.docs.forEach((res) {
  //  print(res.data()["docter"]);
  //});
   return snapshot.docs;
      
  }
}
