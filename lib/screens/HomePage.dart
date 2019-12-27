import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/main.dart';
import 'package:suhadhamaru/model/Post.dart';
import 'package:suhadhamaru/screens/LoginHome.dart';
import 'package:suhadhamaru/screens/PolicePost.dart';
import 'package:suhadhamaru/screens/login.dart';
import 'package:suhadhamaru/widgets/HomeLists.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String url = imageUrl;
  String name1 = name;
  String email1 = email;

  List<Posts> postList = [];

  int policeLength;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPolicePost();
    
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('සුහඳ මාරු'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8, top: 13, bottom: 13),
            padding: EdgeInsets.all(3),
            child: FlatButton(
              color: Colors.pink[100],
              child: Text('LOGOUT'),
              onPressed: () {
                signOut().then((onValue) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (Route<dynamic> route) => false,
                  );
                });
              },
            ),
          )
        ],
        backgroundColor: Colors.pink[300],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: Text("$name1"),
                accountEmail: Text("$email1"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(url),
                  radius: 60,
                  backgroundColor: Colors.transparent,
                )),
            new ListTile(
              title: Text("Page one"),
              trailing: Icon(Icons.arrow_upward),
            ),
            new ListTile(
              title: Text("Page two"),
              trailing: Icon(Icons.arrow_upward),
            ),
            new ListTile(
              title: Text("Page three"),
              trailing: Icon(Icons.arrow_upward),
            ),
            new Divider(),
            new ListTile(
              title: Text(" Close"),
              trailing: Icon(Icons.close),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            // height: MediaQuery.of(context).size.height - 180.0,
            padding: EdgeInsets.only(top: 20, right: 8, left: 8),
            decoration: BoxDecoration(
                color: Colors.pink[300],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    child: Chip(
                      label: Text('Police',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      backgroundColor: Colors.white,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PolicePost()),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height / 6,
                  child: postList.length == 0
                      ? Container(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: policeLength,
                          itemBuilder: (context, index) {
                            return Container(
                              //alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 4),
                              width: width / 1.5,
                              //height: height / 5,
                              child: Card(
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 5),
                                    child: Text(
                                      '${postList[index].title}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      '${postList[index].post}',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text('Police',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: height / 6,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, i) {
                      return Container(
                        //alignment: Alignment.center,

                        margin: EdgeInsets.only(left: 4),

                        width: width / 1.5,

                        //height: height / 5,

                        child: Card(
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 5),
                              child: Text(
                                'I want to transfer from my job to anuradhapura',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                'I am from anuradhapura. but now i work in kalutara north police station. my family live in anuradhapura. so i want make a transfer to them',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text('Police',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: height / 6,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, i) {
                      return Container(
                        //alignment: Alignment.center,

                        margin: EdgeInsets.only(left: 4),

                        width: width / 1.5,

                        //height: height / 5,

                        child: Card(
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 5),
                              child: Text(
                                'I want to transfer from my job to anuradhapura',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                'I am from anuradhapura. but now i work in kalutara north police station. my family live in anuradhapura. so i want make a transfer to them',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text('Police',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: height / 6,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, i) {
                      return Container(
                        //alignment: Alignment.center,

                        margin: EdgeInsets.only(left: 4),

                        width: width / 1.5,

                        //height: height / 5,

                        child: Card(
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 5),
                              child: Text(
                                'I want to transfer from my job to anuradhapura',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                'I am from anuradhapura. but now i work in kalutara north police station. my family live in anuradhapura. so i want make a transfer to them',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  Future getPolicePost()async{
    DatabaseReference database =
        FirebaseDatabase.instance.reference().child("Posts").child('Police');
    database.once().then((DataSnapshot data) {
      var keys = data.value.keys;
      var Data1 = data.value;

      postList.clear();

      for (var individualKey in keys) {
        Posts posts = new Posts(
            Data1[individualKey]['title'],
            Data1[individualKey]['Post'],
            Data1[individualKey]['date'],
            Data1[individualKey]['confirm']);

        if (Data1[individualKey]['confirm'] == "Yes") {
          postList.add(posts);
        }
      }

      setState(() {
        if(postList.length >= 3){
          policeLength = 3;
        }else {
          policeLength = postList.length;
        }
        print(policeLength);
      });
    });
  }
}
