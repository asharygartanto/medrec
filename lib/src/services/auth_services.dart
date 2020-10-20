import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  static FirebaseAuth _auth = FirebaseAuth.instance;
  bool _success;
  String _userEmail;
/*
  static Future<User> signUp(String email, String password) async {
    try{
      UserCredential result = (await _auth.createUserWithEmailAndPassword(email: email, password: password));

       
      return result.user;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  static void register(String _email,String _pass) async {
    UserCredential user;
    try{
       user = await  _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _pass,
      );
    }
    catch(e){
      print(e.toString());
    }

  }

  static Future<UserCredential> signIn(String _email,String _pass)  async {
   Future <UserCredential> user;
    try{
       user =   _auth.signInWithEmailAndPassword(
        email: _email,
        password: _pass,
      ) ;
      return user;
    }
    catch(e){
      print(e.toString());
    }

  }

  static Future<void> signOut() async {
    _auth.signOut();
  }*/
}