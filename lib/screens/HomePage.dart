import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/main.dart';
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
  String userId;

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    Auth().getCurrentUser().then((user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
          (Route<dynamic> route) => false,
        );
      } else {
        userId = user.uid;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('සුහඳ මාරු'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: "Logout",
            onPressed: () async {
              Auth().signOut().then((onValue) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (Route<dynamic> route) => false,
                );
              });
            },
          ),
        ],
        backgroundColor: Colors.pink[300],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text("Yohan Malshika"),
              accountEmail: Text("Birthday Finder"),
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
