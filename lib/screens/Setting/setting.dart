import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/screens/Profile/editProfile.dart';
import 'package:suhadhamaru/screens/login/reset.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _userId = userId;
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  DatabaseReference database =
      FirebaseDatabase.instance.reference().child('Notification');

  bool appUpdateNotification, postNotification;

  @override
  void initState() {
    // TODO: implement initState

    getCurrentUser().then((user) {
      _userId = user.uid;

      print('idddd:: $_userId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Setting',
            style: TextStyle(fontFamily: 'coiny', fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder(
                future: FirebaseDatabase.instance
                    .reference()
                    .child('Users')
                    .child(_userId)
                    .once(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Card(
                      elevation: 8.0,
                      margin: const EdgeInsets.all(7.0),
                      color: Colors.blue,
                      child: ListTile(
                        title: Text('${snapshot.data.value['fullName']}',
                            style: TextStyle(
                                fontFamily: 'coiny',
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${snapshot.data.value['photoUrl']}'),
                        ),
                        trailing: Icon(Icons.edit),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile()),
                          );
                        },
                      ),
                    );
                  }
                  return Card(
                    margin: const EdgeInsets.all(7.0),
                    color: Colors.blue,
                    child: ListTile(
                      title: Text('Edit Profile',
                          style: TextStyle(
                              fontFamily: 'coiny',
                              fontWeight: FontWeight.bold)),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                      trailing: Icon(Icons.edit),
                      onTap: () {},
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.lock_outline,
                        color: Colors.blue,
                      ),
                      title: Text('Change Password'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPassword()),
                        );
                      },
                    ),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(
                        Icons.language,
                        color: Colors.blue,
                      ),
                      title: Text('Change Language'),
                      onTap: () {},
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Notification Setting',
                style: TextStyle(color: Colors.black87),
              ),
              FutureBuilder(
                future: database.child(_userId).once(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.value['Postsubscribe'] == 'Yes') {
                      postNotification = true;
                    } else {
                      postNotification = false;
                    }
                    return SwitchListTile(
                      value: postNotification,
                      onChanged: (val) {
                        if (val) {
                          database
                              .child(_userId)
                              .child('Postsubscribe')
                              .set('Yes')
                              .then((onValue) {
                            //subscribe
                            firebaseMessaging.subscribeToTopic('Post');
                          });
                        } else {
                          database
                              .child(_userId)
                              .child('Postsubscribe')
                              .set('No')
                              .then((onValue) {
                            //Unsubscribe
                            firebaseMessaging.unsubscribeFromTopic('Post');
                          });
                        }
                      },
                      activeColor: Colors.blue,
                      contentPadding: const EdgeInsets.all(0),
                      title: Text('Post Notification'),
                    );
                  }
                  return SwitchListTile(
                    value: true,
                    onChanged: (val) {},
                    activeColor: Colors.blue,
                    contentPadding: const EdgeInsets.all(0),
                    title: Text('Post Notification'),
                  );
                },
              ),
              FutureBuilder(
                future: database.child(_userId).once(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.value['AppUpdateSubscribe'] == 'Yes') {
                      postNotification = true;
                    } else {
                      postNotification = false;
                    }
                    return SwitchListTile(
                      value: postNotification,
                      onChanged: (val) {
                        if (val) {
                          database
                              .child(_userId)
                              .child('AppUpdateSubscribe')
                              .set('Yes')
                              .then((onValue) {
                            //subscribe
                            firebaseMessaging.subscribeToTopic('AppUpdate');
                          });
                        } else {
                          database
                              .child(_userId)
                              .child('AppUpdateSubscribe')
                              .set('No')
                              .then((onValue) {
                            //Unsubscribe
                            firebaseMessaging.unsubscribeFromTopic('AppUpdate');
                          });
                        }
                      },
                      activeColor: Colors.blue,
                      contentPadding: const EdgeInsets.all(0),
                      title: Text('App Update Notification'),
                    );
                  }
                  return SwitchListTile(
                    value: true,
                    onChanged: (val) {},
                    activeColor: Colors.blue,
                    contentPadding: const EdgeInsets.all(0),
                    title: Text('App Update Notification'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
