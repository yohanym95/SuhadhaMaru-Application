import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/screens/login/login.dart';
import 'package:suhadhamaru/screens/login/signup.dart';

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

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
          body: Stack(
        children: <Widget>[clipper(), loginDetails()],
      )),
    );
  }

  List<Color> colorGradient = [
    Colors.blue[100],
    Colors.blue[200],
    Colors.blue[300],
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
                  AppLocalizations.of(context).tr('login.loginHome.loginPageTitle'),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'coiny',
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
                    AppLocalizations.of(context).tr('login.loginHome.alreadyAccount'),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'coiny',
                        color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                color: Colors.blue[300],
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
                    AppLocalizations.of(context).tr('login.loginHome.newAccount'),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'coiny',
                        color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                color: Colors.blue[300],
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
                colors: colorGradient,
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
