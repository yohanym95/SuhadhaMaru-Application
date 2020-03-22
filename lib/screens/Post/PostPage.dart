import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:suhadhamaru/model/Post.dart';
import 'package:suhadhamaru/screens/Post/AddPost.dart';
import 'package:suhadhamaru/screens/Post/Comments.dart';
import 'package:suhadhamaru/utils/PostUI.dart';

class PostPage extends StatefulWidget {
  String category;

  PostPage(this.category);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PostPageState(this.category);
  }
}

class PostPageState extends State<PostPage> {
  String userId;
  List<Posts> postList = [];
  String category;
  String titleBarName;

  PostPageState(this.category);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(category);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var data = EasyLocalizationProvider.of(context).data;

    if (category == 'Doctor') {
      titleBarName =
          AppLocalizations.of(context).tr('post.postPage.titleDoctor');
    } else if (category == 'Police') {
      titleBarName =
          AppLocalizations.of(context).tr('post.postPage.titlePolice');
    } else if (category == 'Teacher') {
      titleBarName =
          AppLocalizations.of(context).tr('post.postPage.titleTeacher');
    } else if (category == 'Nurse') {
      titleBarName =
          AppLocalizations.of(context).tr('post.postPage.titleNurse');
    }
    // TODO: implement build
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
            title: Text(titleBarName,
                style: TextStyle(
                    fontFamily: 'coiny', fontWeight: FontWeight.bold))),
        body: Container(
            child: Center(
          child: FutureBuilder(
            future: FirebaseDatabase.instance
                .reference()
                .child("Posts")
                .orderByChild('category')
                .equalTo(category)
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
                                postList[index].userPhotoUrl);
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
                                  .tr('post.postPage.noPost'),
                              textAlign: TextAlign.center,
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Post(category)),
            );
          },
        ),
      ),
    );
  }

  Widget postsUI(String title, String description, String date, String key,
      String userName, String userPhotoUrl) {
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
                              fontWeight: FontWeight.w500, fontSize: 19),
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
                                            category,
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
            ],
          )),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    double containerHeight = 20;
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircleAvatar(
              child: Container(
                height: 100,
                width: 100,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: containerHeight,
                  width: containerWidth * 0.70,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: containerHeight,
                  width: containerWidth * 0.70,
                  color: Colors.grey,
                ),
                // SizedBox(
                //   height: 5,
                // ),
                // Container(
                //   height: containerHeight,
                //   width: containerWidth * 0.50,
                //   color: Colors.grey,
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;
    // TODO: implement build
    return SafeArea(
      child: ListView.builder(
        itemCount: 9,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 1000 + offset;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Shimmer.fromColors(
              highlightColor: Colors.white,
              baseColor: Colors.grey[300],
              child: ShimmerLayout(),
              period: Duration(milliseconds: time),
            ),
          );
        },
      ),
    );
  }
}
