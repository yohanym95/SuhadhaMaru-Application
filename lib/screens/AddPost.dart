import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/logic/userProfile.dart';
import 'package:suhadhamaru/main.dart';

class Post extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PostState();
  }
}

class PostState extends State<Post> {
  var _currencies = ['Police', 'Teacher', 'University'];
  var currencyValue = 'Police';

  final DatabaseReference database =
      FirebaseDatabase.instance.reference().child("Post");

  TextEditingController titleController = TextEditingController();
  TextEditingController postController = TextEditingController();

  String userId;
  bool _isLoading = false;

  final homeScaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();

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
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: homeScaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.pink[300],
          title: Text('Add Post'),
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
                                'Category',
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
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: TextFormField(
                            controller: titleController,
                            //style: textStyle,
                            validator: (String Value) {
                              if (Value.isEmpty) {
                                return 'Enter Your Title';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Title',
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 15.0),
                                hintText: "Enter Your Title",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          )),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: postController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Enter Your Post';
                            }
                            return null;
                          },
                          maxLines: 8,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                              alignLabelWithHint: true,
                              labelText: 'Post',
                              hintText: 'Enter Your Post',
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
                            savePost(homeScaffoldKey.currentState, context);
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
        ));
  }

  void onClickedItem(String dropdownitem) {
    setState(() {
      this.currencyValue = dropdownitem;
      print(this.currencyValue);
    });
  }

  Future<void> savePost(ScaffoldState scaffold, BuildContext context) async {
    String date = DateFormat.yMMMd().format(DateTime.now());
    var post = <String, dynamic>{
      'title': titleController.text,
      'Post': postController.text,
      'category': this.currencyValue,
      'date': date,
      'confirm':'No'
    };

    return UserManagement()
        .addPost(post, this.currencyValue, context)
        .then((onValue) {
      setState(() {
       _isLoading = onValue; 
      });
      scaffold.showSnackBar(new SnackBar(
        content: new Text("Your post Uploaded. Now it's at review process."),
      ));
      titleController.clear();
      postController.clear();
    }).catchError((onError) {
      setState(() {
       _isLoading = false; 
      });
      scaffold.showSnackBar(new SnackBar(
        content: new Text("Some Error occured. Please Try Again"),
      ));
      titleController.clear();
      postController.clear();
    });

    
  }
}
