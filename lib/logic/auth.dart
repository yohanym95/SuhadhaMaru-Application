import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';


class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  
  Future<FirebaseUser> getCurrentUser() async {
    // TODO: implement getCurrentUser
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

 
  Future<bool> isEmailVerified() async {
    // TODO: implement isEmailVerified
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  
  Future<void> sendEmailVerification() async {
    // TODO: implement sendEmailVerification
    FirebaseUser user = await _firebaseAuth.currentUser();

    user.sendEmailVerification();
  }

  
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
