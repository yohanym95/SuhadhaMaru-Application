import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/model/Post.dart';
import 'package:suhadhamaru/screens/LoginHome.dart';
import 'package:suhadhamaru/screens/PostPage.dart';
import 'package:suhadhamaru/screens/Profile.dart';

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

  List<Posts> postPoliceList = [];
  List<Posts> postTeacherList = [];
  List<Posts> postDoctorList = [];
  List<Posts> postNurseList = [];

  int policeLength;
  int teacherLength;
  int doctorLength;
  int nurseLength;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPolicePost();
    getTeacherPost();
    getDoctorPost();
    getNursePost();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('සුහඳ මාරු',
            style: TextStyle(fontFamily: 'coiny', fontWeight: FontWeight.bold)),
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
        backgroundColor: Colors.purple[300],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            GestureDetector(
              child: new UserAccountsDrawerHeader(
                  accountName: Text("$name1"),
                  accountEmail: Text("$email1"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(url),
                    radius: 60,
                    backgroundColor: Colors.transparent,
                  )),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
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
                color: Colors.purple[200],
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
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'coiny')),
                      backgroundColor: Colors.white,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostPage('Police')),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height / 6,
                  child: postPoliceList.length == 0
                      ? Container(
                          child: loaderWaveComment(),
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
                                      '${postPoliceList[index].title}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      '${postPoliceList[index].post}',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900),
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
                  child: GestureDetector(
                    child: Chip(
                      label: Text('Teacher',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'coiny')),
                      backgroundColor: Colors.white,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostPage('Teacher')),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height / 6,
                  child: postTeacherList.length == 0
                      ? Container(
                          child: loaderWaveComment(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: teacherLength,
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
                                      '${postTeacherList[index].title}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      '${postTeacherList[index].post}',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900),
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
                  child: GestureDetector(
                    child: Chip(
                      label: Text('Doctor',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'coiny')),
                      backgroundColor: Colors.white,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostPage('Doctor')),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height / 6,
                  child: postDoctorList.length == 0
                      ? Container(
                          child: loaderWaveComment(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: doctorLength,
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
                                      '${postDoctorList[index].title}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      '${postDoctorList[index].post}',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900),
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
                  child: GestureDetector(
                    child: Chip(
                      label: Text('Nurse',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'coiny')),
                      backgroundColor: Colors.white,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostPage('Nurse')),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height / 6,
                  child: postNurseList.length == 0
                      ? Container(
                          child: loaderWaveComment(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: nurseLength,
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
                                      '${postNurseList[index].title}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      '${postNurseList[index].post}',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900),
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

  Future getPolicePost() async {
    DatabaseReference database =
        FirebaseDatabase.instance.reference().child("Posts").child('Police');
    database.once().then((DataSnapshot data) {
      var keys = data.value.keys;
      var Data1 = data.value;

      postPoliceList.clear();

      for (var individualKey in keys) {
        Posts posts = new Posts(
            Data1[individualKey]['title'],
            Data1[individualKey]['Post'],
            Data1[individualKey]['date'],
            Data1[individualKey]['confirm'],
            Data1[individualKey]['pushkey']);

        if (Data1[individualKey]['confirm'] == "Yes") {
          postPoliceList.add(posts);
        }
      }

      setState(() {
        if (postPoliceList.length >= 3) {
          policeLength = 3;
        } else {
          policeLength = postPoliceList.length;
        }
        print(policeLength);
      });
    });
  }

  Future getTeacherPost() async {
    DatabaseReference database =
        FirebaseDatabase.instance.reference().child("Posts").child('Teacher');
    database.once().then((DataSnapshot data) {
      var keys = data.value.keys;
      var Data1 = data.value;

      postTeacherList.clear();

      for (var individualKey in keys) {
        Posts posts = new Posts(
            Data1[individualKey]['title'],
            Data1[individualKey]['Post'],
            Data1[individualKey]['date'],
            Data1[individualKey]['confirm'],
            Data1[individualKey]['pushkey']);

        if (Data1[individualKey]['confirm'] == "Yes") {
          postTeacherList.add(posts);
        }
      }

      setState(() {
        if (postTeacherList.length >= 3) {
          teacherLength = 3;
        } else {
          teacherLength = postTeacherList.length;
        }
        print(teacherLength);
      });
    });
  }

  Future getDoctorPost() async {
    DatabaseReference database =
        FirebaseDatabase.instance.reference().child("Posts").child('Doctor');
    database.once().then((DataSnapshot data) {
      var keys = data.value.keys;
      var Data1 = data.value;

      postDoctorList.clear();

      for (var individualKey in keys) {
        Posts posts = new Posts(
            Data1[individualKey]['title'],
            Data1[individualKey]['Post'],
            Data1[individualKey]['date'],
            Data1[individualKey]['confirm'],
            Data1[individualKey]['pushkey']);

        if (Data1[individualKey]['confirm'] == "Yes") {
          postDoctorList.add(posts);
        }
      }

      setState(() {
        if (postDoctorList.length >= 3) {
          doctorLength = 3;
        } else {
          doctorLength = postDoctorList.length;
        }
        print(doctorLength);
      });
    });
  }

  Future getNursePost() async {
    DatabaseReference database =
        FirebaseDatabase.instance.reference().child("Posts").child('Nurse');
    database.once().then((DataSnapshot data) {
      var keys = data.value.keys;
      var Data1 = data.value;

      postNurseList.clear();

      for (var individualKey in keys) {
        Posts posts = new Posts(
            Data1[individualKey]['title'],
            Data1[individualKey]['Post'],
            Data1[individualKey]['date'],
            Data1[individualKey]['confirm'],
            Data1[individualKey]['pushkey']);

        if (Data1[individualKey]['confirm'] == "Yes") {
          postNurseList.add(posts);
        }
      }

      setState(() {
        if (postNurseList.length >= 3) {
          nurseLength = 3;
        } else {
          nurseLength = postNurseList.length;
        }
        print(nurseLength);
      });
    });
  }

  Widget loaderWaveComment() {
    return Center(
      child: SpinKitThreeBounce(
        color: Colors.purpleAccent,
        size: 50.0,
      ),
    );
  }
}
