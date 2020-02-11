import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final category = ["Doctor", "Teacher", "Police", "Nurse"];

  final recentCatagory = [
    "Doctor",
    "Teacher",
  ];

  DataSearch(cities, recentCities);

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    //actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    //leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // show some results based on the selection
    // return Center(
    //   child: Card(
    //     color: Colors.red,
    //     child: Center(
    //       child: Text(query),
    //     ),
    //   ),
    // );
    return FutureBuilder(
      future: FirebaseDatabase.instance
          .reference()
          .child("Posts")
          .orderByChild('categpory')
          .equalTo(query)
          .once(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return;
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    //show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentCatagory
        : category.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
        onTap: () {
          showResults(context);
        },
      ),
      itemCount: suggestionList.length,
    );
  }
}
