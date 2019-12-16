import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/main.dart';
import 'package:suhadhamaru/model/Post.dart';
import 'package:suhadhamaru/screens/AddPost.dart';

class PolicePost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PolicePostState();
  }
}

class PolicePostState extends State<PolicePost> {
  String userId;
  List<Posts> postList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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

             if(Data1[individualKey]['confirm'] == "Yes"){
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
        backgroundColor: Colors.pink[300],
        title: Text('Police'),
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
                    return postsUI(postList[index].title, postList[index].post, postList[index].date);
                },
              ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
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

  Widget postsUI(String title,String description,String date){
    return new Card(
      elevation: 10.0,
      margin: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(title,style: Theme.of(context).textTheme.title,textAlign: TextAlign.center,),
             new Text(date,style: Theme.of(context).textTheme.subtitle),
              new Text(description,style: Theme.of(context).textTheme.subtitle)
          ],
        ),
      ),
    );

  }
}
