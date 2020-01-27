import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/model/Post.dart';
import 'package:suhadhamaru/model/ProfileDetail.dart';
import 'package:suhadhamaru/screens/Comments.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DatabaseReference db;
  ProfileDetails profileDetails;
  bool isLoad = false;
  Map<dynamic, dynamic> values;
  List<Posts> postList = [];
  String uId = userId;
  String review;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getProfileDetails();
    // if (values != null) {
    //   isLoad = false;
    // } else {
    //   isLoad = true;
    // }
    print('userid::::  ' + userId);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.all(5),
                      child: FutureBuilder(
                        future: FirebaseDatabase.instance
                            .reference()
                            .child('Users')
                            .child(userId)
                            .once(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            // return Text('${snapshot.data.value['photoUrl']}');
                            return Card(
                              color: Colors.blue[50],
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              snapshot.data.value['photoUrl']),
                                          radius: 50,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 15,
                                              bottom: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                                    'Name',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                      ': ${snapshot.data.value['fullName']}',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 5,
                                              bottom: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text('Email',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black54)),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                      ': ${snapshot.data.value['email']}',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 5,
                                              bottom: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text('City',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black54)),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                      ': ${snapshot.data.value['currentCity']}',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircularProgressIndicator(),
                                Center(
                                    child: new Text(
                                  "Loading My Profile",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                              ],
                            ),
                          );
                        },
                      )),
                ),
                Container(
                  child: Text('My Posts',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      child: Center(
                    child: FutureBuilder(
                      future: FirebaseDatabase.instance
                          .reference()
                          .child("Posts")
                          .orderByChild('userId')
                          .equalTo(uId)
                          .once(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          var Data1 = snapshot.data.value;
                          if (Data1 != null) {
                            var keys = snapshot.data.value.keys;
                            postList.clear();

                            for (var individualKey in keys) {
                              // if (Data1[individualKey]['confirm'] == 'Yes') {
                              //   // postList.add(posts);
                              //   // print(posts);
                              //   review = 'Reviewed';

                              // }else{
                              //   review = 'Reviewing';
                              // }
                              Posts posts = new Posts(
                                  Data1[individualKey]['title'],
                                  Data1[individualKey]['Post'],
                                  Data1[individualKey]['date'],
                                  Data1[individualKey]['confirm'],
                                  Data1[individualKey]['pushkey'],
                                  Data1[individualKey]['userPhotoUrl'],
                                  Data1[individualKey]['userName'],
                                  Data1[individualKey]['userId'],
                                  Data1[individualKey]['category']);

                              postList.add(posts);
                            }
                            return new ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: postList.length,
                              itemBuilder: (_, index) {
                                return postsUI(
                                    postList[index].title,
                                    postList[index].post,
                                    postList[index].date,
                                    postList[index].pushkey,
                                    postList[index].userName,
                                    postList[index].userPhotoUrl,
                                    postList[index].postCategory,
                                    postList[index].confirm);
                              },
                            );
                          } else {
                            return Center(
                              child: Container(
                                  padding: EdgeInsets.all(4),
                                  height: height / 5,
                                  width: width / 2,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Image(
                                          image: AssetImage(
                                              "assests/emptypost.png"),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        'No Posts in this category yet!',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: 'coiny',
                                            color: Colors.black26),
                                      )
                                    ],
                                  ))),
                            );
                          }
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                            new Text("Please wait! Posts are loading"),
                          ],
                        );

                        ///  return ShimmerList();
                      },
                    ),
                  )),
                ),
              ],
            ),
          ),
        ));
  }

  Widget postsUI(
      String title,
      String description,
      String date,
      String key,
      String userName,
      String userPhotoUrl,
      String postCategory,
      String review) {
    if (review == 'Yes') {
      // postList.add(posts);
      // print(posts);
      review = 'Reviewed';
    } else {
      review = 'Reviewing';
    }
    return new Card(
      color: Colors.blue[50],
      elevation: 10.0,
      margin: EdgeInsets.all(10.0),
      child: Container(
          padding: EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: userPhotoUrl == null
                    ? Icon(
                        Icons.person,
                        color: Colors.blue[100],
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(userPhotoUrl),
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(3),
                        child: new Text(
                          userName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(3),
                        child: new Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.all(3),
                          child: new Text(description,
                              style: TextStyle(color: Colors.black87))),
                      // Container(
                      //     margin: EdgeInsets.all(2),
                      //     child: new Text(date,
                      //         style: Theme.of(context).textTheme.subtitle)),
                      // Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Text(
                                date,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  child: Icon(Icons.comment),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Comments(
                                            key,
                                            postCategory,
                                            userPhotoUrl,
                                            userName,
                                            title,
                                            description,
                                            date),
                                      ),
                                    );
                                  },
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(3),
                child: review == 'Reviewed'
                    ? new Text(
                        review,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20,
                            color: Colors.blue),
                        textAlign: TextAlign.center,
                      )
                    : new Text(
                        review,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20,
                            color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
              ),
            ],
          )),
    );
  }
}
