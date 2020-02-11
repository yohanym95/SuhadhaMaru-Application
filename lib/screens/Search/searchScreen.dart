import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  String categoryKey;
  String searchKey;
  SearchScreen(this.categoryKey,this.searchKey);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() { 
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
    );
  }
}