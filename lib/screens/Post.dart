import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[300],
          title: Text('Add Post'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Form(
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
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )),
                      Expanded(
                        flex: 4,
                        child: Card(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: _currencies.map((String dropDownStringItem) {
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
                        //controller: member3Name,
                        //style: textStyle,
                        validator: (String Value) {
                          if (Value.isEmpty) {
                            return 'Enter Your Title';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle:
                                TextStyle(fontSize: 18.0, color: Colors.black),
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
                      //controller: projectDescription,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter Your Post';
                        }
                        return null;
                      },
                      maxLines: 8,
                      decoration: InputDecoration(
                          labelStyle:
                              TextStyle(fontSize: 18.0, color: Colors.black),
                          alignLabelWithHint: true,
                          labelText: 'Post',
                          hintText: 'Enter Your Post',
                          errorStyle: TextStyle(
                              color: Colors.redAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                )
              ],
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
}
