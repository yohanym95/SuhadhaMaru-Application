import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/screens/login/LoginHome.dart';

Future<bool> dialogTrigger(BuildContext context) async {
  var data = EasyLocalizationProvider.of(context).data;
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return EasyLocalizationProvider(
          data: data,
          child: AlertDialog(
            title: Text(
              AppLocalizations.of(context)
                  .tr('homePage.navigateDrawer.logoutDialogTitle'),
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            content: Text(AppLocalizations.of(context)
                .tr('homePage.navigateDrawer.logoutDialogSubtitle')),
            actions: <Widget>[
              FlatButton(
                child: Text(AppLocalizations.of(context)
                    .tr('homePage.navigateDrawer.dialogNo')),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(AppLocalizations.of(context)
                    .tr('homePage.navigateDrawer.dialogYes')),
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
          ),
        );
      });
}
