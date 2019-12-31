import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/screens/HomePage.dart';
import 'package:suhadhamaru/screens/LoginHome.dart';
import 'package:suhadhamaru/screens/createProfile.dart';
import 'package:suhadhamaru/widgets/loader.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LandingPageState();
  }
}

class LandingPageState extends State<LandingPage> {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: mAuth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user == null) {
            return MyHomePage();
          } else {
            // print();
            if (user != null) {
              check(user);
            }
            //  else {
            //   return Scaffold(
            //     body: Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   );
            // }
          }
          return Loader();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  void check(FirebaseUser user) {
    DatabaseReference database =
        FirebaseDatabase.instance.reference().child('Users');

    database.once().then((DataSnapshot data) {
      //  var uId = user.uid;

      var Data1 = data.value.keys;
      String id = user.uid;
      // String url = user.photoUrl;

      if (user.photoUrl == null) {
        print('url ');
      } else {
        print('url : ${user.photoUrl}');
        imageUrl = user.photoUrl;
        name = user.displayName;
        email = user.email;
        userId = id;
      }

      print(Data1);

      for (var key in Data1) {
        print(key);
        if (key == id) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
          );
          print('homepage');
          break;
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Profile()),
            (Route<dynamic> route) => false,
          );
          print('profile');
        }
      }
    });
  }
}
