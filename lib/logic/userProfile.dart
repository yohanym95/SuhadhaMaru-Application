import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/screens/HomePage/Homepage1.dart';

class UserManagement {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  Future<bool> createProfile(userData, userId, context) async {
    FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(userId)
        .set(userData)
        .then((onValue) {
      FirebaseDatabase.instance
          .reference()
          .child('Notification')
          .child(userId)
          .set({'Postsubscribe': 'Yes', 'AppUpdateSubscribe': 'Yes'}).then(
              (onValue) {
        firebaseMessaging.subscribeToTopic('Post');
        firebaseMessaging.subscribeToTopic('AppUpdate');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePages()),
          (Route<dynamic> route) => false,
        );
        return false;
      });
    }).catchError((onError) {
      return false;
    });

    return false;
  }

  Future<bool> editProfile(userData, userId, context) async {
    FirebaseDatabase.instance
        .reference()
        .child('Users')
        .child(userId)
        .set(userData)
        .then((onValue) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePages()),
        (Route<dynamic> route) => false,
      );
      return false;
    }).catchError((onError) {
      return false;
    });

    return false;
  }
}
