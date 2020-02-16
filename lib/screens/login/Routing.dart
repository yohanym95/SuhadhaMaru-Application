import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suhadhamaru/screens/introduction/introScreen.dart';
import 'package:suhadhamaru/screens/login/LandingPage.dart';

class Routing extends StatefulWidget {
  @override
  _RoutingState createState() => _RoutingState();
}

class _RoutingState extends State<Routing> {
  var stringValue;
  String installValue;
  Future<void> getInstallValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('install');
    print('${prefs.getString('install')}');
    if (stringValue.toString() != 'Yes') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => IntroScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
        (Route<dynamic> route) => false,
      );
    }
    // return stringValue;
  }

  @override
  void initState() {
    super.initState();
    getInstallValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loaderWaveComment(),
    );
  }

  Widget loaderWaveComment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text('Loading....'),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: SpinKitCircle(
            color: Colors.blue,
            size: 50.0,
          ),
        ),
      ],
    );
  }
}
