import 'package:flutter/material.dart';

class searchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final y = MediaQuery.of(context).size.height;
    final x = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(child: Text('Search Page..'),),
    );
  }
}
