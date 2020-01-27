import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:suhadhamaru/logic/PostDetails.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/model/comment.dart';

class Comments extends StatefulWidget {
  String text;
  String category;
  String userphotoUrl, userName, userPostTitle, userPost, postDate;

  Comments(this.text, this.category, this.userphotoUrl, this.userName,
      this.userPostTitle, this.userPost, this.postDate);
  @override
  _CommentsState createState() => _CommentsState(
      this.text,
      this.category,
      this.userphotoUrl,
      this.userName,
      this.userPostTitle,
      this.userPost,
      this.postDate);
}

class _CommentsState extends State<Comments> {
  String text;
  String category;
  String userphotoUrl, userName, userPostTitle, userPost, postDate;
  String url = imageUrl;
  String name1 = name;

  _CommentsState(this.text, this.category, this.userphotoUrl, this.userName,
      this.userPostTitle, this.userPost, this.postDate);

  TextEditingController commentController = TextEditingController();
  final homeScaffoldKey = new GlobalKey<ScaffoldState>();

  List<Comment> postList = [];
  List<Comment> postListreversed = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(text);
    print(url);
    print(name1);
    print(category);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text('Comments'),
      ),
      body: commentsPage(height, context),
    );
  }

  Widget commentsPage(double height, BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(flex: 5, child: commentsList(context)),
          // Expanded(
          //   flex: 1,
          //   child: Container(),
          // ),
          Expanded(flex: 1, child: commentText(height))
        ],
      ),
    );
  }

  Widget commentText(double height) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Container(
                  // height: 50,
                  child: TextFormField(
                    controller: commentController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your comments';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Write Your Comment..',
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 14.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Icon(
                    Icons.send,
                    color: Colors.purple,
                  ),
                  onTap: () {
                    saveComment(
                        homeScaffoldKey.currentState, context, category);
                  },
                ),
              )
            ],
          )),
    );
  }

  Widget commentsList(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FutureBuilder(
            future: FirebaseDatabase.instance
                .reference()
                .child("Comments")
                .child(category)
                .orderByChild('key')
                .equalTo(text)
                .once(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var Data1 = snapshot.data.value;
                if (Data1 != null) {
                  var keys = snapshot.data.value.keys;

                  postList.clear();

                  for (var individualKey in keys) {
                    Comment comments = new Comment(
                        Data1[individualKey]['comment'],
                        Data1[individualKey]['photourl'],
                        Data1[individualKey]['userName'],
                        Data1[individualKey]['date'],
                        Data1[individualKey]['key']);
                    // if (Data1[individualKey]['key'] == text) {
                    postList.add(comments);
                    print(Data1[individualKey]['comment']);

                    ///  postListreversed = postList.reversed;

                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: postList.length,
                    itemBuilder: (_, index) {
                      // return Text('${postList[index].comment}');

                      return Card(
                        child: ListTile(
                          leading: postList[index].photoUrl == null
                              ? Icon(
                                  Icons.people,
                                  color: Colors.purple[100],
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(postList[index].photoUrl),
                                ),
                          title: Text('${postList[index].userName}'),
                          subtitle: Text(
                              '${postList[index].comment} \n ${postList[index].date}'),
                        ),
                      );
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
                                child: Icon(
                              Icons.message,
                              size: 50,
                            )),
                            Text(
                              'No Comments in this post yet!',
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

              return ShimmerList();
            }),
      ),
    );
  }

  Future<void> saveComment(
      ScaffoldState scaffold, BuildContext context, String category) async {
    // String key = database.child("Post").push().key;

    String date = DateFormat.yMMMd().format(DateTime.now());

    var post = <String, dynamic>{
      'key': text,
      'comment': commentController.text,
      'photourl': url,
      'userName': name1,
      'date': date
    };

    return PostDetails().addComment(post, context, category).then((onValue) {
      // setState(() {
      // // _isLoading = onValue;
      // });
      scaffold.showSnackBar(new SnackBar(
        content: new Text("Added your comment."),
      ));
      commentController.clear();
    }).catchError((onError) {
      //   setState(() {
      //  //  _isLoading = false;
      //   });
      scaffold.showSnackBar(new SnackBar(
        content: new Text("Some Error occured. Please Try Again"),
      ));
      commentController.clear();
    });
  }

  Widget loaderWaveComment() {
    return Center(
      child: SpinKitWave(
        color: Colors.purpleAccent,
        size: 50.0,
      ),
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
              SizedBox(
                height: 5,
              ),
              Container(
                height: containerHeight,
                width: containerWidth * 0.50,
                color: Colors.grey,
              ),
            ],
          )
        ],
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
          time = 800 + offset;

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
