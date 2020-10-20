import 'package:flutter/material.dart';
import 'package:medrec/src/pages/home/home.dart';
//import 'package:medrec/lib/pages/login/auth3.dart';
//import 'package:medrec/src/pages/login/login1.dart';
//import 'package:medrec/lib/pages/login/login5.dart';
import 'package:medrec/src/pages/login/login2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medrec/src/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

/*void main() => runApp(
      ChangeNotifierProvider<AuthService>(
        child: MyApp(),
        create: (BuildContext context) {
          return AuthService();
        },
        //builder: (BuildContext context) {
        //  return AuthService();
        //},
      ),
    );*/

    

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical Record',
      theme: new ThemeData(
        fontFamily: 'NeoSans',
        
      ),
      home: 
            // redirect to the proper page
             AuthService().getUser()!=null ? MyHomePage() : LoginTwoPage(),
          
        
      
      //new LoginTwoPage(),
    );
  }
}

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}