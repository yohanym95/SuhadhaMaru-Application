import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/screens/introduction/introScreen.dart';

class SelectLang extends StatefulWidget {
  @override
  _SelectLangState createState() => _SelectLangState();
}

class _SelectLangState extends State<SelectLang> {
  //var data = EasyLocalizationProvider.of(context).data;
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset("assests/select.png",),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Select the Language',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'coiny',
                        color: Colors.grey),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    langButton('English', data, 'en', 'US'),
                    langButton('සිංහළ', data, 'si', 'SL'),
                    langButton('தமிழ்', data, 'ta', 'IN')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget langButton(language, data, langType, langCountry) {
    return Container(
      margin: EdgeInsets.all(5),
          child: MaterialButton(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            language,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'coiny',
                color: Colors.white),
          ),
        ),
        onPressed: () {
          data.changeLocale(Locale(langType, langCountry));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => IntroScreen()),
            (Route<dynamic> route) => false,
          );
        },
        color: Colors.blue[300],
      ),
    );
  }
}
