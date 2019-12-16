import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';


class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  
  Future<String> signIn(String email, String password) async {
    // TODO: implement signIn
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;

    return user.uid;
  }

  
  Future<void> signOut() async {
    // TODO: implement signOut
    return _firebaseAuth.signOut();
  }

 
  Future<String> signUp(String email, String password) async {
    // TODO: implement signUp
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    FirebaseUser user = result.user;
    return user.uid;
  }
}
