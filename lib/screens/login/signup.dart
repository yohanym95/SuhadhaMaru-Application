import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/screens/Profile/createProfile.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    // TODO: implement build
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).tr('login.signUp.titleBar'),
              style:
                  TextStyle(fontFamily: 'coiny', fontWeight: FontWeight.bold)),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: Container(
            margin: EdgeInsets.all(5),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 5, right: 5),
                        child: TextFormField(
                          controller: _email,
                          //style: textStyle,
                          validator: validateEmail1,
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)
                                  .tr('login.signUp.labelEmail'),
                              focusColor: Colors.blue,
                              labelStyle: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                              prefixIcon: Icon(Icons.person),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15.0),
                              hintText: AppLocalizations.of(context)
                                  .tr('login.signUp.hintEmail'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 5, right: 5),
                        child: TextFormField(
                          controller: _password,
                          obscureText: true,
                          //style: textStyle,
                          validator: (String Value) {
                            if (Value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .tr('login.signUp.returnPassword');
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)
                                  .tr('login.signUp.labelPassword'),
                              focusColor: Colors.blue,
                              labelStyle: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                              prefixIcon: Icon(Icons.lock_outline),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15.0),
                              hintText: AppLocalizations.of(context)
                                  .tr('login.signUp.hintPassword'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                    width: double.infinity,
                    child: MaterialButton(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 10, right: 10),
                        child: Text(
                          AppLocalizations.of(context)
                              .tr('login.signUp.signUpButton'),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'coiny',
                              color: Colors.white),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          signUp(_email.text, _password.text).then((result) {
                            setState(() async {
                              _isLoading = false;
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile()),
                                (Route<dynamic> route) => false,
                              );
                            });
                          }).catchError((onError) {
                            print('error error errorr');
                          });
                        }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Profile()),
                        // );
                      },
                      color: Colors.blue[300],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //email validation
  String validateEmail1(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return AppLocalizations.of(context).tr('login.signUp.returnEmail');
    }
    return null;
  }
}
