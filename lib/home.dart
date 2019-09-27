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

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                var object = forYou();
                Navigator.push(context, _createRoute(-1.0,0.0,object));
              },
              child: Container(
                  alignment: Alignment.center,
                  width: 30,
                  margin: EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      )),
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    size: 30,
                  )),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              'musicOn',
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.deepOrange,
                  fontFamily: 'Srisakdi',
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => searchPage()),
              );
            },
            icon: Icon(
              Icons.search,
              color: Colors.black,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.music_video,
              color: Colors.black,
              size: 26,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
          ),
        ],
      ),
        
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
              ),
            ),
          ),
          /******************************************************/
        ],
      ),
    );
  }
}
