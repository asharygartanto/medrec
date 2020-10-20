import 'package:flutter/material.dart';
import 'package:medrec/core/presentation/res/assets.dart';
import 'package:medrec/src/pages/forms/add_record.dart';
import 'package:medrec/src/services/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SicksListPage  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Card(
            child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(img_doctor2),
            ),
            title: Text('Flu'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => AddMedicalReCordPage()
                  ));
            },
            subtitle: Text(
              '20 Aug 2019 - Dr. John'
            ),
            trailing: Icon(Icons.more),
            isThreeLine: true,
            ),
          ),
          Card(
            child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(img_doctor2),
            ),
            title: Text('Migrain'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => AddMedicalReCordPage()
                  ));
            },
            subtitle: Text(
              '1 Oct 2019 - Dr. Doe'
            ),
            trailing: Icon(Icons.more),
            isThreeLine: true,
            ),
          ),
          Card(
            child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(img_doctor2),
            ),
            title: Text('Fever'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => AddMedicalReCordPage()
                  ));
            },
            subtitle: Text(
              '10 Nov 2019 - Dr. Zhu'
            ),
            trailing: Icon(Icons.more),
            isThreeLine: true,
            ),
          ),
          Card(
            child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(img_doctor2),
            ),
            title: Text('Fever'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => AddMedicalReCordPage()
                  ));
            },
            subtitle: Text(
              '2 Feb 2020 - Dr. John'
            ),
            trailing: Icon(Icons.more),
            isThreeLine: true,
            ),
          ),
          Card(
            child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(img_doctor2),
            ),
            title: Text('Magh'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => AddMedicalReCordPage()
                  ));
            },
            subtitle: Text(
              '6 May 2020 - Dr. Doe'
            ),
            trailing: Icon(Icons.more),
            isThreeLine: true,
            ),
          ),
          Card(
            child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(img_hospital2),
            ),
            title: Text('Typhus'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => AddMedicalReCordPage()
                  ));
            },
            subtitle: Text(
              '7 Jul 2020 - Bethsaida Hospital'
            ),
            trailing: Icon(Icons.more),
            isThreeLine: true,
            ),
          ),
          Card(
            child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(img_doctor2),
            ),
            title: Text('Fever'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => AddMedicalReCordPage()
                  ));
            },
            subtitle: Text(
              '9 Sep - Dr. Zhu'
            ),
            trailing: Icon(Icons.more),
            isThreeLine: true,
            ),
          ),
        ],
      ),
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