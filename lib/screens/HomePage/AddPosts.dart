import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:suhadhamaru/logic/PostDetails.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:intl/intl.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  DatabaseReference database = FirebaseDatabase.instance.reference();

  TextEditingController titleController = TextEditingController();
  TextEditingController postController = TextEditingController();

  String uId = userId;
  bool _isLoading = false;

  final homeScaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();

  String userPhotoUrl = imageUrl;
  String userName = name;

  var _currencies = ['Police', 'Teacher', 'Doctor', 'Nurse'];
  var currencyValue = 'Police';
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              AppLocalizations.of(context).tr('homePage.addPostPage.addPost'),
              style:
                  TextStyle(fontFamily: 'coiny', fontWeight: FontWeight.bold)),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                AppLocalizations.of(context)
                                    .tr('homePage.addPostPage.category'),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              )),
                          Expanded(
                            flex: 4,
                            child: Card(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                items: _currencies
                                    .map((String dropDownStringItem) {
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
                      color: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.all(3),
                          child: TextFormField(
                            controller: titleController,
                            //style: textStyle,
                            validator: (String Value) {
                              if (Value.isEmpty) {
                                return AppLocalizations.of(context)
                                    .tr('homePage.addPostPage.postEnterTitle');
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)
                                    .tr('homePage.addPostPage.postTitle'),
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 15.0),
                                hintText: AppLocalizations.of(context)
                                    .tr('homePage.addPostPage.postHintTitle'),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextFormField(
                          controller: postController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context)
                                  .tr('homePage.addPostPage.postEnter');
                            }
                            return null;
                          },
                          maxLines: 8,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                              alignLabelWithHint: true,
                              labelText: AppLocalizations.of(context)
                                  .tr('homePage.addPostPage.postDiscription'),
                              hintText: AppLocalizations.of(context)
                                  .tr('homePage.addPostPage.postHintPost'),
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
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
                                .tr('homePage.addPostPage.postSubmit'),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'coiny',
                                color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            savePost(homeScaffoldKey.currentState, context);
                          }
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
      ),
    );
  }

  Future<void> savePost(ScaffoldState scaffold, BuildContext context) async {
    String key = database.child("Post").push().key;

    String date = DateFormat.yMMMd().format(DateTime.now());

    var post = <String, dynamic>{
      'title': titleController.text,
      'Post': postController.text,
      'category': this.currencyValue,
      'date': date,
      'confirm': 'Yes',
      'pushkey': key,
      'userPhotoUrl': userPhotoUrl,
      'userName': userName,
      'userId': uId
    };

    return PostDetails().addPost(post, context, key).then((onValue) {
      setState(() {
        _isLoading = onValue;
      });
      titleController.clear();
      postController.clear();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: Text(AppLocalizations.of(context)
                .tr('homePage.addPostPage.dialogTitle')),
            subtitle: Text(AppLocalizations.of(context)
                .tr('homePage.addPostPage.dialogsubTitle')),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(AppLocalizations.of(context)
                  .tr('homePage.addPostPage.dialogButton')),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );

      // Navigator.pop(context, true);
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
      });
      titleController.clear();
      postController.clear();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: Text(AppLocalizations.of(context)
                .tr('homePage.addPostPage.dialogTitle')),
            subtitle: Text(AppLocalizations.of(context)
                .tr('homePage.addPostPage.dialogErrorSubTitle')),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(AppLocalizations.of(context)
                  .tr('homePage.addPostPage.dialogButton')),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    });
  }

  void onClickedItem(String dropdownitem) {
    setState(() {
      this.currencyValue = dropdownitem;
      print(this.currencyValue);
    });
  }
}
