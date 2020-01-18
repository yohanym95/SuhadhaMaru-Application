import 'package:easy_localization/easy_localization.dart';
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var data = EasyLocalizationProvider.of(context).data;
    // TODO: implement build
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).tr('appBarTitle'),
              style:
                  TextStyle(fontFamily: 'coiny', fontWeight: FontWeight.bold)),
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
                title: Text("Language"),
                // trailing: Icon(Icons.arrow_upward),
                onTap: () {
                  _askLanguage(context);
                },
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
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5),
              child: Container(
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
                      child: FutureBuilder(
                        future: FirebaseDatabase.instance
                            .reference()
                            .child("Posts")
                            .child('Police')
                            .orderByChild('confirm')
                            .equalTo('Yes')
                            .once(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var Data1 = snapshot.data.value;
                            if (Data1 != null) {
                              var keys = snapshot.data.value.keys;
                              postPoliceList.clear();
                              for (var individualKey in keys) {
                                Posts posts = new Posts(
                                    Data1[individualKey]['title'],
                                    Data1[individualKey]['Post'],
                                    Data1[individualKey]['date'],
                                    Data1[individualKey]['confirm'],
                                    Data1[individualKey]['pushkey']);
                                postPoliceList.add(posts);
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: postPoliceList.length,
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
                                          padding:
                                              const EdgeInsets.only(top: 5),
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
                              );
                            } else {
                              return Center(
                                child: Card(
                                  child: Container(
                                    height: height / 7,
                                    width: width / 2,
                                    child: Center(
                                        child: Text(
                                      'No Recent Posts',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'coiny',
                                          color: Colors.black87),
                                    )),
                                  ),
                                ),
                              );
                            }
                          }
                          return loaderWaveComment();
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
                      child: FutureBuilder(
                        future: FirebaseDatabase.instance
                            .reference()
                            .child("Posts")
                            .child('Teacher')
                            .orderByChild('confirm')
                            .equalTo('Yes')
                            .once(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var Data1 = snapshot.data.value;
                            if (Data1 != null) {
                              var keys = snapshot.data.value.keys;
                              postTeacherList.clear();
                              for (var individualKey in keys) {
                                Posts posts = new Posts(
                                    Data1[individualKey]['title'],
                                    Data1[individualKey]['Post'],
                                    Data1[individualKey]['date'],
                                    Data1[individualKey]['confirm'],
                                    Data1[individualKey]['pushkey']);
                                postTeacherList.add(posts);
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: postTeacherList.length,
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
                                          padding:
                                              const EdgeInsets.only(top: 5),
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
                              );
                            } else {
                              return Center(
                                child: Card(
                                  child: Container(
                                    height: height / 7,
                                    width: width / 2,
                                    child: Center(
                                        child: Text(
                                      'No Recent Posts',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'coiny',
                                          color: Colors.black87),
                                    )),
                                  ),
                                ),
                              );
                            }
                          }
                          return loaderWaveComment();
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
                      child: FutureBuilder(
                        future: FirebaseDatabase.instance
                            .reference()
                            .child("Posts")
                            .child('Doctor')
                            .orderByChild('confirm')
                            .equalTo('Yes')
                            .once(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var Data1 = snapshot.data.value;
                            if (Data1 != null) {
                              var keys = snapshot.data.value.keys;

                              postDoctorList.clear();
                              for (var individualKey in keys) {
                                Posts posts = new Posts(
                                    Data1[individualKey]['title'],
                                    Data1[individualKey]['Post'],
                                    Data1[individualKey]['date'],
                                    Data1[individualKey]['confirm'],
                                    Data1[individualKey]['pushkey']);
                                if (Data1[individualKey]['confirm'] == 'Yes') {
                                  postDoctorList.add(posts);
                                }
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: postDoctorList.length,
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
                                          padding:
                                              const EdgeInsets.only(top: 5),
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
                              );
                            } else {
                              return Center(
                                child: Card(
                                  child: Container(
                                    height: height / 7,
                                    width: width / 2,
                                    child: Center(
                                        child: Text(
                                      'No Recent Posts',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'coiny',
                                          color: Colors.black87),
                                    )),
                                  ),
                                ),
                              );
                            }
                          }
                          return loaderWaveComment();
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
                      child: FutureBuilder(
                        future: FirebaseDatabase.instance
                            .reference()
                            .child("Posts")
                            .child('Nurse')
                            .orderByChild('confirm')
                            .equalTo('Yes')
                            .once(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var Data1 = snapshot.data.value;
                            if (Data1 != null) {
                              var keys = snapshot.data.value.keys;
                              var Data1 = snapshot.data.value;
                              postNurseList.clear();
                              for (var individualKey in keys) {
                                Posts posts = new Posts(
                                    Data1[individualKey]['title'],
                                    Data1[individualKey]['Post'],
                                    Data1[individualKey]['date'],
                                    Data1[individualKey]['confirm'],
                                    Data1[individualKey]['pushkey']);
                                postNurseList.add(posts);
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: postNurseList.length,
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
                                          padding:
                                              const EdgeInsets.only(top: 5),
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
                              );
                            } else {
                              return Center(
                                child: Card(
                                  child: Container(
                                    height: height / 7,
                                    width: width / 2,
                                    child: Center(
                                        child: Text(
                                      'No Recent Posts',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'coiny',
                                          color: Colors.black87),
                                    )),
                                  ),
                                ),
                              );
                            }
                          }
                          return loaderWaveComment();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //loading widget
  Widget loaderWaveComment() {
    return Center(
      child: SpinKitThreeBounce(
        color: Colors.purpleAccent,
        size: 50.0,
      ),
    );
  }

  //language dialog
  Future _askLanguage(BuildContext context) async {
    var data = EasyLocalizationProvider.of(context).data;
    switch (await showDialog(
        context: context,
        child: EasyLocalizationProvider(
          data: data,
          child: new SimpleDialog(
            contentPadding:
                EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
            title: new Text(
                AppLocalizations.of(context)
                    .tr('homePage.languageDialog.title'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'coiny',
                    color: Colors.black87)),
            children: <Widget>[
              new MaterialButton(
                padding: EdgeInsets.all(5),
                child: Text(
                  'English',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'coiny',
                      color: Colors.white),
                ),
                color: Colors.purple[300],
                onPressed: () {
                  setState(() {
                    data.changeLocale(Locale('en', 'US'));
                    Navigator.pop(context, true);
                  });
                },
              ),
              new MaterialButton(
                padding: EdgeInsets.all(5),
                child: new Text(
                  "සිංහළ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'coiny',
                      color: Colors.white),
                ),
                color: Colors.purple[300],
                onPressed: () {
                  setState(() {
                    data.changeLocale(Locale('si', 'SL'));
                    Navigator.pop(context, true);
                  });
                },
              ),
              new MaterialButton(
                padding: EdgeInsets.all(5),
                child: new Text(
                  "தமிழ்",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'coiny',
                      color: Colors.white),
                ),
                color: Colors.purple[300],
                onPressed: () {},
              ),
            ],
          ),
        ))) {
    }
  }
}
