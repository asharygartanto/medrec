import 'package:flutter/material.dart';
import 'package:medrec/core/presentation/res/assets.dart';
import 'package:medrec/src/pages/forms/add_record.dart';
import 'package:medrec/src/services/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class SicksList2Page  extends StatefulWidget{
  @override
  State createState() => new SicksList2PageState();
}

class SicksList2PageState extends State<SicksList2Page> {

//List listSicks;
final datef = new DateFormat('dd-MMM-yyyy hh:mm');
  /*SicksList2PageState(){
     _getUserDataRecord().then((value) => setState(() {
          listSicks = value;
          
       }));

  }*/

  @override
  Widget build (BuildContext ctxt) {
      return new Scaffold(
        appBar: AppBar(),

      body: FutureBuilder(
        builder: (context,i){
          List x=i.data;
          switch (i.connectionState) {
                    case ConnectionState.none: {

                    } 
                    break;        
                    case ConnectionState.waiting:{
                      return CircularProgressIndicator();
                    }
                    break;
                    case ConnectionState.done:{

                    }break;
                    default:{

                    }
                    break;
          }
          return ListView.builder(
            itemCount: x.length,
            itemBuilder: (context, index) {
              return FutureBuilder(
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:          
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    case ConnectionState.done:{
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {

                        var sickInfo = snapshot.data;

                        return Card(
                          child: ListTile(
                          leading: sickInfo[index]["inoroutpatient"]=="Outpatient"? CircleAvatar(
                            backgroundImage: AssetImage(img_doctor2)) : CircleAvatar(
                            backgroundImage: AssetImage(img_hospital2),
                          ),
                          title: Text('${sickInfo[index]["anamnesis"]}'),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) => AddMedicalReCordPage()
                                ));
                          },
                          subtitle: Text(
                            datef.format(DateTime.parse('${sickInfo[index]["time1"].toDate()}')).toString() + ' - Dr. ${sickInfo[index]["docter"]}'
                          ),
                          trailing: Icon(Icons.more),
                          isThreeLine: true,
                          ),
                        );
                      }
                  }
                  break;
                  default:{}
                      break;
                }
                },
                future: _getUserDataRecord(),
                );
            }
      );
        },
        future: _getUserDataRecord(),
      )
      
      );
       
  }

  Future<List> _getUserDataRecord() async {
    
   QuerySnapshot snapshot= await DatabaseServices.getUserDataRecord(FirebaseAuth.instance.currentUser.uid);
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