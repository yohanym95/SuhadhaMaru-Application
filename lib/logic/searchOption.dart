import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/model/Post.dart';
import 'package:suhadhamaru/screens/Post/Comments.dart';
import 'package:suhadhamaru/utils/PostUI.dart';

class DataSearch extends SearchDelegate<String> {
  final category = ["Doctor", "Teacher", "Police", "Nurse"];

  final recentCatagory = [
    "Doctor",
    "Teacher",
  ];

  List<Posts> searchPostList = [];

  DataSearch();

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    //actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    //leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement buildResults
    // show some results based on the selection
    // return Center(
    //   child: Card(
    //     color: Colors.red,
    //     child: Center(
    //       child: Text(query),
    //     ),
    //   ),
    // );
    recentCatagory.add(query);
    return FutureBuilder(
      future: FirebaseDatabase.instance
          .reference()
          .child("Posts")
          .orderByChild('category')
          .equalTo(query.toLowerCase())
          .once(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var Data1 = snapshot.data.value;
          if (Data1 != null) {
            var keys = snapshot.data.value.keys;
            searchPostList.clear();

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
                searchPostList.add(posts);
              }
            }
            return searchPostList.length == 0
                ? Center(
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
                              'No Posts in this category yet!',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'coiny',
                                  color: Colors.black26),
                            )
                          ],
                        ))),
                  )
                : new ListView.builder(
                    itemCount: searchPostList.length,
                    itemBuilder: (_, index) {
                      return postsUI(
                          searchPostList[index].title,
                          searchPostList[index].post,
                          searchPostList[index].date,
                          searchPostList[index].pushkey,
                          searchPostList[index].userName,
                          searchPostList[index].userPhotoUrl,
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    //show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentCatagory
        : category.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
        onTap: () {
          showResults(context);
        },
      ),
      itemCount: suggestionList.length,
    );
  }
}
