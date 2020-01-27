import 'package:firebase_database/firebase_database.dart';


class PostDetails{
  Future<bool> addPost(postData,context,key) async {
    FirebaseDatabase.instance
        .reference()
        .child('Posts')
        .child(key)
        .set(postData)
        .then((onValue) {
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomePage()),
      //   (Route<dynamic> route) => false,
      // );
      return false;
    }).catchError((onError) {
      return false;
    });

    return false;
  }

  Future<bool> addComment(postData, context, category) async {
    FirebaseDatabase.instance
        .reference()
        .child('Comments')
        .child(category)
        .push()
        .set(postData)
        .then((onValue) {
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomePage()),
      //   (Route<dynamic> route) => false,
      // );
      return false;
    }).catchError((onError) {
      return false;
    });

    return false;
  }
}