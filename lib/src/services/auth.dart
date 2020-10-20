import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/material.dart';


class AuthService with ChangeNotifier {
  

  ///
  /// return the Future with firebase user object FirebaseUser if one exists
  ///
  User getUser() {
    User user = FirebaseAuth.instance.currentUser;
    return user;
  }

  // wrapping the firebase calls
  Future logout()  {
    var result = FirebaseAuth.instance.signOut();
    notifyListeners();
    return result;
  }

  // wrapping the firebase calls
  Future<void> createUser(
      {String firstName,
      String lastName,
      String email,
      String password}) async {
        try{
          var r = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

        var u = r;
        //UserUpdateInfo info = UserUpdateInfo();
        //info.displayName = '$firstName $lastName';
        //return await u.user.updateProfile(info);
        return u.user;

        }on FirebaseAuthException catch (e) {
        print(e);
        return e;
      }catch (e){
        print(e);
      }
    
  }

  ///
  /// wrapping the firebase call to signInWithEmailAndPassword
  /// `email` String
  /// `password` String
  ///
  Future<void> loginUser({String email, String password}) async {
    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // since something changed, let's notify the listeners...
      notifyListeners();
      return result.user;
    } on FirebaseAuthException catch (e) {
      print(e);
      return e;
    }catch (e){
      print(e);
    }
  }
}
