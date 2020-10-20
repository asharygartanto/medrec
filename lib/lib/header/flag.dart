import 'package:flutter/material.dart';
import 'package:medrec/core/presentation/res/assets.dart';


class Item {
  const Item(this.name,this.icon);
  final String name;
  final CircleAvatar icon;
}

class Flag extends StatefulWidget {
  @override
  _FlagState createState() => _FlagState();
}

class _FlagState extends State<Flag> {
  List flags = [
    const Item('EN',CircleAvatar(
                backgroundColor: Color(0xFFE0E0E0),
                backgroundImage:  AssetImage(flag_uk),//NetworkImage(USER_IMAGE),
                radius: 7.0,
              ),),//Icon(Icons.android,)),
    const Item('IND',CircleAvatar(
                backgroundColor: Color(0xFFE0E0E0),
                backgroundImage:  AssetImage(flag_ind),//NetworkImage(USER_IMAGE),
                radius: 7.0,
              ),),
    
  ];

  @override
  Widget build(BuildContext context) {
    Item _value;
    return new Container(
      child:
      DropdownButton(
                  items: flags.map((Item ) {
                    return DropdownMenuItem(
                      value: _value,
                      child: Row(
                        children: [
                          Item.icon,
                          SizedBox(width: 7,
                          height: 7,
                          ),
                          Text(
                            Item.name,
                            style:  TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      value;
                    });
                  },
                )
    );
  }
}