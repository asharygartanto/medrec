import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:medrec/core/presentation/res/assets.dart';
import 'package:medrec/core/presentation/res/utisl.dart';
import 'package:medrec/src/pages/book/book_the_date.dart';
import 'package:medrec/src/widgets/menu/bottomMenu.dart';

class MyDoctorListPage extends StatefulWidget {
  MyDoctorListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyDoctorListPageState createState() => _MyDoctorListPageState();
}

class _MyDoctorListPageState extends State<MyDoctorListPage> {
  int _selectedIndex = 2;
  

  /*void onTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainBgColor,
      body: Container(
      height: media.height,
      width: media.width,
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _areaSpecialistsText(),
                    _specialistsCardInfo(),
                    _specialistsCardInfo(),
                    _specialistsCardInfo(),
                    _specialistsCardInfo(),
                  ],
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            width: media.width,
            height: 70,
            child: BottomBar(activeInndex: 2 ,),
          ),
        ]
      )
      )
    );
  }

  Widget _areaSpecialistsText() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Specialist In Your Area',
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

  Widget _specialistsCardInfo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 18.0),
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1.0,
              blurRadius: 6.0,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Color(0xFFD9D9D9),
                backgroundImage: new AssetImage(img_doctor2),//NetworkImage(USER_IMAGE),
                radius: 36.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: 'Wellness\n',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Dr Ayor Kruger',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '\nPoplar Pharma Limited',
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text: '\nDermatologist \nSAn Franscisco CA | 5 min',
                          style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) => BookDateTimePage()
                      ));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: purpleGradient,
                        borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                            minWidth: 88.0,
                            minHeight: 36.0), // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: const Text(
                          'Book Visit',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          /*Icon(
            LineAwesomeIcons.heart,
            color: lightColor,
            size: 36,
          ),*/
        ],
      ),
    );
  }
}