import 'package:flutter/material.dart';
import 'package:suhadhamaru/screens/Post/Comments.dart';

Widget postsUI(String title, String description, String date, String key,
    String userName, String userPhotoUrl, BuildContext context) {
  return new Card(
    color: Colors.white,
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
                        //  textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(3),
                      child: new Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
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
                                          'category',
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

Widget emptyPost(double height, double width) {
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
                  fontSize: 11, fontFamily: 'coiny', color: Colors.black26),
            )
          ],
        ))),
  );
}
