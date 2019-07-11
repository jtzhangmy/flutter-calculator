import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'welcome to flutter app',
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('welcome to flutter'),
          ),
          body: new Container(
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new Text(
                    '12345',
                    style: new TextStyle(
//                      color: Colors.white,
                        fontSize: 24),
                  ),
                  width: 375,
                  height: 150,
                  padding: new EdgeInsets.all(20),
                  decoration: new BoxDecoration(
                      border: new Border.all(color: Colors.blue, width: 1)),
                ),
                new Container(
                  child: new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Container(
                            child: new Center(
                              child: new Text(
                                'C',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                          new Container(
                            child: new Center(
                              child: new Text(
                                '+/-',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                          new Container(
                            child: new Center(
                              child: new Text(
                                '%',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                          new Container(
                            child: new Center(
                              child: new Text(
                                '/',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Container(
                            child: new Center(
                              child: new Text(
                                '7',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                          new Container(
                            child: new Center(
                              child: new Text(
                                '8',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                          new Container(
                            child: new Center(
                              child: new Text(
                                '9',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                          new Container(
                            child: new Center(
                              child: new Text(
                                'x',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Container(
                            child: new Center(
                              child: new Text(
                                '4',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                          new Container(
                            child: new Center(
                              child: new Text(
                                '5',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                          new Container(
                            child: new Center(
                              child: new Text(
                                '6',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                          new Container(
                            child: new Center(
                              child: new Text(
                                '-',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Container(
                            child: new Center(
                              child: new Text(
                                '1',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                          new Container(
                            child: new Center(
                              child: new Text(
                                '2',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                          new Container(
                            child: new Center(
                              child: new Text(
                                '3',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                          new Container(
                            child: new Center(
                              child: new Text(
                                '+',
                                style: new TextStyle(fontSize: 24),
                              ),
                            ),
                            width: 68,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                            decoration: new BoxDecoration(
                                /*border: new Border.all(
                              color: Color(0xFFFF0000), width: 1),*/
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  margin: new EdgeInsets.all(10),
                ),
              ],
            ),
            width: 375,
            height: 812,
          ),
        ));
  }
}
