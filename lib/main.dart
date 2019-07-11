import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:core';

void main() => runApp(new Calculator());

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalculatorState();
  }
}

class _CalculatorState extends State<Calculator> {
  String _num = '0';
  String _prevNum = '';
  String _prevBtn = '';
  String _prevSymblo = '';

  void _input(arg) {
    print(' ');
    print('num: $_num prevNum: $_prevNum arg: $arg prevBtn: $_prevBtn');
    if (_num == '0' &&
        arg != 'C' &&
        arg != 'AC' &&
        arg != '.' &&
        arg != '+' &&
        arg != '-' &&
        arg != 'x' &&
        arg != '/' &&
        arg != '+/-' &&
        arg != '%') {
      setState(() {
        _num = arg;
      });
    } else if (arg == 'C') {
      setState(() {
        _num = '0';
        _prevBtn = '';
      });
    } else if (arg == 'AC') {
      setState(() {
        _num = '0';
        _prevNum = '';
        _prevBtn = '';
      });
    } else if (arg == '%') {
      setState(() {
        _num = _num == '0' ? '0' : (double.parse(_num) / 100).toString();
      });
    } else if (arg == '+/-') {
      setState(() {
        _num = _num == '0' ? '0' : (double.parse(_num) * -1).toString();
      });
    } else if (arg == '.') {
      if (!_num.contains('.')) {
        setState(() {
          _num += arg;
        });
      }
    } else if (arg == '+' || arg == '-' || arg == 'x' || arg == '/') {
      print('_prevBtn: $_prevBtn _prevSymblo: $_prevSymblo');
      String _nextNum = _equal(_prevNum, _prevSymblo, _num);
      print('equal $_nextNum');
      setState(() {
        _prevBtn = arg;
        _prevNum = _num;
        _num = _nextNum;
        _prevSymblo = arg;
      });
    } else if (arg == '=') {
      String _nextNum = _equal(_prevNum, _prevSymblo, _num);
      setState(() {
        _prevNum = _num;
        _num = _nextNum;
      });
    } else {
      if (_prevBtn != '') {
        setState(() {
          _prevNum = _num;
          _prevBtn = '';
          _num = arg;
        });
      } else {
        setState(() {
          _num += arg;
          _prevBtn = '';
        });
      }
    }
  }

  String _add(String num1, String num2) =>
      num1 == '' ? num2 : (double.parse(num1) + double.parse(num2)).toString();

  String _minus(String num1, String num2) => num1 == ''
      ? (-double.parse(num2)).toString()
      : (double.parse(num1) - double.parse(num2)).toString();

  String _mult(String num1, String num2) =>
      num1 == '' ? num2 : (double.parse(num1) * double.parse(num2)).toString();
  String _division(String num1, String num2) =>
      num1 == '' ? num2 : (double.parse(num1) / double.parse(num2)).toString();

  String _equal(String num1, String symbol, String num2) {
    print('zzzzzzz $symbol');
    switch (symbol) {
      case '+':
        return _add(num1, num2);
        break;
      case '-':
        return _minus(num1, num2);
      case 'x':
        return _mult(num1, num2);
      case '/':
        return _division(num1, num2);
      case '':
        return num2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: '计算器',
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('计算器'),
          ),
          body: new Container(
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new Text(
                    '$_num',
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
                          this._button(_num == '0' ? 'AC' : 'C'),
                          this._button('+/-'),
                          this._button('%'),
                          this._button('/')
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          this._button('7'),
                          this._button('8'),
                          this._button('9'),
                          this._button('x')
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          this._button('4'),
                          this._button('5'),
                          this._button('6'),
                          this._button('-')
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          this._button('1'),
                          this._button('2'),
                          this._button('3'),
                          this._button('+')
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Container(
                            child: new Material(
                                child: new FlatButton(
                                  child: new Row(
                                    children: <Widget>[
                                      new Container(
                                        child: new Center(
                                          child: new Text(
                                            '0',
                                            style: new TextStyle(fontSize: 24),
                                          ),
                                        ),
                                        width: 68,
                                        height: 68,
                                      ),
                                    ],
                                  ),
                                  onPressed: () => _input('0'),
                                ),
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.black12),
                            width: 156,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                          ),
                          this._button('.'),
                          this._button('=')
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

  Widget _button(arg) {
    return new Container(
      child: new Material(
        child: new FlatButton(
          child: new Center(
            child: new Text(
              arg,
              style: new TextStyle(fontSize: 24),
            ),
          ),
          onPressed: () => _input(arg),
        ),
        borderRadius: new BorderRadius.all(const Radius.circular(40)),
        color: _prevBtn == arg ? Colors.redAccent : Colors.black12,
      ),
      width: 68,
      height: 68,
      margin: new EdgeInsets.all(10),
    );
  }
}
