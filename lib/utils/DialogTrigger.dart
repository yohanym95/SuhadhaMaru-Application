import 'package:flutter/material.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/screens/login/LoginHome.dart';

Future<bool> dialogTrigger(BuildContext context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          content: Text('Are You Sure?'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Yes'),
              textColor: Colors.blue,
              onPressed: () {
                signOutGoogle();
                signOut().then((onValue) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (Route<dynamic> route) => false,
                  );
                });
              },
            )
          ],
        );
      });
}


