import 'package:flutter/material.dart';
import 'package:medrec/src/pages/login/login2.dart';
import 'package:medrec/src/services/auth.dart';
import 'package:medrec/src/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 28.0,
        width: 28.0,
        padding: EdgeInsets.all(6.0),
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(100.0)),
            color: Colors.red),
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Do you really want to logout ?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("No"),
                      onPressed: () => Navigator.pop(context,false),
                    ),
                    FlatButton(
                      child: Text("Yes"),
                      onPressed: ()  {
                        AuthService().logout();
                         Navigator.pop(context);
                         //AuthServices.signOut();
                         
                        //final prefs = await SharedPreferences.getInstance();

                       /* prefs.remove('orgid');
                        prefs.remove('roleid');
                        prefs.remove('userid');
                        prefs.remove('usermgmtid');
                        prefs.remove('email');*/
                       // HubConnection _hubConnection;
                        //ChatPageViewModel _signalRvm = new ChatPageViewModel();
                        /*_signalRvm.closeChatConnection();
                        if (_hubConnection == null) {
                          _hubConnection = HubConnectionBuilder()
                              .withUrl(kChatServerUrl + "/notificationHub")
                              .build();
                        }*/
                        //_hubConnection.off("ReceiveMessage");
                        //await _hubConnection.stop().then((func) {
                           Navigator.push(context, MaterialPageRoute(
                            builder: (BuildContext context) => LoginTwoPage()
                          ));
                         // Navigator.pushAndRemoveUntil(
                         //     context,
                         //     MaterialPageRoute(
                         //         builder: (context) => LoginForm()),(Route<dynamic> route) => false);
                        //})
                      },
                    ),
                  ],
                )
            );
//            Alert(
//              context: context,
//              title: 'Log Out',
//              desc: "Are you sure to log out?",
//              buttons: [
//                DialogButton(
//                  onPressed: () async {
//                    final prefs = await SharedPreferences.getInstance();
//
//                    prefs.remove('orgid');
//                    prefs.remove('roleid');
//                    prefs.remove('userid');
//                    prefs.remove('usermgmtid');
//                    prefs.remove('email');
//                    HubConnection _hubConnection;
//                    ChatPageViewModel _signalRvm = new ChatPageViewModel();
//                    _signalRvm.closeChatConnection();
//                    if (_hubConnection == null) {
//                      _hubConnection = HubConnectionBuilder()
//                          .withUrl(kChatServerUrl + "/notificationHub")
//                          .build();
//                    }
//                    _hubConnection.off("ReceiveMessage");
//                    await _hubConnection.stop().then((func) {
//                      Navigator.pushAndRemoveUntil(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => LoginScreenDeepsea()),(Route<dynamic> route) => false);
//                    });
//                  },
//                  child: Text(
//                    "Ok",
//                    style: TextStyle(color: Colors.white, fontSize: 20),
//                  ),
//                )
//              ],
//            ).show();
            //locator<NavigationService>().navigateTo('login');
          },
          child: new Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 16.0,
          ),
        ));
    //)
    /*InkWell(
          onTap: () {
            Alert(
              context: context,
              title: 'Log Out',
              desc: "Anda yakin akan Log Out?",
              buttons: [
                DialogButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreenDeepsea())),
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            );
            //locator<NavigationService>().navigateTo('login');
          },
          child: new Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 16.0,
          ),
        ));*/
  }
}
