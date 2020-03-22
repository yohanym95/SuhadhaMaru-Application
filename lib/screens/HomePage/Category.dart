import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:suhadhamaru/screens/Post/PostPage.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Text(
              AppLocalizations.of(context)
                  .tr('homePage.categoryPage.categories'),
              style:
                  TextStyle(fontFamily: 'coiny', fontWeight: FontWeight.bold)),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 50.0),
          child: GridView(
            physics: BouncingScrollPhysics(),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: <Widget>[
              GestureDetector(
                child: Card(
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: 150.0,
                            height: 150.0,
                            child:
                                Image(image: AssetImage('assests/police.png')),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .tr('homePage.categoryPage.police'),
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostPage('Police')),
                  );
                },
              ),
              GestureDetector(
                child: Card(
                    elevation: 10.0,
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: 150.0,
                            height: 150.0,
                            child:
                                Image(image: AssetImage('assests/doctor.png')),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .tr('homePage.categoryPage.doctor'),
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostPage('Doctor')),
                  );
                },
              ),
              GestureDetector(
                child: Card(
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: 150.0,
                            height: 150.0,
                            child:
                                Image(image: AssetImage('assests/teacher.png')),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .tr('homePage.categoryPage.teacher'),
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostPage('Teacher')),
                  );
                },
              ),
              GestureDetector(
                child: Card(
                    margin: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: 150.0,
                            height: 150.0,
                            child:
                                Image(image: AssetImage('assests/nurse.png')),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .tr('homePage.categoryPage.Nurse'),
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostPage('Nurse')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
