import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/screens/HomePage.dart';

class UserManagement {
  Future<bool> addData(userData, userId, context) async {
    FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(userId)
        .set(userData)
        .then((onValue) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
      return false;
    }).catchError((onError) {
      return false;
    });

    return false;
  }

  Future<bool> addPost(postData, postcategory, context) async {
    FirebaseDatabase.instance
        .reference()
        .child('Posts')
        .child(postcategory)
        .push()
        .set(postData)
        .then((onValue) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
      return false;
    }).catchError((onError) {
      return false;
    });

    return false;
  }
}
