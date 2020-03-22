import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suhadhamaru/screens/introduction/introScreen.dart';
import 'package:suhadhamaru/screens/login/LandingPage.dart';
import 'package:suhadhamaru/utils/language.dart';

class Routing extends StatefulWidget {
  @override
  _RoutingState createState() => _RoutingState();
}

class _RoutingState extends State<Routing> {
  var stringValue;
  String installValue;
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  Future<void> getInstallValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    stringValue = prefs.getString('install');
    print('${prefs.getString('install')}');
    if (stringValue.toString() != 'Yes') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SelectLang()),
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
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        body: loaderWaveComment(),
      ),
    );
  }

  Widget loaderWaveComment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: SpinKitCircle(
            color: Colors.blue,
            size: 50.0,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
              AppLocalizations.of(context).tr('login.landingPage.load')),
        ),
      ],
    );
  }
}
