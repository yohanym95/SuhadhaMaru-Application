import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/screens/HomePage/AddPosts.dart';
import 'package:suhadhamaru/screens/HomePage/Category.dart';
import 'package:suhadhamaru/screens/HomePage/Recent.dart';
import 'package:suhadhamaru/screens/Profile/Profile.dart';

class HomePages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePagesState();
  }
}

class HomePagesState extends State<HomePages> {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    // TODO: implement build
    return EasyLocalizationProvider(
        data: data,
        child: Scaffold(
          body: PageView(
            physics: new NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: <Widget>[
              Recent(),
              Categories(),
              ProfilePage(),
              AddPost()
            ],
            onPageChanged: (int index) {
              setState(() {
                _pageController.jumpToPage(index);
              });
            },
          ),
          bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            animationDuration: Duration(microseconds: 300),
            index: 0,
            animationCurve: Curves.bounceOut,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.blue[50],
            color: Colors.blueAccent,
            items: <Widget>[
              Icon(Icons.view_list),
              Icon(Icons.category),
              Icon(Icons.person),
              Icon(Icons.add),
            ],
            onTap: (index) {
              setState(() {
                _pageController.jumpToPage(index);
              });
            },
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
