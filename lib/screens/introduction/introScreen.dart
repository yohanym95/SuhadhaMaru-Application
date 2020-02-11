import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:suhadhamaru/screens/login/LoginHome.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  //SharedPrefHelper sharedPrefHelper;
  @override
  void initState() {
    super.initState();
  }

  final pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontFamily: 'coiny',
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Colors.blue[800],
      ),
      bodyTextStyle:
          TextStyle(fontFamily: 'coiny', fontSize: 19, color: Colors.grey),
      contentPadding: const EdgeInsets.all(10));

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        title: 'Sharing Your Posts',
        image: Image.asset("assests/introduction/share_article.png"),
        body: 'Sharing Your Mutual Job Transfer Posts!',
        footer: Text(
          'Suhadha - Maru',
          style: TextStyle(color: Colors.black),
        ),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: 'Get Notification',
        image: Image.asset("assests/introduction/get_notification.png"),
        body: 'Get Notification about posts!',
        footer: Text(
          'Suhadha - Maru',
          style: TextStyle(color: Colors.black),
        ),
        decoration: pageDecoration,
      ),
      PageViewModel(
        image: Image.asset("assests/introduction/get_solutions.png"),
        title: 'Get Solutions',
        body: 'Get the solution for your problem!',
        footer: Text(
          'Suhadha - Maru',
          style: TextStyle(color: Colors.black),
        ),
        decoration: pageDecoration,
      ),
      PageViewModel(
        image: Image.asset("assests/introduction/team_solutions.png"),
        title: 'Team Work',
        body: 'People can get the solutions by work as team!',
        footer: Text(
          'Suhadha - Maru',
          style: TextStyle(color: Colors.black),
        ),
        decoration: pageDecoration,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: getPages(),
        next: const Icon(Icons.navigate_next),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        onDone: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('install', "Yes");
          setState(() {
            //  sharedPrefHelper.addinstall();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
              (Route<dynamic> route) => false,
            );
          });
        },
      ),
    ));
  }
}
