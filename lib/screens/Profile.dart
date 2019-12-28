import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/model/ProfileDetail.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DatabaseReference db;
  ProfileDetails profileDetails;
  bool isLoad = false;
  Map<dynamic, dynamic> values;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getProfileDetails();
    // if (values != null) {
    //   isLoad = false;
    // } else {
    //   isLoad = true;
    // }
    print('userid::::  ' + userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              margin: EdgeInsets.all(5),
              child: FutureBuilder(
                future: FirebaseDatabase.instance
                    .reference()
                    .child('Users')
                    .child(userId)
                    .once(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // return Text('${snapshot.data.value['photoUrl']}');
                    return Card(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      snapshot.data.value['photoUrl']),
                                  radius: 60,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 15, bottom: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            'Name',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                              ': ${snapshot.data.value['fullName']}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)))
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text('Email',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                              ': ${snapshot.data.value['email']}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)))
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text('City',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                              ': ${snapshot.data.value['currentCity']}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)))
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text('Job Category',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Text(
                                              ': ${snapshot.data.value['category']}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Center(
                            child: new Text(
                          "Loading Your Profile Data",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }

// ? Center(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       CircularProgressIndicator(),
//                       Center(
//                           child: new Text(
//                         "Loading Your Profile Data",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       )),
//                     ],
//                   ),
//                 )
//               : getProfile(),
  Widget getProfile() {
    return Center(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(profileDetails.photoUrl),
            radius: 60,
            backgroundColor: Colors.transparent,
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text('Name :'),
                  ),
                  Text('${profileDetails.fullName}')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Future<Map> getProfileDetails() async {
  //   db = FirebaseDatabase.instance.reference().child('Users').child(userId);

  //   db.once().then((DataSnapshot snapshot) {
  //     // values = snapshot.value;
  //     // print(values['fullName']);
  //     // print(values['email']);
  //     // print(values['category']);
  //     // print(values['currentCity']);
  //     // print(values['photoUrl']);

  //     //   profileDetails = new ProfileDetails(values['fullName'], values['email'],
  //     //       values['category'], values['currentCity'], values['photoUrl']);

  //     //   if (profileDetails != null) {
  //     //     print(profileDetails.fullName);
  //     //     print(profileDetails.email);
  //     //     print(profileDetails.category);
  //     //     print(profileDetails.currentCity);
  //     //     print(profileDetails.photoUrl);
  //     //     isLoad = true;
  //     //   }
  //   });

  //   return sna;
  // }
}
