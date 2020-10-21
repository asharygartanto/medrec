import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medrec/src/pages/doctors/doctorList.dart';
import 'package:medrec/src/pages/forms/add_record.dart';
import 'package:medrec/src/pages/history/mainHistory.dart';
import 'package:medrec/src/pages/history/sick_list_stateful.dart';
import 'package:medrec/src/pages/home/home.dart';
import 'package:medrec/src/pages/profile/profilePage.dart';

//Color color = Colors.blue;

Color color = Color(0xff59c2ff);

class BottomBar extends StatefulWidget {
  final Function(int index) onChangeActiveTab;
  final int activeInndex;

  const BottomBar({Key key, this.onChangeActiveTab, this.activeInndex})
      : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _activeInndex;

  @override
  void initState() {
    super.initState();
    _activeInndex = widget.activeInndex;
  }

  @override
  Widget build(BuildContext context) {
    String _colorName = 'No';
  Color _color = Colors.black;
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          child: new BottomAppBar(
            //elevation: 3,
            child: Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _getBottomBarItem(
                    context: context,
                    index: 0,
                    icon: Icons.home,
                    
                  ),
                  _getBottomBarItem(
                    context: context,
                    index: 1,
                    icon: Icons.history,
                  ),
                  new Container(width: MediaQuery.of(context).size.width / 5),
                  _getBottomBarItem(
                    context: context,
                    index: 2,
                    icon: Icons.search,
                    
                  ),
                  _getBottomBarItem(
                    context: context,
                    index: 3,
                    icon: Icons.account_circle,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              onPressed: (){
              _newTaskModalBottomSheet(context);
            },
            child: new Icon(Icons.add),
            )
          )
        ),
        /*Positioned(
          bottom: 10,
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              child: CircularMenu(
                startingAngleInRadian: 30,
                
                  //alignment: Alignment.bottomCenter,
                  backgroundWidget: Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 28),
                        children: <TextSpan>[
                          TextSpan(
                            text: _colorName,
                            style:
                                TextStyle(color: _color, fontWeight: FontWeight.bold),
                          ),
                          //TextSpan(text: ' button is clicked.'),
                        ],
                      ),
                    ),
                  ),
                  toggleButtonColor: Colors.pink,
                  items: [
                    CircularMenuItem(
                        icon: Icons.home,
                        color: Colors.green,
                        onTap: () {
                          setState(() {
                            _color = Colors.green;
                            _colorName = 'Green';
                          });
                        }),
                    CircularMenuItem(
                        icon: Icons.search,
                        color: Colors.blue,
                        onTap: () {
                          setState(() {
                            _color = Colors.blue;
                            _colorName = 'Blue';
                          });
                        }),
                    CircularMenuItem(
                        icon: Icons.settings,
                        color: Colors.orange,
                        onTap: () {
                          setState(() {
                            _color = Colors.orange;
                            _colorName = 'Orange';
                          });
                        }),
                    /*CircularMenuItem(
                        icon: Icons.chat,
                        color: Colors.purple,
                        onTap: () {
                          setState(() {
                            _color = Colors.purple;
                            _colorName = 'Purple';
                          });
                        }),
                    CircularMenuItem(
                        icon: Icons.notifications,
                        color: Colors.brown,
                        onTap: () {
                          setState(() {
                            _color = Colors.brown;
                            _colorName = 'Brown';
                          });
                        })*/
                  ],
                ),)
            
          ),
        ),*/
      ],
    );
  }

  Widget _getBottomBarItem({BuildContext context, int index, IconData icon}) {
    double itemWidth = MediaQuery.of(context).size.width / 5;
    double iconSize = 30.0;
    return new Container(
      width: itemWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            child: Icon(
              icon,
              size: iconSize,
              color: _getItemColor(index: index),
            ),
            onTap: () {
              if (index != _activeInndex) {
                setState(() {
                  _activeInndex = index;
                  widget.onChangeActiveTab(index);
                  
                });
              }
              else {
                if(index==0){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => MyHomePage()
                    ));
                  }
                if(index==1){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => MainHistory()
                  ));
                }
                if(index==2){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => MyDoctorListPage()
                    ));
                  }
                if(index==3){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => ProfilePage()
                    ));
                  }
                 // widget.onChangeActiveTab(index);
              }
            },
          ),
          Visibility(
            visible: index == _activeInndex,
            child: Container(
              width: 10,
              height: 2,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getItemColor({int index}) {
    return index == _activeInndex ? color : Colors.grey[300];
  }


  void _newTaskModalBottomSheet(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
          return Container(
            child: new Wrap(
            children: <Widget>[
          new ListTile(
            leading: new Icon(Icons.note_add),
            title: new Text('Add Record'),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => AddMedicalReCordPage()
                  ))
            }          
          ),
          new ListTile(
            leading: new Icon(Icons.history),
            title: new Text('Record History'),
            onTap: () => {
               Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => SicksList2Page()
                  ))
            },          
          ),
          new ListTile(
            leading: new Icon(Icons.calendar_today),
            title: new Text('Add Schedule'),
            onTap: () => {
               Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => MyDoctorListPage()
                  ))
            },          
          ),
            ],
          ),
          );
      }
    );
}
}