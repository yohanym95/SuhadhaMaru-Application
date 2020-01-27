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
          backgroundColor: Colors.blue[300],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              GestureDetector(
                child: new UserAccountsDrawerHeader(
                    accountName: Text("$name1"),
                    accountEmail: Text("$email1"),
                    currentAccountPicture: url == 'url'
                        ? Container(
                            width: 100,
                            height: 100,
                            child: CircleAvatar(
                              child: Icon(
                                Icons.person,
                                color: Colors.purple[100],
                              ),
                            ),
                          )
                        : CircleAvatar(
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
                title: Text("My Profile"),
                // trailing: Icon(Icons.arrow_upward),
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
                title: Text("Logout"),
                onTap: () {
                  signOut().then((onValue) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                      (Route<dynamic> route) => false,
                    );
                  });
                },
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
                padding: EdgeInsets.only(top: 13, right: 8, left: 8),
                decoration: BoxDecoration(
                  color: Colors.blue[800].withAlpha(120),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0)),
                ),
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
                                  fontFamily: 'coiny',
                                  color: Colors.black54)),
                          backgroundColor: Colors.blue[200],
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
                            .orderByChild('category')
                            .equalTo('Police')
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
                                    Data1[individualKey]['pushkey'],
                                    Data1[individualKey]['userPhotoUrl'],
                                    Data1[individualKey]['userName'],
                                    Data1[individualKey]['userId'],
                                    Data1[individualKey]['category']);

                                if (Data1[individualKey]['confirm'] == 'Yes') {
                                  postPoliceList.add(posts);
                                }
                              }

                              return postPoliceList.length == 0
                                  ? Center(
                                      child: Card(
                                        elevation: 5.0,
                                        child: Container(
                                            padding: EdgeInsets.all(4),
                                            height: height / 7,
                                            width: width / 2,
                                            child: Center(
                                                child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                  'No Recent Posts in this category!',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontFamily: 'coiny',
                                                      color: Colors.black26),
                                                )
                                              ],
                                            ))),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: postPoliceList.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: width / 1.5,
                                          child: Card(
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: postPoliceList[
                                                                      index]
                                                                  .userPhotoUrl ==
                                                              null
                                                          ? Icon(
                                                              Icons.person,
                                                              color: Colors
                                                                  .purple[100],
                                                            )
                                                          : CircleAvatar(
                                                              backgroundImage: NetworkImage(
                                                                  postPoliceList[
                                                                          index]
                                                                      .userPhotoUrl),
                                                            ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10.0,
                                                                      top: 8),
                                                              child: Text(
                                                                '${postPoliceList[index].userName}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          8.0),
                                                              child: Text(
                                                                '${postPoliceList[index].title}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 3,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black87),
                                                              ),
                                                            ),
                                                            Text(
                                                              '${postPoliceList[index].post}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      // Expanded(
                                                      //   child:
                                                      // ),
                                                      Expanded(
                                                        child: Text(
                                                          '${postPoliceList[index].date}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            } else {
                              return Center(
                                child: Card(
                                  elevation: 5.0,
                                  child: Container(
                                      padding: EdgeInsets.all(4),
                                      height: height / 7,
                                      width: width / 2,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            'No Recent Posts in this category!',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'coiny',
                                                color: Colors.black26),
                                          )
                                        ],
                                      ))),
                                ),
                              );
                            }
                          } else {
                            return Center(
                              child: Card(
                                elevation: 5.0,
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    height: height / 7,
                                    width: width / 2,
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          'No Recent Posts in this category!',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: 'coiny',
                                              color: Colors.black26),
                                        )
                                      ],
                                    ))),
                              ),
                            );
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
                                  fontFamily: 'coiny',
                                  color: Colors.black54)),
                          backgroundColor: Colors.blue[200],
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
                            .orderByChild('category')
                            .equalTo('Teacher')
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
                                    Data1[individualKey]['pushkey'],
                                    Data1[individualKey]['userPhotoUrl'],
                                    Data1[individualKey]['userName'],
                                    Data1[individualKey]['userId'],
                                    Data1[individualKey]['category']);
                                if (Data1[individualKey]['confirm'] == 'Yes') {
                                  postTeacherList.add(posts);
                                }
                              }

                              return postTeacherList.length == 0
                                  ? Center(
                                      child: Card(
                                        elevation: 5.0,
                                        child: Container(
                                            padding: EdgeInsets.all(4),
                                            height: height / 7,
                                            width: width / 2,
                                            child: Center(
                                                child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                  'No Recent Posts in this category!',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontFamily: 'coiny',
                                                      color: Colors.black26),
                                                )
                                              ],
                                            ))),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: postTeacherList.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: width / 1.5,
                                          child: Card(
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: postTeacherList[
                                                                      index]
                                                                  .userPhotoUrl ==
                                                              null
                                                          ? Icon(
                                                              Icons.person,
                                                              color: Colors
                                                                  .purple[100],
                                                            )
                                                          : CircleAvatar(
                                                              backgroundImage: NetworkImage(
                                                                  postTeacherList[
                                                                          index]
                                                                      .userPhotoUrl),
                                                            ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10.0,
                                                                      top: 8),
                                                              child: Text(
                                                                '${postTeacherList[index].userName}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          8.0),
                                                              child: Text(
                                                                '${postTeacherList[index].title}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 3,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black87),
                                                              ),
                                                            ),
                                                            Text(
                                                              '${postTeacherList[index].post}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      // Expanded(
                                                      //   child:
                                                      // ),
                                                      Expanded(
                                                        child: Text(
                                                          '${postTeacherList[index].date}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            } else {
                              return Center(
                                child: Card(
                                  elevation: 5.0,
                                  child: Container(
                                      padding: EdgeInsets.all(4),
                                      height: height / 7,
                                      width: width / 2,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            'No Recent Posts in this category!',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'coiny',
                                                color: Colors.black26),
                                          )
                                        ],
                                      ))),
                                ),
                              );
                            }
                          } else {
                            return Center(
                              child: Card(
                                elevation: 5.0,
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    height: height / 7,
                                    width: width / 2,
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          'No Recent Posts in this category!',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: 'coiny',
                                              color: Colors.black26),
                                        )
                                      ],
                                    ))),
                              ),
                            );
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
                                  fontFamily: 'coiny',
                                  color: Colors.black54)),
                          backgroundColor: Colors.blue[200],
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
                            .orderByChild('category')
                            .equalTo('Doctor')
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
                                    Data1[individualKey]['pushkey'],
                                    Data1[individualKey]['userPhotoUrl'],
                                    Data1[individualKey]['userName'],
                                    Data1[individualKey]['userId'],
                                    Data1[individualKey]['category']);
                                if (Data1[individualKey]['confirm'] == 'Yes') {
                                  postDoctorList.add(posts);
                                }
                              }

                              return postDoctorList.length == 0
                                  ? Center(
                                      child: Card(
                                        elevation: 5.0,
                                        child: Container(
                                            padding: EdgeInsets.all(4),
                                            height: height / 7,
                                            width: width / 2,
                                            child: Center(
                                                child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                  'No Recent Posts in this category!',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontFamily: 'coiny',
                                                      color: Colors.black26),
                                                )
                                              ],
                                            ))),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: postDoctorList.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: width / 1.5,
                                          child: Card(
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: postDoctorList[
                                                                      index]
                                                                  .userPhotoUrl ==
                                                              null
                                                          ? Icon(
                                                              Icons.person,
                                                              color: Colors
                                                                  .purple[100],
                                                            )
                                                          : CircleAvatar(
                                                              backgroundImage: NetworkImage(
                                                                  postDoctorList[
                                                                          index]
                                                                      .userPhotoUrl),
                                                            ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10.0,
                                                                      top: 8),
                                                              child: Text(
                                                                '${postDoctorList[index].userName}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          8.0),
                                                              child: Text(
                                                                '${postDoctorList[index].title}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 3,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black87),
                                                              ),
                                                            ),
                                                            Text(
                                                              '${postDoctorList[index].post}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      // Expanded(
                                                      //   child:
                                                      // ),
                                                      Expanded(
                                                        child: Text(
                                                          '${postDoctorList[index].date}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            } else {
                              return Center(
                                child: Card(
                                  elevation: 5.0,
                                  child: Container(
                                      padding: EdgeInsets.all(4),
                                      height: height / 7,
                                      width: width / 2,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            'No Recent Posts in this category!',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'coiny',
                                                color: Colors.black26),
                                          )
                                        ],
                                      ))),
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
                                  fontFamily: 'coiny',
                                  color: Colors.black54)),
                          backgroundColor: Colors.blue[200],
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
                            .orderByChild('category')
                            .equalTo('Nurse')
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
                                    Data1[individualKey]['pushkey'],
                                    Data1[individualKey]['userPhotoUrl'],
                                    Data1[individualKey]['userName'],
                                    Data1[individualKey]['userId'],
                                    Data1[individualKey]['category']);
                                if (Data1[individualKey]['confirm'] == 'Yes') {
                                  postNurseList.add(posts);
                                }
                              }

                              return postNurseList.length == 0
                                  ? Center(
                                      child: Card(
                                        elevation: 5.0,
                                        child: Container(
                                            padding: EdgeInsets.all(4),
                                            height: height / 7,
                                            width: width / 2,
                                            child: Center(
                                                child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                  'No Recent Posts in this category!',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontFamily: 'coiny',
                                                      color: Colors.black26),
                                                )
                                              ],
                                            ))),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: postNurseList.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: width / 1.5,
                                          child: Card(
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: postNurseList[
                                                                      index]
                                                                  .userPhotoUrl ==
                                                              null
                                                          ? Icon(
                                                              Icons.person,
                                                              color: Colors
                                                                  .purple[100],
                                                            )
                                                          : CircleAvatar(
                                                              backgroundImage: NetworkImage(
                                                                  postNurseList[
                                                                          index]
                                                                      .userPhotoUrl),
                                                            ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10.0,
                                                                      top: 8),
                                                              child: Text(
                                                                '${postNurseList[index].userName}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          8.0),
                                                              child: Text(
                                                                '${postNurseList[index].title}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 3,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black87),
                                                              ),
                                                            ),
                                                            Text(
                                                              '${postNurseList[index].post}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      // Expanded(
                                                      //   child:
                                                      // ),
                                                      Expanded(
                                                        child: Text(
                                                          '${postNurseList[index].date}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            } else {
                              return Center(
                                child: Card(
                                  elevation: 5.0,
                                  child: Container(
                                      padding: EdgeInsets.all(4),
                                      height: height / 7,
                                      width: width / 2,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            'No Recent Posts in this category!',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'coiny',
                                                color: Colors.black26),
                                          )
                                        ],
                                      ))),
                                ),
                              );
                            }
                          } else {
                            return Center(
                              child: Card(
                                elevation: 5.0,
                                child: Container(
                                    padding: EdgeInsets.all(4),
                                    height: height / 7,
                                    width: width / 2,
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          'No Recent Posts in this category!',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: 'coiny',
                                              color: Colors.black26),
                                        )
                                      ],
                                    ))),
                              ),
                            );
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
                color: Colors.blue[300],
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
                color: Colors.blue[300],
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
                color: Colors.blue[300],
                onPressed: () {},
              ),
            ],
          ),
        ))) {
    }
  }
}
