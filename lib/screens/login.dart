import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suhadhamaru/logic/SharedPreferenceHelper.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:suhadhamaru/screens/HomePage.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/screens/createProfile.dart';
import 'package:suhadhamaru/widgets/loader.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _isLoading = false;

  check() {
    DatabaseReference database =
        FirebaseDatabase.instance.reference().child('Users');

    signInWithGoogle().then((onValue) {
      String uid = userId;
      
      if(uid == null){
        print('login uid :$uid');
      }

      database.once().then((DataSnapshot data) {
        
        var Data1 = data.value.keys;
        
        print(Data1);

        for (var key in Data1) {
          if (key == uid) {
            // setState(() async {
            //   _isLoading = false;
            // });
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
            );
            
            print('homepage');
            break;
          } else {
            // setState(() async {
            //   _isLoading = false;
            // });
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
              (Route<dynamic> route) => false,
            );
            
            print('profile');
          }
        }
      });
    }).catchError((onError) {
      setState(() async {
        _isLoading = false;
        print('error');
      });
      print('error');
      print(onError.toString());
    });

    // setState(() {
    //   print(postList.length);
    // });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.pink[300],
      ),
      body: _isLoading ? Loader() : SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: 15.0, bottom: 5.0, left: 5, right: 5),
                      child: TextFormField(
                        controller: _email,
                        //style: textStyle,
                        validator: validateEmail1,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            focusColor: Colors.pink,
                            labelStyle: TextStyle(
                                fontSize: 18.0, color: Colors.black),
                            prefixIcon: Icon(Icons.person),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15.0),
                            hintText: "Email",
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Your Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            focusColor: Colors.pink,
                            labelStyle: TextStyle(
                                fontSize: 18.0, color: Colors.black),
                            prefixIcon: Icon(Icons.person),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15.0),
                            hintText: "Password",
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
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                      }
                    },
                    color: Colors.pink[300],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      'Login With',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                _facebookSignInButton(),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      'OR',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                _signInButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        setState(() {
          _isLoading = true;
        });
        check();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assests/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _facebookSignInButton() {
    return OutlineButton(
      color: Colors.blue,
      splashColor: Colors.blue,
      onPressed: () {
        setState(() {
          _isLoading = true;
        });
        handleSignIn().whenComplete(() {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assests/Facebook_Logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Facebook',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
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
      return 'Enter Your Valid Email';
    }
    return null;
  }
}
