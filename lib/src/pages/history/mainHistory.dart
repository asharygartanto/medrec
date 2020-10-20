import 'package:flutter/material.dart';
import 'package:medrec/src/pages/history/inpatientHistory.dart';
import 'package:medrec/src/pages/history/outpatientHistory.dart';
import 'package:medrec/src/widgets/menu/bottomMenu.dart';

class MainHistory extends StatefulWidget {
  @override
  _MainHistoryState createState() => _MainHistoryState();
}

class _MainHistoryState extends State<MainHistory>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 2);
    _tabController.addListener(_handleTabIndex);
    
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
        appBar: new AppBar(
          //elevation: 0.7,
          backgroundColor:  Colors.blue,
          bottom: new TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              new Tab(text: "Inpatient"),
              new Tab(text: "Outpatient"),
            ],
          ),
          actions: <Widget>[
            new Icon(Icons.search),
            new Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
            ),
            //new Icon(Icons.more_vert),
          ],
        ),
        body: new Container(
          height: media.height,
          width: media.width,
          child: new TabBarView(
              controller: _tabController,
              children: <Widget>[
                new MyInpatientListPage(),
                new MyOutpatientListPage(),
                //new CameraScreen(),
                //new ChatsScreen(),
                //new StatusScreen(),
                //new CallsScreen(),
                /*Positioned(
                bottom: 0,
                width: media.width,
                height: 70,
                child: BottomBar(activeInndex: 1 ,),
              ),*/
              ],
            ),
          )
        
        
        );
  }

  void _handleTabIndex() {
    setState(() {});
  }

  
  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    
    super.dispose();
  }
}