import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            expandedHeight: 100,
            flexibleSpace: Container(
              padding: EdgeInsets.only(top: 75, left: 20),
              child: Text(
                'Search',
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                    fontFamily: 'Salsa',
                    fontWeight: FontWeight.w900),
              ),
            ),
            backgroundColor: Colors.white,
            titleSpacing: 0.0,
            title: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: width / 65,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black87,
                     size: 30, ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SliverTS(
            child: Container(
              height: height / 8.5,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Colors.black45,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Search for songs, artists,..',
                          style: TextStyle(fontSize: 20, color: Colors.black45),
                        ),
                      ),
                    ],
                  ),
                ),
                // padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.black26, width: 1.0),
                  //color: Colors.pinkAccent
                ),
                margin: EdgeInsets.only(top: 25, left: 20, right: 20),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return (Container(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(fontSize: 30),
                  ),
                ));
              },
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class SliverTS extends SingleChildRenderObjectWidget {
  SliverTS({Widget child, Key key}) : super(child: child, key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSliverTS();
  }
}

class RenderSliverTS extends RenderSliverSingleBoxAdapter {
  RenderSliverTS({
    RenderBox child,
  }) : super(child: child);

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    child.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child.size.width;
        break;
      case Axis.vertical:
        if (constraints.scrollOffset > 0.0) {
          childExtent = child.size.height + 10;
        } else {
          childExtent = child.size.height;
        }

        break;
    }
//    assert(childExtent != null);
//    final double paintedChildSize =
//        calculatePaintOffset(constraints, from: 0.0, to: childExtent);
//    final double cacheExtent =
//        calculateCacheOffset(constraints, from: 0.0, to: childExtent);
//
//    assert(paintedChildSize.isFinite);
//    assert(paintedChildSize >= 0.0);
    print(constraints.scrollOffset);
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent:
          constraints.scrollOffset > 0.0 ? childExtent : childExtent - 20,
      paintOrigin: constraints.scrollOffset > 0.0
          ? constraints.scrollOffset + 5
          : constraints.scrollOffset - 25,
      // cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      //hitTestExtent: paintedChildSize,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
    setChildParentData(child, constraints, geometry);
  }
}
