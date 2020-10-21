import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:medrec/core/presentation/res/assets.dart';
import 'package:medrec/core/presentation/res/utisl.dart';
import 'package:medrec/core/presentation/widgets/moods.dart';
import 'package:medrec/lib/header/appheader.dart';
import 'package:medrec/src/services/database_services.dart';
import 'package:medrec/src/widgets/menu/bottomMenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String _name="";
  String _firstname="";
  String _doctorName="";
  

  /*void onTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }*/
  _MyHomePageState(){
    _getName().then((val) => setState(() {
          _name = val;
          _firstname=_name.split(" ")[0];
        }));

    _getLastVisitDoctor().then((value) => setState(() {
          _doctorName = value;
          
        }));

  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MedRecAppBar(),
      backgroundColor: mainBgColor,
      body: Container(
      height: media.height,
      width: media.width,
      child: Stack(
        children: <Widget>[
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.topCenter,
              overflow: Overflow.visible,
              children: <Widget>[
                _backBgCover(),
                _greetings(),
                _moodsHolder(),
                
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _notificationCard(),
                    _nextAppointmentText(),
                    _appoinmentCard(),
                    //_areaSpecialistsText(),
                    //_specialistsCardInfo(),
                    //_specialistsCardInfo(),
                    //_specialistsCardInfo(),

                    //_specialistsCardInfo(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
            bottom: 0,
            width: media.width,
            height: 70,
            child: BottomBar(activeInndex: 0 ,),
          ),
      /*bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                LineAwesomeIcons.home,
                size: 30.0,
              ),
              title: Text('1')),
          BottomNavigationBarItem(
              icon: Icon(
                LineAwesomeIcons.search,
                size: 30.0,
              ),
              title: Text('2')),
          BottomNavigationBarItem(
              icon: Icon(
                LineAwesomeIcons.gratipay,
                size: 30.0,
              ),
              title: Text('3')),
        ],
        onTap: onTapped,
      ),*/
        ]
      )
    ));
  }

  Positioned _moodsHolder() {
    return Positioned(
      bottom: -45,
      child: Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width - 40,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 5.5,
                blurRadius: 5.5,
              )
            ]),
        child:MoodsSelector(),
      ),
    );
  }

  Container _backBgCover() {
    return Container(
      height: 140.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        //gradient: purpleGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
    );
  }

  Positioned _greetings()  {
  //DocumentReference document =  FirebaseFirestore.instance
  //    .collection('userProfile').doc(FirebaseAuth.instance.currentUser.uid);
      //.where('id', isEqualTo: FirebaseAuth.instance.currentUser.uid)
      
    return Positioned(
      left: 20,
      bottom: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hi ' + _firstname,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'How are you today ?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _nextAppointmentText() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Your Next Appointment',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text(
            'See All',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: midColor,
            ),
          ),
        ],
      ),
    );
  }

  Container _appoinmentCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Color(0xFFD9D9D9),
                backgroundImage: new AssetImage(img_doctor2),//NetworkImage(USER_IMAGE),
                radius: 36.0,
              ),
              RichText(
                text: TextSpan(
                  text: 'Dr John',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '\nSunday,May 5th at 8:00 PM',
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: '\n570 Kyemmer Stores \nNairobi Kenya C -54 Drive',
                      style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Divider(
            color: Colors.grey[200],
            height: 3,
            thickness: 1,
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _iconBuilder(LineAwesomeIcons.check_circle, 'Check-in'),
              _iconBuilder(LineAwesomeIcons.times_circle, 'Cancel'),
             // _iconBuilder(LineAwesomeIcons.calendar_times_o, 'Calender'),
              _iconBuilder(LineAwesomeIcons.compass, 'Directions'),
            ],
          )
        ],
      ),
    );
  }

  Column _iconBuilder(icon, title) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          size: 28,
          color: Colors.black,
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Container _notificationCard() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue,
        // gradient: redGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          LineAwesomeIcons.calendar_check_o,
          color: Colors.white,
          size: 32,
        ),
        title: Text(
          'Your Last Visit with \nDr '+_doctorName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: OutlineButton(
          onPressed: () {},
          color: Colors.transparent,
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          child: Text(
            'See Detail',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  
  Future<String> _getName() async {
    
   DocumentSnapshot snapshot= await DatabaseServices.getUserProfile(FirebaseAuth.instance.currentUser.uid);
   print(snapshot.data()["fullname"]);
   return snapshot.data()["fullname"];
      
  }

  Future<String> _getLastVisitDoctor() async {
    
   QuerySnapshot snapshot= await DatabaseServices.getLastVisitDoctor(FirebaseAuth.instance.currentUser.uid);
   //print(snapshot.docs);
   //snapshot.docs.forEach((res) {
   // print(res.data());
  //});
  //snapshot.docs.forEach((res) {
  //  print(res.data()["docter"]);
  //});
   return snapshot.docs[0]["docter"].toString();
      
  }
  
}