import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:suhadhamaru/logic/PostDetails.dart';
import 'package:suhadhamaru/logic/auth.dart';

class Post extends StatefulWidget {
  String category;

  Post(this.category);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PostState(this.category);
  }
}

class PostState extends State<Post> {
  String category;

  DatabaseReference database = FirebaseDatabase.instance.reference();

  TextEditingController titleController = TextEditingController();
  TextEditingController postController = TextEditingController();

  String uId = userId;
  bool _isLoading = false;

  final homeScaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  String userPhotoUrl = imageUrl;
  String userName = name;

  PostState(this.category);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(userPhotoUrl);
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    // TODO: implement build
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
          key: homeScaffoldKey,
          appBar: AppBar(
            title: Text(
                AppLocalizations.of(context).tr('post.catAddPostPage.titleBar'),
                style: TextStyle(
                    fontFamily: 'coiny', fontWeight: FontWeight.bold)),
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
                      Container(
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: TextFormField(
                              controller: titleController,
                              //style: textStyle,
                              validator: (String Value) {
                                if (Value.isEmpty) {
                                  return AppLocalizations.of(context)
                                      .tr('post.catAddPostPage.addEnterTitle');
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)
                                      .tr('post.catAddPostPage.addTitle'),
                                  labelStyle: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent, fontSize: 15.0),
                                  hintText: AppLocalizations.of(context)
                                      .tr('post.catAddPostPage.hintTitle'),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                            )),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: postController,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context)
                                    .tr('post.catAddPostPage.addEnterPost');
                              }
                              return null;
                            },
                            maxLines: 8,
                            decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                                alignLabelWithHint: true,
                                labelText: AppLocalizations.of(context)
                                    .tr('post.catAddPostPage.postDiscription'),
                                hintText: AppLocalizations.of(context)
                                    .tr('post.catAddPostPage.postHint'),
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
                                  .tr('post.catAddPostPage.postSubmit'),
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
          )),
    );
  }

  // void onClickedItem(String dropdownitem) {
  //   setState(() {
  //     this.currencyValue = dropdownitem;
  //     print(this.currencyValue);
  //   });
  // }

  Future<void> savePost(ScaffoldState scaffold, BuildContext context) async {
    String key = database.child("Post").push().key;

    String date = DateFormat.yMMMd().format(DateTime.now());

    var post = <String, dynamic>{
      'title': titleController.text,
      'Post': postController.text,
      'category': category,
      'date': date,
      'confirm': 'No',
      'pushkey': key,
      'userPhotoUrl': userPhotoUrl,
      'userName': userName,
      'userId': uId
    };

    return PostDetails().addPost(post, context, key).then((onValue) {
      setState(() {
        _isLoading = onValue;
      });
      scaffold.showSnackBar(new SnackBar(
        content: new Text(AppLocalizations.of(context)
            .tr('post.catAddPostPage.snackBarUploaded')),
      ));
      titleController.clear();
      postController.clear();
      // Navigator.pop(context, true);
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
      });
      scaffold.showSnackBar(new SnackBar(
        content: new Text(AppLocalizations.of(context)
            .tr('post.catAddPostPage.snackBarError')),
      ));
      titleController.clear();
      postController.clear();
    });
  }
}
