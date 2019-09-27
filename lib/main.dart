import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:page_view_cards/player.dart';
import 'package:page_view_cards/home.dart';
import 'package:page_view_cards/myMusic.dart';
import 'package:page_view_cards/radio.dart';
import 'package:page_view_cards/voiceSearch.dart';

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


List<Widget> pages =[Home(),VoiceSearch(),MyRadio(),MyMusic()];
int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.width;
    final y = MediaQuery.of(context).size.height;
    return Scaffold(
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
                   Navigator.push(context, _createRoute(0.0,1.0, object));
                
                },
                onHorizontalDragEnd: (DragEndDetails details){
                },
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
                            onTap: (){
                              setState(() { 
                                if(playpauseflag == 0){
                                  playpauseflag=1;
                                  playpause = 'play to pause';
                                }
                                else{
                               if(playpause == 'play to pause')
                               playpause='pause to play';
                               else if(playpause == 'pause to play')
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
                        onTap: (){
                          setState(() {
                           _pageIndex = 0; 
                          });
                        },
                        child: Icon(Icons.home)),
                      InkWell(
                          onTap: (){
                            setState(() {
                              _pageIndex = 1;
                            });
                          },
                          child: Icon(Icons.keyboard_voice)),
                      InkWell(
                          onTap: (){
                            setState(() {
                              _pageIndex = 2;
                            });
                          },
                          child: Icon(Icons.radio)),
                      InkWell(
                          onTap: (){
                            setState(() {
                              _pageIndex = 3;
                            });
                          },
                          child: Icon(Icons.library_music)),

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
