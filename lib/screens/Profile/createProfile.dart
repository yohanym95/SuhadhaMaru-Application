import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:suhadhamaru/logic/userProfile.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:path/path.dart' as Path;

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
  TextEditingController _email = TextEditingController();
  TextEditingController _currencity = TextEditingController();
  //array for dropdown
  //var _currencies = ['Police', 'Teacher', 'University'];
  //var currencyValue = 'Police';
  //bool for modalprogressHUD
  bool _isLoading = false;

  final DatabaseReference database =
      FirebaseDatabase.instance.reference().child("Users");

  //load profile details
  String url = imageUrl;
  String name1 = name;
  String email1 = email;
  String userId1 = userId;

  //upload pro pic
  File _imageFile;
  StorageReference reference;

  @override
  void initState() {
    super.initState();
    getCurrentUser().then((user) {
      if (user != null) {
        userId1 = user.uid;
        email1 = user.email;
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    // TODO: implement build
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              AppLocalizations.of(context)
                  .tr('homePage.createProfilePage.titleProfile'),
              style:
                  TextStyle(fontFamily: 'coiny', fontWeight: FontWeight.bold)),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: SingleChildScrollView(
            child:
                Container(margin: EdgeInsets.all(5), child: createProfileUI()),
          ),
        ),
      ),
    );
  }

  Widget createProfileUI() {
    _firstname.text = name1;
    _email.text = email1;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
              child: Center(
            child: Text(
              AppLocalizations.of(context)
                  .tr('homePage.createProfilePage.createProfile'),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
          )),
          url == null
              ? GestureDetector(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.blue[100],
                        size: 70,
                      ),
                    ),
                  ),
                  onTap: () {
                    askCapture(context);
                  },
                )
              : Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: Image.network(
                        url,
                        // height: 150,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
          Container(
            margin: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
            child: Padding(
                padding:
                    EdgeInsets.only(top: 15.0, bottom: 5.0, left: 5, right: 5),
                child: TextFormField(
                  controller: _firstname,
                  //style: textStyle,
                  validator: (String Value) {
                    if (Value.isEmpty) {
                      return AppLocalizations.of(context)
                          .tr('homePage.createProfilePage.Name');
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .tr('homePage.createProfilePage.labelName'),
                      focusColor: Colors.blue,
                      labelStyle:
                          TextStyle(fontSize: 18.0, color: Colors.black),
                      prefixIcon: Icon(Icons.person),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15.0),
                      hintText: AppLocalizations.of(context)
                          .tr('homePage.createProfilePage.hintName'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
            child: Padding(
                padding:
                    EdgeInsets.only(top: 15.0, bottom: 5.0, left: 5, right: 5),
                child: TextFormField(
                  controller: _email,
                  //style: textStyle,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return AppLocalizations.of(context)
                          .tr('homePage.createProfilePage.email');
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .tr('homePage.createProfilePage.labelEmail'),
                      focusColor: Colors.blue,
                      labelStyle:
                          TextStyle(fontSize: 18.0, color: Colors.black),
                      prefixIcon: Icon(Icons.person),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15.0),
                      hintText: AppLocalizations.of(context)
                          .tr('homePage.createProfilePage.hintEmail'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                )),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Row(
          //     children: <Widget>[
          //       Expanded(
          //           flex: 1,
          //           child: Text(
          //             'Category',
          //             style: TextStyle(color: Colors.black, fontSize: 15),
          //           )),
          //       Expanded(
          //         flex: 4,
          //         child: Card(
          //           child: DropdownButton<String>(
          //             isExpanded: true,
          //             items: _currencies.map((String dropDownStringItem) {
          //               return DropdownMenuItem<String>(
          //                   value: dropDownStringItem,
          //                   child: Text(
          //                     dropDownStringItem,
          //                     textAlign: TextAlign.center,
          //                   ));
          //             }).toList(),
          //             onChanged: (String dropdownitem) {
          //               onClickedItem(dropdownitem);
          //             },
          //             value: currencyValue,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            margin: EdgeInsets.all(5),
            child: Padding(
                padding:
                    EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5, right: 5),
                child: TextFormField(
                  controller: _currencity,
                  //style: textStyle,
                  validator: (String Value) {
                    if (Value.isEmpty) {
                      return AppLocalizations.of(context)
                          .tr('homePage.createProfilePage.currentCity');
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .tr('homePage.createProfilePage.labelCity'),
                      focusColor: Colors.blue,
                      labelStyle:
                          TextStyle(fontSize: 18.0, color: Colors.black),
                      prefixIcon: Icon(Icons.person),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15.0),
                      hintText: AppLocalizations.of(context)
                          .tr('homePage.createProfilePage.hintCity'),
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
                      .tr('homePage.createProfilePage.profileSubmit'),
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
                  print(_email.text);
                  // print(this.currencyValue);
                  print(_currencity.text);

                  UserManagement().addData({
                    'fullName': _firstname.text,
                    'email': _email.text,
                    'currentCity': _currencity.text,
                    'photoUrl': url
                  }, userId1, context).then((onValue) {
                    setState(() {
                      _isLoading = onValue;
                      print(onValue);
                    });
                  }).catchError((onError) {
                    setState(() {
                      _isLoading = true;
                    });
                  });
                }
              },
              color: Colors.blue[300],
            ),
          ),
        ],
      ),
    );
  }

  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _imageFile = image;
    });
    return _imageFile;
  }

  Future uploadImage(File imagePath) async {
    reference = FirebaseStorage.instance
        .ref()
        .child('Profiles/${Path.basename(imagePath.path)}');
    //chats/${Path.basename(_imageFile.path)}
    StorageUploadTask uploadTask = reference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String setImageUrl = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      // _uploaded = true;
      url = setImageUrl;
    });
  }

  Future askCapture(BuildContext context) async {
    switch (await showDialog(
        context: context,
        child: Center(
          child: new SimpleDialog(
            contentPadding:
                EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
            title: new Text(
              AppLocalizations.of(context)
                  .tr('homePage.createProfilePage.profilePicture'),
              textAlign: TextAlign.center,
            ),
            children: <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Icon(
                          Icons.photo,
                          color: Colors.blue[400],
                          size: 70,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        getImage(false).then((onImage) {
                          uploadImage(onImage);
                        });
                      },
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    GestureDetector(
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.blue[400],
                          size: 70,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        getImage(true).then((onImage) {
                          uploadImage(onImage);
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ))) {
    }
  }
}
