import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/model/Post.dart';
import 'package:suhadhamaru/screens/AddPost.dart';
import 'package:suhadhamaru/screens/Comments.dart';

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

  PostPageState(this.category);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(category);

    DatabaseReference database =
        FirebaseDatabase.instance.reference().child("Posts").child(category);
    database.once().then((DataSnapshot data) {
      var keys = data.value.keys;
      var Data1 = data.value;

      postList.clear();

      for (var individualKey in keys) {
        Posts posts = new Posts(
            Data1[individualKey]['title'],
            Data1[individualKey]['Post'],
            Data1[individualKey]['date'],
            Data1[individualKey]['confirm'],
            Data1[individualKey]['pushkey']);

        if (Data1[individualKey]['confirm'] == "Yes") {
          postList.add(posts);
        }
      }

      setState(() {
        print(postList.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: Text(category,
            style: TextStyle(fontFamily: 'coiny', fontWeight: FontWeight.bold)),
      ),
      body: Container(
          child: Center(
        child: postList.length == 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  new Text("Please wait! Posts are loading"),
                ],
              )
            : new ListView.builder(
                itemCount: postList.length,
                itemBuilder: (_, index) {
                  return postsUI(postList[index].title, postList[index].post,
                      postList[index].date, postList[index].pushkey);
                },
              ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Post()),
          );
        },
      ),
    );
  }

  Widget postsUI(String title, String description, String date, String key) {
    return GestureDetector(
      child: new Card(
        color: Colors.purple[50],
        elevation: 10.0,
        margin: EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(3),
                child: new Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  margin: EdgeInsets.all(3),
                  child: new Text(description,
                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17))),
              Container(
                margin: EdgeInsets.all(2),
                  child: new Text(date,
                      style: Theme.of(context).textTheme.subtitle)),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Comments(key, category),
          ),
        );
      },
    );
  }
}
