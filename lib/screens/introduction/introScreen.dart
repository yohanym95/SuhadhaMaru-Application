import 'package:easy_localization/easy_localization.dart';
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
        title: AppLocalizations.of(context).tr('IntroductionPage.title1'),
        image: Image.asset("assests/introduction/share_article.png"),
        body: AppLocalizations.of(context).tr('IntroductionPage.body1'),
        footer: Text(
          AppLocalizations.of(context).tr('homePage.recentPage.titleBar'),
          style: TextStyle(color: Colors.black),
        ),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: AppLocalizations.of(context).tr('IntroductionPage.title2'),
        image: Image.asset("assests/introduction/get_notification.png"),
        body: AppLocalizations.of(context).tr('IntroductionPage.body2'),
        footer: Text(
          AppLocalizations.of(context).tr('homePage.recentPage.titleBar'),
          style: TextStyle(color: Colors.black),
        ),
        decoration: pageDecoration,
      ),
      PageViewModel(
        image: Image.asset("assests/introduction/get_solutions.png"),
        title: AppLocalizations.of(context).tr('IntroductionPage.title3'),
        body: AppLocalizations.of(context).tr('IntroductionPage.body3'),
        footer: Text(
          AppLocalizations.of(context).tr('homePage.recentPage.titleBar'),
          style: TextStyle(color: Colors.black),
        ),
        decoration: pageDecoration,
      ),
      PageViewModel(
        image: Image.asset("assests/introduction/team_solutions.png"),
        title: AppLocalizations.of(context).tr('IntroductionPage.title4'),
        body: AppLocalizations.of(context).tr('IntroductionPage.body4'),
        footer: Text(
          AppLocalizations.of(context).tr('homePage.recentPage.titleBar'),
          style: TextStyle(color: Colors.black),
        ),
        decoration: pageDecoration,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          pages: getPages(),
          next: const Icon(Icons.navigate_next),
          done: Text(
              AppLocalizations.of(context).tr('IntroductionPage.doneButton'),
              style: TextStyle(fontWeight: FontWeight.w600)),
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
      )),
    );
  }
}
