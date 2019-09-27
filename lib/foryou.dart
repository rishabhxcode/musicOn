import 'package:flutter/material.dart';
import 'package:page_view_cards/main.dart';

class forYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'For You',
      theme: ThemeData(
        primarySwatch: Colors.red,
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
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MyApp(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInSine;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );
        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final y = MediaQuery.of(context).size.height;
    final x = MediaQuery.of(context).size.width;
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, bool inner) {
            return <Widget>[
              SliverAppBar(
                title: Text(
                  'musicOn',
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontFamily: 'Srisakdi',
                      fontSize: 24,
                      fontWeight: FontWeight.w900),
                ),
                backgroundColor: Colors.white,
                expandedHeight: 60,
                floating: true,
                pinned: false,
                snap: true,
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, _createRoute());
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                    ),
                  )
                ],
              ),
            ];
          },
          
          body: 
                      ListView(
                      children: <Widget>[
                Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      child: Text(
                        'Your Library',
                        style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'Salsa',
                            color: Colors.grey.shade800),
                      )),
                      Container(
                        height: double.maxFinite,
                        color: Colors.yellow,
                      )
              ],
            ),
          )
    );
  }
}
