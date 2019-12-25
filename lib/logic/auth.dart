import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:suhadhamaru/logic/SharedPreferenceHelper.dart';

String name;
String email;
String imageUrl;
String userId;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
FacebookLogin facebookLogin = FacebookLogin();

Future<FirebaseUser> signIn(String email, String password) async {
  // TODO: implement signIn
  AuthResult result =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
  FirebaseUser user = result.user;

  return user;
} 

Future<void> signOut() async {
  // TODO: implement signOut
  await _googleSignIn.signOut();
  return _auth.signOut();
}

Future<String> signUp(String email, String password) async {
  // TODO: implement signUp
  AuthResult result = await _auth.createUserWithEmailAndPassword(
      email: email, password: password);

  FirebaseUser user = result.user;
  return user.uid;
}

Future<FirebaseUser> getCurrentUser() async {
  // TODO: implement getCurrentUser
  FirebaseUser user = await _auth.currentUser();
  return user;
}

//google sign In
Future<FirebaseUser> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken);

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  // Checking if email and name is null
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;

  // Only taking the first part of the name, i.e., First Name
  // if (name.contains(" ")) {
  //   name = name.substring(0, name.indexOf(" "));
  // }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return user;
}

void signOutGoogle() async {
  await _googleSignIn.signOut();
  // print("User Sign Out");
}

Future<Null> logOut() async {
  await facebookLogin.logOut();
  // _showMessage('Logged out.');
}

Future<int> handleSignIn() async {
  FacebookLoginResult facebookLoginResult = await handleFBSignIn();
  final accessToken = facebookLoginResult.accessToken.token;
  if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
    final facebookAuthCred =
        FacebookAuthProvider.getCredential(accessToken: accessToken);
    final user = await _auth.signInWithCredential(facebookAuthCred);
    print("User : " + user.user.displayName);
    return 1;
  } else
    return 0;
}

Future<FacebookLoginResult> handleFBSignIn() async {
  var facebookLoginResult =
      await facebookLogin.logIn(['email', 'public_profile']);
  switch (facebookLoginResult.status) {
    case FacebookLoginStatus.cancelledByUser:
      print("Cancelled");
      break;
    case FacebookLoginStatus.error:
      print("error");
      break;
    case FacebookLoginStatus.loggedIn:
      print("Logged In");
      break;
  }
  return facebookLoginResult;
}
