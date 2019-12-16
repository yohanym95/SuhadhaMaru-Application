import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:suhadhamaru/logic/userProfile.dart';
import 'package:suhadhamaru/main.dart';
import 'package:suhadhamaru/screens/HomePage.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/screens/LoginHome.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _currencity = TextEditingController();

  String name = "";

  var _currencies = ['Police', 'Teacher', 'University'];
  var currencyValue = 'Police';

  String userId = "";
  String email = "";

  bool _isLoading = false;

  final DatabaseReference database =
      FirebaseDatabase.instance.reference().child("Users");

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    // Auth().getCurrentUser().then((user) {
    //   if (user == null) {
    //     Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(builder: (context) => MyHomePage()),
    //       (Route<dynamic> route) => false,
    //     );
    //   } else {
    //     userId = user.uid;
    //     email = user.email;
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.pink[300],
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(5),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 200,
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 5.0, left: 5, right: 5),
                        child: TextFormField(
                          controller: _firstname,
                          //style: textStyle,
                          validator: (String Value) {
                            if (Value.isEmpty) {
                              return 'Enter Your First Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'First Name',
                              focusColor: Colors.pink,
                              labelStyle: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                              prefixIcon: Icon(Icons.person),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15.0),
                              hintText: "First Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 5.0, left: 5, right: 5),
                        child: TextFormField(
                          controller: _lastname,
                          //style: textStyle,
                          validator: (String Value) {
                            if (Value.isEmpty) {
                              return 'Enter Your Last Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Last Name',
                              focusColor: Colors.pink,
                              labelStyle: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                              prefixIcon: Icon(Icons.person),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15.0),
                              hintText: "Last Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Category',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )),
                        Expanded(
                          flex: 4,
                          child: Card(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              items:
                                  _currencies.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(
                                      dropDownStringItem,
                                      textAlign: TextAlign.center,
                                    ));
                              }).toList(),
                              onChanged: (String dropdownitem) {
                                onClickedItem(dropdownitem);
                              },
                              value: currencyValue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 5, right: 5),
                        child: TextFormField(
                          controller: _currencity,
                          //style: textStyle,
                          validator: (String Value) {
                            if (Value.isEmpty) {
                              return 'Enter Your Current City';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Current City',
                              focusColor: Colors.pink,
                              labelStyle: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                              prefixIcon: Icon(Icons.person),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15.0),
                              hintText: "Current City",
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
                          'Submit',
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

                          print(_firstname.text);
                          print(_lastname.text);
                          print(email);
                          print(this.currencyValue);
                          print(_currencity.text);

                          UserManagement().addData({
                            'firstName': _firstname.text,
                            'lastName': _lastname.text,
                            'email': email,
                            'category': this.currencyValue,
                            'currentCity': _currencity.text,
                          }, userId, context).then((onValue) {
                            setState(() {
                              _isLoading = onValue;
                            });
                          }).catchError((onError) {
                            setState(() {
                              _isLoading = true;
                            });
                          });
                        }
                      },
                      color: Colors.pink[300],
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

  void onClickedItem(String dropdownitem) {
    setState(() {
      this.currencyValue = dropdownitem;
      print(this.currencyValue);
    });
  }
}
