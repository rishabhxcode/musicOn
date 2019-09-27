import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:page_view_cards/player.dart';
import 'package:page_view_cards/home.dart';
import 'package:page_view_cards/myMusic.dart';
import 'package:page_view_cards/radio.dart';
import 'package:page_view_cards/voiceSearch.dart';
import 'package:page_view_cards/foryou.dart';
import 'package:page_view_cards/searchPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
  String playpause = '';
  int playpauseflag = 0;

  Route _createRoute(double x, double y, var cls) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => cls,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(x, y);
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

  List<Widget> pages = [Home(), VoiceSearch(), MyRadio(), MyMusic()];
  int _pageIndex = 0;
  Color page1 = Colors.red;
  Color page2 = Colors.black87;
  Color page3 = Colors.black87;
  Color page4 = Colors.black87;
  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.width;
    final y = MediaQuery.of(context).size.height;
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
      body: pages[_pageIndex],
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 120,
          child: Column(
            children: <Widget>[
              /*************Seek Bar Container**************/
              GestureDetector(
                onVerticalDragEnd: (DragEndDetails details) {
                  print('vertical $details');
                  var object = Player();
                  Navigator.push(context, _createRoute(0.0, 1.0, object));
                },
                onHorizontalDragEnd: (DragEndDetails details) {},
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                    )
                  ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 46,
                            width: 46,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          Container(
                            width: x / 1.5,
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Song Title',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'SubTitle-Artist Name',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (playpauseflag == 0) {
                                  playpauseflag = 1;
                                  playpause = 'play to pause';
                                } else {
                                  if (playpause == 'play to pause')
                                    playpause = 'pause to play';
                                  else if (playpause == 'pause to play')
                                    playpause = 'play to pause';
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(2),
                              height: 32,
                              width: 32,
                              child: FlareActor(
                                'assets/play_pause_actor.flr',
                                alignment: Alignment.center,
                                color: Colors.red,
                                animation: playpause,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              /************************************/
              /****************Navigation bar*********************/
              Material(
                elevation: 10,
                child: Container(
                  height: 60,
                  color: Colors.grey.shade50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            setState(() {
                              _pageIndex = 0;
                              page1 = Colors.redAccent;
                              page2 = Colors.black87;
                              page3 = Colors.black87;
                              page4 = Colors.black87;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(1),
                            height: 30,
                            width: 30,
                            child: FlareActor(
                              'assets/home_icon.flr',
                              color: page1,
                              fit: BoxFit.contain,
                            ),
                          )),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _pageIndex = 1;
                            page2 = Colors.redAccent;
                            page1 = Colors.black87;
                            page3 = Colors.black87;
                            page4 = Colors.black87;
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          padding: EdgeInsets.all(1),
                          child: FlareActor(
                            'assets/voices_icon.flr',
                            color: page2,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _pageIndex = 2;
                            page3 = Colors.redAccent;
                            page2 = Colors.black87;
                            page1 = Colors.black87;
                            page4 = Colors.black87;
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          padding: EdgeInsets.all(1),
                          child: FlareActor(
                            'assets/radio_icon.flr',
                            color: page3,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _pageIndex = 3;
                            page4 = Colors.redAccent;
                            page2 = Colors.black87;
                            page3 = Colors.black87;
                            page1 = Colors.black87;
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          padding: EdgeInsets.all(2),
                          child: FlareActor(
                            'assets/music_icon.flr',
                            color: page4,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              /***********************************************/
            ],
          ),
        ),
      ),
    );
  }
}
