import 'package:flutter/material.dart';
import 'dart:async';
import 'package:page_view_cards/foryou.dart';
import 'package:page_view_cards/searchPage.dart';




class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Page View',
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
  List<Color> colors1 = [
    Colors.deepOrange,
    Colors.purple,
    Colors.yellow,
    Colors.redAccent,
    Colors.pinkAccent
  ];

  List<Color> colors2 = [
    Colors.indigo,
    Colors.purple,
    Colors.orange,
    Colors.indigoAccent,
    Colors.amber,
    Colors.red,
    Colors.green,
    Colors.lime,
  ];

  PageController pageController;
  int current = 1;
  bool cflag = false;
  

/**********Route Transition animation**********/
//-1.0 , 0.0 left to right
//0.0, 1.0 bottom to up

  Route _createRoute(double x, double y, var cls) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => cls,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(x,y);
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
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.75, initialPage: 1);
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      pageController.animateToPage(current,
          duration: Duration(milliseconds: 600), curve: Curves.easeInQuart);
      setState(() {
        if (current == 4) cflag = true;
        if (current == 0) cflag = false;
        if (cflag == false) {
          current++;
        } else if (cflag == true) {
          current--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final y = MediaQuery.of(context).size.height;
    final x = MediaQuery.of(context).size.width;

    Widget card(int index) {
      return AnimatedBuilder(
        animation: pageController,
        builder: (context, widget) {
          double value = 1;
          if (pageController.position.haveDimensions) {
            value = pageController.page - index;
            value = (1 - (value.abs() * 0.3)).clamp(0.0, 5.0);
          }
          return Center(
            child: SizedBox(
              height: Curves.easeInOut.transform(value) * y / 5,
              width: Curves.fastOutSlowIn.transform(value) * 300,
              child: widget,
            ),
          );
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: colors1[index],
          ),
        ),
      );
    }

    Widget roundmix(int index) {
      return SizedBox(
        height: y / 7 - 1,
        width: y / 7 - 1,
        child: Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            color: colors2[index],
          ),
        ),
      );
    }

    Widget recentlyPlayed(int index){
      return SizedBox(
        height: y/7-1,
        width: y/7-1,
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: y/9-1,
                width: y/9-1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  color: colors2[index]
                ),
              ),
              Text('Title')
            ],
          ),
        ),
      );
    }

    return Scaffold(
        
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                'Today',
                style: TextStyle(
                    fontSize: 34,
                    fontFamily: 'Salsa',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800),
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: y / 7,
            child: ListView.builder(
              itemCount: colors2.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return roundmix(index);
              },
            ),
          ),
          /************Music Animated Card PageView********** */
          Center(
            child: Container(
              alignment: Alignment.center,
              height: y / 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: PageView.builder(
                controller: pageController,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return card(index);
                },
                onPageChanged: (index){
                   current = index;     
                },
              ),
            ),
          ),
          /******************************************************/

          Container(
            margin: EdgeInsets.only(top: 2, bottom: 4),
            child: Text(' Recently Played', style: TextStyle(fontSize: 20, fontFamily: 'Salsa'),)),
          Container(
            alignment: Alignment.center,
            height: y/7,
            child: ListView.builder(
              itemCount: colors2.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return recentlyPlayed(index);
              },
            ),
          )

        ],
      ),
    );
  }
}
