import 'package:flutter/material.dart';
import 'package:suhadhamaru/screens/PolicePost.dart';

Widget homeList(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Container(
    // height: MediaQuery.of(context).size.height - 180.0,
    padding: EdgeInsets.only(top: 20, right: 8, left: 8),
    decoration: BoxDecoration(
        color: Colors.pink[300],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            child: Chip(
              label: Text('Police',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
              backgroundColor: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PolicePost()),
              );
            },
          ),
        ),
        SizedBox(
          height: height / 6,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, i) {
              return Container(
                //alignment: Alignment.center,
                margin: EdgeInsets.only(left: 4),
                width: width / 1.5,
                //height: height / 5,
                child: Card(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 5),
                      child: Text(
                        'I want to transfer from my job to anuradhapura',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'I am from anuradhapura. but now i work in kalutara north police station. my family live in anuradhapura. so i want make a transfer to them',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Chip(
            label: Text('Police',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(
          height: height / 6,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, i) {
              return Container(
                //alignment: Alignment.center,

                margin: EdgeInsets.only(left: 4),

                width: width / 1.5,

                //height: height / 5,

                child: Card(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 5),
                      child: Text(
                        'I want to transfer from my job to anuradhapura',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'I am from anuradhapura. but now i work in kalutara north police station. my family live in anuradhapura. so i want make a transfer to them',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Chip(
            label: Text('Police',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(
          height: height / 6,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, i) {
              return Container(
                //alignment: Alignment.center,

                margin: EdgeInsets.only(left: 4),

                width: width / 1.5,

                //height: height / 5,

                child: Card(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 5),
                      child: Text(
                        'I want to transfer from my job to anuradhapura',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'I am from anuradhapura. but now i work in kalutara north police station. my family live in anuradhapura. so i want make a transfer to them',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Chip(
            label: Text('Police',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(
          height: height / 6,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, i) {
              return Container(
                //alignment: Alignment.center,

                margin: EdgeInsets.only(left: 4),

                width: width / 1.5,

                //height: height / 5,

                child: Card(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 5),
                      child: Text(
                        'I want to transfer from my job to anuradhapura',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'I am from anuradhapura. but now i work in kalutara north police station. my family live in anuradhapura. so i want make a transfer to them',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
