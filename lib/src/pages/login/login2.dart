/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:medrec/core/presentation/res/assets.dart';
import 'package:medrec/src/pages/home/home.dart';
import 'package:medrec/src/pages/login/signup1.dart';
import 'package:medrec/src/services/auth.dart';
import 'package:medrec/src/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoginTwoPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passController = TextEditingController(text: "");
  String _password;
  String _email;
  final _formKey = GlobalKey<FormState>();

  static final String path = "lib/src/pages/login/login2.dart";
  Widget _buildPageContent(BuildContext context) {
    return Container(
      color: Colors.blue.shade100,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          CircleAvatar(
            child: new Image(
                width: 110.0,
                height: 110.0,
                fit: BoxFit.fill,
                image: new AssetImage(img_medical3)),
            maxRadius: 50,
            backgroundColor: Colors.transparent,
          ),
          //CircleAvatar(child: PNetworkImage(origami), maxRadius: 50, backgroundColor: Colors.transparent,),
          SizedBox(
            height: 20.0,
          ),
          _buildLoginForm(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SignupOnePage()));
                },
                child: Text("Sign Up",
                    style: TextStyle(color: Colors.blue, fontSize: 18.0)),
              )
            ],
          )
        ],
      ),
    );
  }

  Container _buildLoginForm(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: RoundedDiagonalPathClipper(),
                child: Container(
                  height: 400,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 90.0,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                                hintText: "Email address",
                                hintStyle:
                                    TextStyle(color: Colors.blue.shade200),
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.blue,
                                )),
                            onSaved: (value) => _email = value,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                          )),
                      Container(
                        child: Divider(
                          color: Colors.blue.shade400,
                        ),
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10.0),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.blue),
                            decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle:
                                    TextStyle(color: Colors.blue.shade200),
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.blue,
                                )),
                            onSaved: (value) => _password = value,
                            obscureText: true,
                            controller: passController,
                          )),
                      Container(
                        child: Divider(
                          color: Colors.blue.shade400,
                        ),
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(color: Colors.black45),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Medical Record",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w700,
                        fontSize: 30),
                  ),
                  /*CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.blue.shade600,
                    child: Icon(Icons.person),
                  ),*/
                  Padding(padding: EdgeInsets.all(5))
                ],
              ),
              Container(
                height: 420,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    onPressed: () async {
                      /* Future<UserCredential> user;
                      user =   AuthServices.signIn(emailController.text, passController.text) ;
                      if(user!=null){
                        Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePage()
                      ));
                      }
                      else{
                        print(user);
                      
                      }*/

                      final form = _formKey.currentState;
                      form.save();
                      if (form.validate()) {
                        try {
                          var result = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _email, password: _password)
                              .catchError((e) {
                            _buildErrorDialog(context, e.message);
                          });
                          // since something changed, let's notify the listeners...
                          //notifyListeners();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MyHomePage()));
                        } on FirebaseAuthException catch (e) {
                          print(e);
                          _buildErrorDialog(context, e.message);
                        } catch (e) {
                          print(e);
                          _buildErrorDialog(context, e.message);
                        }
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    child:
                        Text("Login", style: TextStyle(color: Colors.white70)),
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(context),
    );
  }

  Future _buildErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}
