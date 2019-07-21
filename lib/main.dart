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
    } else if (_numShow == 'Error') {
      if (['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].indexOf(arg) >
          -1) {
        setState(() {
          _list = [arg];
          _numShow = arg;
        });
      }
    } else if (arg == '%') {
      numAfter =
          _numShow == '0' ? '0' : _equal(_numShow, '/', '100').toString();
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
  _add(num1, num2) => num1 + num2;

  // 减
  _minus(num1, num2) => num1 - num2;

  // 乘
  _mult(num1, num2) => num1 * num2;

  // 除
  _division(num1, num2) => num1 / num2;

  // 字符串转数字
  _str2num(num) => num.contains('.') || num.contains('e')
      ? double.parse(num)
      : int.parse(num);

  // 求等
  String _equal(String num1, String symbol, String num2) {
    final _num1 = _str2num(_transE(num1));
    final _num2 = _str2num(_transE(num2));
    print('${_num1}---${symbol}---${_num2}');
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
      return 'Error';
    }

    // 判断无限循环小数
    if (!num.isFinite) {
      return num.toStringAsFixed(9).toString();
    }

    // 超范围
    var numStr = num.toString();
    final numStrLen = numStr.length;
    if (numStrLen > 11) {
      numStr = num.toStringAsPrecision(6);
      RegExp regPointZero = new RegExp(r"(\.0*?(?=e))");
      RegExp regPointNum = new RegExp(r"((?<=\..*)0*?(?=e))");
      return regPointZero.hasMatch(numStr) == true
          ? numStr.replaceAll(regPointZero, '')
          : numStr.replaceAll(regPointNum, '');
    } else {
      return numStr;
    }
  }

  // 分隔符
  _splitStr(str) {
    if (str.contains('.') || str.contains('e') || str.contains('Error')) {
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
    if (str.contains('e')) {
      return double.parse(str).toString();
    } else {
      return str;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: '计算器',
        theme: new ThemeData.dark(),
        home: new Scaffold(
          body: new Container(
            child: new Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new Container(
                      child: new Text(
                        _splitStr(_numShow),
                        style: new TextStyle(fontSize: 48, color: Colors.white),
                      ),
                      width: 375,
                      height: 130,
                      padding: new EdgeInsets.only(
                        top: 40,
                        right: 20,
                        bottom: 20,
                        left: 20,
                      )),
                ),
                Expanded(
                  flex: 0,
                  child: new Container(
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
                            new GestureDetector(
                              child: new Container(
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
                                      width: 68,
                                      height: 68,
                                    )
                                  ],
                                ),
                                width: 156,
                                height: 68,
                                margin: new EdgeInsets.all(10),
                                decoration: new BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: new BorderRadius.all(
                                    const Radius.circular(34.0),
                                  ),
                                ),
                              ),
                              onTap: () => _input('0'),
                            ),
                            this._button('.', false, false),
                            this._button('=', true, false)
                          ],
                        ),
                      ],
                    ),
                    margin: new EdgeInsets.all(10),
                  ),
                )
              ],
            ),
            width: 375,
            height: 667,
            color: Colors.black,
          ),
        ));
  }

  Widget _button(arg, symbol, gray) {
    return new GestureDetector(
      child: Container(
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
        width: 68,
        height: 68,
        margin: new EdgeInsets.all(10),
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(const Radius.circular(40)),
            color: !gray
                ? symbol
                    ? _prevBtn == arg ? Colors.white : Colors.orange
                    : Colors.white24
                : Colors.white54),
      ),
      onTap: () => _input(arg),
    );
  }
}
