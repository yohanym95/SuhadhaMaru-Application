import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/main.dart';
import 'package:suhadhamaru/screens/LoginHome.dart';
import 'package:suhadhamaru/screens/login.dart';
import 'package:suhadhamaru/widgets/HomeLists.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String url = imageUrl;
  String name1 = name;
  String email1 = email;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('සුහඳ මාරු'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8, top: 13, bottom: 13),
            padding: EdgeInsets.all(3),
            child: FlatButton(
              color: Colors.pink[100],
              child: Text('LOGOUT'),
              onPressed: () {
                signOut().then((onValue) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (Route<dynamic> route) => false,
                  );
                });
              },
            ),
          )
        ],
        backgroundColor: Colors.pink[300],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text("$name1"),
              accountEmail: Text("$email1"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
              ),
            ),
            new ListTile(
              title: Text("Page one"),
              trailing: Icon(Icons.arrow_upward),
            ),
            new ListTile(
              title: Text("Page two"),
              trailing: Icon(Icons.arrow_upward),
            ),
            new ListTile(
              title: Text("Page three"),
              trailing: Icon(Icons.arrow_upward),
            ),
            new Divider(),
            new ListTile(
              title: Text(" Close"),
              trailing: Icon(Icons.close),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 75,
          ),
          homeList(context),
        ],
      ),
    );
  }
}
