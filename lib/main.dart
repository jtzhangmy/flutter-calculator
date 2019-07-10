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
        body: new Center(
          child: new Container(
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Container(
                      child: new Center(
                        child: new Text('a1'),
                      ),
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                        border: new Border.all(
                          color: Color(0xFFFF0000),
                          width: 1
                        )
                      ),
                    ),
                    new Text('a2'),
                    new Text('a3')
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Text('b1'),
                    new Text('b2'),
                    new Text('b3')
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Text('c1'),
                    new Text('c2'),
                    new Text('c3')
                  ],
                )
              ],
            ),
            width: 320,
            height: 320,
            decoration: new BoxDecoration(
              border: new Border.all(
                color: Colors.red,
                width: 1
              )
            )
          ),
        ),
      )
    );
  }
}