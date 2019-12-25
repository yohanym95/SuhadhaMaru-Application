import 'package:flutter/material.dart';
import 'package:suhadhamaru/logic/auth.dart';
import 'package:suhadhamaru/screens/HomePage.dart';
import 'package:suhadhamaru/screens/login.dart';
import 'package:suhadhamaru/screens/signup.dart';

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);

  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   signedIn(); 
    // });
  }

  // void signedIn() {
    // Auth().getCurrentUser().then((user) {
    //   if (user != null) {
    //     setState(() {
    //       Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(builder: (context) => HomePage()),
    //       (Route<dynamic> route) => false,
    //     );
    //     });
    //   } 
    // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[clipper(), loginDetails()],
    ));
  }

  List<Color> orangeGradient = [
    Colors.pink[100],
    Colors.pink[200],
    Colors.pink[300],
  ];

  Widget loginDetails() {
    return Container(
      alignment: Alignment.center,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: Icon(
                Icons.transfer_within_a_station,
                size: 100.0,
                color: Colors.indigo[300],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'සුහඳ මාරු',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 30, left: 30),
              child: MaterialButton(
                minWidth: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Alreay Have Account',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                color: Colors.pinkAccent,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 30, left: 30),
              child: MaterialButton(
                minWidth: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 10, right: 10),
                  child: Text(
                    'Create New Account',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                color: Colors.pinkAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget clipper() {
    return ClipPath(
      clipper: TopClipper(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: orangeGradient,
                begin: Alignment.topLeft,
                end: Alignment.topCenter)),
      ),
    );
  }
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - size.height / 3);

    // //creating first curver near bottom left corner
    // var firstControlPoint = new Offset(size.width / 7, size.height - 30);
    // var firstEndPoint = new Offset(size.width / 6, size.height / 1.5);

    // path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
    //     firstEndPoint.dx, firstEndPoint.dy);

    //creating second curver near center
    var secondControlPoint = Offset(size.width / 5, size.height / 4);
    var secondEndPoint = Offset(size.width / 1.5, size.height / 5);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    //creating third curver near top right corner
    var thirdControlPoint =
        Offset(size.width - (size.width / 10), size.height / 6);
    var thirdEndPoint = Offset(size.width, 0.0);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    ///move to top right corner
    path.lineTo(size.width, 0.0);

    ///finally close the path by reaching start point from top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}