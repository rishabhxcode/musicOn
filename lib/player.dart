import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class Player extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
  String playanim = '';
  int playanimflag = 0;
  String eqloop = 'stop';
  Color eqcolor = Colors.white;
  int repeatflag = 0;
  Color repeatcolor;
  Icon repeatIcon;

  @override
  void initState() {
    super.initState();
    
     repeatcolor = Colors.white;
    repeatIcon = Icon(Icons.repeat, color: Colors.white,);
  }

  @override
  Widget build(BuildContext context) {
    final y = MediaQuery.of(context).size.height;
    final x = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: y,
        width: x,
        color: Colors.lightGreenAccent,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: y / 20,
              left: x * 0.02,
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 40,
              ),
            ),
            Positioned(
              bottom: 0,
              /***************bottom container***************/
              child: Container(
                height: y / 4,
                width: x,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.transparent,
                      Colors.black12,
                      Colors.black26,
                      Colors.black38,
                      Colors.black45,
                      Colors.black54,
                      Colors.black54,
                    ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '  1:23',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text('5.50  ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),

                    /******************Title ROW*******************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: y * 0.025,
                          width: y * 0.025,
                          child: FlareActor(
                            'assets/animated equilizor.flr',
                            fit: BoxFit.contain,
                            color: eqcolor,
                            animation: eqloop,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: x / 1.75,
                          height: y * 0.05,
                          child: Text(
                            'Song title - Artist name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: x / 4.75,
                          height: y * 0.05,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.white,
                              ),
                              Text('Queue',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 6,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    /****************Play Pause ROW****************/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            setState(() {
                             if(repeatflag==0){
                                repeatflag++;
                                repeatIcon = Icon(Icons.repeat_one, color: Colors.redAccent);
                             } else if(repeatflag == 1){
                               repeatflag++;
                               repeatIcon = Icon(Icons.repeat, color: Colors.redAccent,);
                             }else if(repeatflag ==2){
                               repeatflag = 0;
                               repeatIcon = Icon(Icons.repeat, color: Colors.white,);
                             }
                            });
                          },
                            child: repeatIcon,
                        ),
                        Icon(
                          Icons.skip_previous,
                          size: 40,
                          color: Colors.white,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (playanimflag == 0) {
                                playanim = 'play to pause';
                                eqloop = 'startloop';
                                eqcolor = Colors.red;
                                playanimflag = 1;
                              } else if (playanimflag == 1) {
                                if (playanim == 'pause to play') {
                                  playanim = 'play to pause';
                                  eqloop = 'startloop';
                                  eqcolor = Colors.red;
                                } else if (playanim == 'play to pause') {
                                  playanim = 'pause to play';
                                  eqloop = 'stop';
                                  eqcolor = Colors.white;
                                }
                              }
                            });
                          },
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(),
                              height: 50,
                              width: 50,
                              child: FlareActor(
                                'assets/play_pause_actor.flr',
                                color: Colors.yellowAccent,
                                fit: BoxFit.contain,
                                animation: playanim,
                              )),
                        ),
                        Icon(
                          Icons.skip_next,
                          size: 40,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.shuffle,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
