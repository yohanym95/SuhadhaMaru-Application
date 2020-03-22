import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/logic/searchOption.dart';
import 'package:suhadhamaru/model/Post.dart';
import 'package:suhadhamaru/model/ProfileDetail.dart';
import 'package:suhadhamaru/screens/Post/Comments.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/screens/Profile/Profile.dart';
import 'package:suhadhamaru/screens/Profile/createProfile.dart';
import 'package:suhadhamaru/utils/DialogTrigger.dart';
import 'package:suhadhamaru/utils/PostUI.dart';
import 'package:suhadhamaru/utils/ovalrightborderclipper.dart';

class Recent extends StatefulWidget {
  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  //get information for drawer profile
  String url = imageUrl;
  String name1 = name;
  String email1 = email;
  String uid;

  //list for get recent posts data
  List<Posts> postList = [];
  //list for get user profile data
  List<ProfileDetails> profileData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentUser().then((user) {
      if (user != null) {
        uid = user.uid;
        userId = uid;
        print(uid);
        if (uid != null) {
          DatabaseReference database =
              FirebaseDatabase.instance.reference().child("Users");
          database.once().then((DataSnapshot data) {
            var Data1 = data.value;
            if (Data1 == null) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
                (Route<dynamic> route) => false,
              );
              print(' data null profile');
            } else {
              print(Data1);
              var keys = Data1.keys;

              print(keys);
              for (var key in keys) {
                print('key  ' + key);
                if (key == uid) {
                  setState(() {
                    name1 = Data1[key]['fullName'];
                    url = Data1[key]['photoUrl'];
                  });

                  break;
                } else {
                  print('profile profile');
                }
              }
            }
          });
        }
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Text(
              AppLocalizations.of(context).tr('homePage.recentPage.titleBar'),
              style:
                  TextStyle(fontFamily: 'coiny', fontWeight: FontWeight.bold)),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            )
          ],
        ),
        drawer: buildDrawer(),
        body: Container(
            child: Center(
          child: FutureBuilder(
            future: FirebaseDatabase.instance
                .reference()
                .child("Posts")
                .orderByChild('confirm')
                .equalTo('Yes')
                .once(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var Data1 = snapshot.data.value;
                if (Data1 != null) {
                  var keys = snapshot.data.value.keys;
                  postList.clear();

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
                      postList.add(posts);
                    }
                  }
                  return postList.length == 0
                      ? emptyPost(height, width)
                      : new ListView.builder(
                          itemCount: postList.length,
                          itemBuilder: (_, index) {
                            return postsUI(
                                postList[index].title,
                                postList[index].post,
                                postList[index].date,
                                postList[index].pushkey,
                                postList[index].userName,
                                postList[index].userPhotoUrl,
                                context);
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Image(
                                image: AssetImage("assests/emptypost.png"),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .tr('homePage.recentPage.noPost'),
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
              // return Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     CircularProgressIndicator(),
              //     new Text("Please wait! Posts are loading"),
              //   ],
              // );
              return ShimmerList();
            },
          ),
        )),
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

  //custom drawer
  buildDrawer() {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 40),
          decoration: BoxDecoration(
              color: Colors.blue,
              boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [
                          Colors.lightBlueAccent,
                          Colors.lightBlue
                        ])),
                    child: url == null
                        ? CircleAvatar(
                            child: Icon(
                            Icons.person,
                            color: Colors.blue[100],
                          ))
                        : CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(url),
                          ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  name1 == null ? Text('name') : Text(name1),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    child: buildRow(
                        Icons.person,
                        AppLocalizations.of(context)
                            .tr('homePage.navigateDrawer.profile')),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                  buildDivider(),
                  GestureDetector(
                    child: buildRow(
                        Icons.language,
                        AppLocalizations.of(context)
                            .tr('homePage.navigateDrawer.language')),
                    onTap: () {
                      _askLanguage(context);
                    },
                  ),
                  buildDivider(),
                  GestureDetector(
                    child: buildRow(
                        Icons.settings_power,
                        AppLocalizations.of(context)
                            .tr('homePage.navigateDrawer.logout')),
                    onTap: () {
                      dialogTrigger(context);
                    },
                  ),
                  buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      color: Colors.white,
    );
  }

  Widget buildRow(IconData icon, String title) {
    final TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 16);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: textStyle,
          )
        ],
      ),
    );
  }
}
