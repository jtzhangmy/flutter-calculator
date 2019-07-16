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
      if (lastArg == '+' ||
          lastArg == '-' ||
          lastArg == 'x' ||
          lastArg == '/' ||
          lastArg == '=') {
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
      print('9999---${_numShow}----${_equal(_numShow, '/', '100').toString()}');
      numAfter = _numShow == '0' ? '0' : _equal(_numShow, '/', '100').toString();
      if (_prevBtn != '') {
        storageList[lastIndex - 1] = numAfter;
      } else {
        storageList[lastIndex] = numAfter;
      }
      setState(() {
        _list = storageList;
        _numShow = numAfter;
      });
    } else if (arg == '+/-') {
      numAfter = _numShow == '0' ? '0' : (_str2num(_numShow) * -1).toString();
      if (_prevBtn == '') {
        storageList[lastIndex] = numAfter;
      } else {
        storageList[lastIndex - 1] = numAfter;
      }
      setState(() {
        _list = storageList;
        _numShow = numAfter;
      });
    } else if (arg == '.') {
      if (!_numShow.contains('.')) {
        if (_prevBtn == '') {
          numAfter = _numShow + arg;
          storageList[lastIndex] = numAfter;
        } else {
          numAfter = '0.';
          storageList.add(numAfter);
        }
        setState(() {
          _list = storageList;
          _numShow = numAfter;
          _prevBtn = '';
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
      // 等于号
      if (listLen == 3) {
        numAfter = _equal(storageList[0], storageList[1], storageList[2]);
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
      // 普通数字
      // 超位数
      if (storageList[lastIndex].length >= 9) return;
      // 前一个点击+-x/符号
      if (_prevBtn != '') {
        storageList.add(arg);
        numAfter = arg;
        setState(() {
          _list = storageList;
          _numShow = numAfter;
          _prevBtn = '';
        });
      } else {
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
  _add(num1, num2) => num1 == '' ? num2 : num1 + num2;

  // 减
  _minus(num1, num2) => num1 == '' ? -num2 : num1 - num2;

  // 乘
  _mult(num1, num2) => num1 == '' ? num2 : num1 * num2;

  // 除
  _division(num1, num2) => num1 == '' ? num2 : num1 / num2;

  // 字符串转数字
  _str2num(num) => num.contains('.') ? double.parse(num) : int.parse(num);

  // 求等
  String _equal(String num1, String symbol, String num2) {
    print('---- 符号 $symbol -----');
    final _num1 = _str2num(_transE(num1));
    final _num2 = _str2num(_transE(num2));
    print('${_num1}----${_num2}');
    var obj = {
      '+': _add(_num1, _num2),
      '-': _minus(_num1, _num2),
      'x': _mult(_num1, _num2),
      '/': _division(_num1, _num2),
      '': _num2,
    };
    var num = obj[symbol];
    // 判断是否为无穷
    if (num.isInfinite) {
      return '输入错误';
    }

    // 判断无限循环小数
    if (!num.isFinite) {
      return num.toStringAsFixed(9).toString();
    }

    // 超范围
    var numStr = num.toString();
    final numStrLen = numStr.length;
    if (numStrLen > 11) {
      if (numStr.contains('.')) {
        return _str2num(numStr.substring(0, 11)).toString();
      } else {
        final sub3 = (_str2num(numStr.substring(0, 3)) / 100).toString();
        return sub3 + 'e+${numStrLen - 1}';
      }
    } else {
      return numStr;
    }
  }

  // 分隔符
  _splitStr(str) {
    if (str.contains('.') || str.contains('e')) {
      return str;
    } else {
      final strLen = str.length;
      if (strLen > 3 && strLen < 7) {
        return str.substring(0, strLen - 3) +
            ',' +
            str.substring(strLen - 3, strLen);
      } else if (strLen > 6 && strLen < 10) {
        return str.substring(0, strLen - 6) +
            ',' +
            str.substring(strLen - 6, strLen - 3) +
            ',' +
            str.substring(strLen - 3, strLen);
      } else {
        return str;
      }
    }
  }

  // 转换e
  _transE(str) {
    if (str.contains('e+')) {
      var arr = str.split('e+');
      var returnNum = _str2num(arr[0]) * pow(10, _str2num(arr[1]));
      return returnNum.toString();
    } else if(str.contains('e-')) {
      print(7777777);
      var arr = str.split('e-');
      print('${arr[0]}+++${pow(0.1, _str2num(arr[1])).toString()}');
      var returnNum = _str2num(arr[0]) * pow(0.1, _str2num(arr[1]));
      print('-------${returnNum}');
      return returnNum.toString();
    } else {
      return str;
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
                    _splitStr(_numShow),
                    style: new TextStyle(
//                      color: Colors.white,
                        fontSize: 48,
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
