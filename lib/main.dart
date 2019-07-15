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
  var _list = <String>['0'];
  String _numShow = '0';
  String _prevBtn = '';

  void _input(arg) {
    final lastIndex = _list.length - 1;
    final listLen = _list.length;
    var storageList = _list;
    String numAfter = '';

    print(' ');
    print('------------------------------------------');
    if (_list[lastIndex] == '0' &&
        arg != 'C' &&
        arg != 'AC' &&
        arg != '.' &&
        arg != '+' &&
        arg != '-' &&
        arg != 'x' &&
        arg != '/' &&
        arg != '+/-' &&
        arg != '=' &&
        arg != '%') {
      numAfter = arg;
      storageList[lastIndex] = numAfter;
      setState(() {
        _list = storageList;
        _numShow = numAfter;
      });
    } else if (arg == 'C') {
      final lastArg = storageList[lastIndex];
      if (lastArg == '+' || lastArg == '-' || lastArg == 'x' || lastArg == '/' || lastArg == '=') {
        storageList[lastIndex - 1] = '0';
        setState(() {
          _list = storageList;
          _numShow = '0';
        });
      } else {
        setState(() {
          storageList[lastIndex] = '0';
          _list = storageList;
          _numShow = '0';
        });
      }
    } else if (arg == 'AC') {
      setState(() {
        _list = ['0'];
        _numShow = '0';
        _prevBtn = '';
      });
    } else if (arg == '%') {
      numAfter =
          _numShow == '0' ? '0' : (double.parse(_numShow) / 100).toString();
      if (_prevBtn != '') {
        storageList[lastIndex - 1] = numAfter;
        storageList.removeLast();
      } else {
        storageList[lastIndex] = numAfter;
      }
      setState(() {
        _list = storageList;
        _numShow = numAfter;
        _prevBtn = '';
      });
    } else if (arg == '+/-') {
      numAfter =
          _numShow == '0' ? '0' : (double.parse(_numShow) * -1).toString();
      storageList[lastIndex] = numAfter;
      setState(() {
        _list = storageList;
        _numShow = numAfter;
        _prevBtn = '';
      });
    } else if (arg == '.') {
      if (!_numShow.contains('.')) {
        storageList[lastIndex] = _numShow + '.';
        setState(() {
          _list = storageList;
          _numShow += arg;
        });
      }
    } else if (arg == '+' || arg == '-' || arg == 'x' || arg == '/') {
      if (_prevBtn != '' || storageList[lastIndex] == '=') {
        // 之前按过符号 除了等号
        storageList[lastIndex] = arg;
        setState(() {
          _list = storageList;
          _prevBtn = arg;
        });
      } else {
        if (listLen == 3) {
          // 先算乘除后算加减
          if ((arg == 'x' || arg == '/') &&
              (storageList[1] == '+' || storageList[1] == '-')) {
            storageList.add(arg);
            setState(() {
              _list = storageList;
              _prevBtn = arg;
            });
          } else {
            numAfter = _equal(storageList[0], storageList[1], storageList[2]);
            storageList.removeRange(0, 2);
            storageList = [numAfter, arg];
            setState(() {
              _list = storageList;
              _numShow = numAfter;
              _prevBtn = arg;
            });
          }
        } else if (listLen == 5) {
          if (arg == 'x' || arg == '/') {
            numAfter = _equal(storageList[2], storageList[3], storageList[4]);
            storageList = [storageList[0], storageList[1], numAfter, arg];
            setState(() {
              _list = storageList;
              _numShow = numAfter;
              _prevBtn = arg;
            });
          } else {
            numAfter = _equal(storageList[0], storageList[1],
                _equal(storageList[2], storageList[3], storageList[4]));
            storageList.removeRange(0, 4);
            storageList[0] = numAfter;
            storageList = [numAfter, arg];
            setState(() {
              _list = storageList;
              _numShow = numAfter;
              _prevBtn = arg;
            });
          }
        } else {
          storageList.add(arg);
          setState(() {
            _list = storageList;
            _prevBtn = arg;
          });
        }
      }
    } else if (arg == '=') {
      if (listLen == 3) {
        numAfter = _equal(storageList[0], storageList[1], storageList[2]);
        storageList.removeRange(0, 2);
        storageList = [numAfter, arg];
        setState(() {
          _list = storageList;
          _numShow = numAfter;
          _prevBtn = '';
        });
      } else if (listLen == 5) {
        numAfter = _equal(storageList[0], storageList[1],
            _equal(storageList[2], storageList[3], storageList[4]));
        storageList.removeRange(0, 4);
        storageList[0] = numAfter;
        storageList = [numAfter, arg];
        setState(() {
          _list = storageList;
          _numShow = numAfter;
          _prevBtn = '';
        });
      } else {
        setState(() {
          _list = storageList;
          _prevBtn = '';
        });
      }
    } else {
      if (_prevBtn != '') {
        storageList.add(arg);
        numAfter = arg;
        setState(() {
          _list = storageList;
          _numShow = numAfter;
          _prevBtn = '';
        });
      } else {
        print(storageList[lastIndex]);
        if (storageList[lastIndex] == '=') {
          numAfter = arg;
          storageList = [arg];
        } else {
          numAfter = _numShow + arg;
          storageList[lastIndex] = numAfter;
        }
        setState(() {
          _numShow = numAfter;
          _list = storageList;
          _prevBtn = '';
        });
      }
    }
    print(_list);
  }

  // 加
  String _add(String num1, String num2) =>
      num1 == '' ? num2 : (_str2num(num1) + _str2num(num2)).toString();

  // 减
  String _minus(String num1, String num2) => num1 == ''
      ? (-_str2num(num2)).toString()
      : (_str2num(num1) - _str2num(num2)).toString();

  // 乘
  String _mult(String num1, String num2) =>
      num1 == '' ? num2 : (_str2num(num1) * _str2num(num2)).toString();

  // 除
  String _division(String num1, String num2) =>
      num1 == '' ? num2 : (_str2num(num1) / _str2num(num2)).toString();

  // 字符串转数字
  _str2num(String num) =>
      num.contains('.') ? double.parse(num) : int.parse(num);

  // 求等
  String _equal(String num1, String symbol, String num2) {
    print('---- 符号 $symbol -----');
    switch (symbol) {
      case '+':
        return _add(num1, num2);
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
                    '$_numShow',
                    style: new TextStyle(
//                      color: Colors.white,
                        fontSize: 28,
                        color: Colors.white),
                  ),
                  width: 375,
                  height: 150,
                  padding: new EdgeInsets.all(20),
                ),
                new Container(
                  child: new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          this._button(
                              _numShow == '0' ? 'AC' : 'C', false, true),
                          this._button('+/-', false, true),
                          this._button('%', false, true),
                          this._button('/', true, false)
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          this._button('7', false, false),
                          this._button('8', false, false),
                          this._button('9', false, false),
                          this._button('x', true, false)
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          this._button('4', false, false),
                          this._button('5', false, false),
                          this._button('6', false, false),
                          this._button('-', true, false)
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          this._button('1', false, false),
                          this._button('2', false, false),
                          this._button('3', false, false),
                          this._button('+', true, false)
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
                                            style: new TextStyle(
                                                fontSize: 24,
                                                color: Colors.white),
                                          ),
                                        ),
                                        width: 38,
                                        height: 68,
                                      ),
                                    ],
                                  ),
                                  onPressed: () => _input('0'),
                                ),
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40)),
                                color: Colors.white24),
                            width: 156,
                            height: 68,
                            margin: new EdgeInsets.all(10),
                          ),
                          this._button('.', false, false),
                          this._button('=', true, false)
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
            color: Colors.black,
          ),
        ));
  }

  Widget _button(arg, symbol, gray) {
    return new Container(
      child: new Material(
          child: new FlatButton(
            child: new Center(
              child: new Text(
                arg,
                style: new TextStyle(
                    fontSize: 24,
                    color: symbol
                        ? _prevBtn == arg ? Colors.orange : Colors.white
                        : Colors.white),
              ),
            ),
            onPressed: () => _input(arg),
          ),
          borderRadius: new BorderRadius.all(const Radius.circular(40)),
          color: !gray
              ? symbol
                  ? _prevBtn == arg ? Colors.white : Colors.orange
                  : Colors.white24
              : Colors.white54),
      width: 68,
      height: 68,
      margin: new EdgeInsets.all(10),
    );
  }
}
