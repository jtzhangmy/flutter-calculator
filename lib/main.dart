import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:core';
import 'button.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: '计算器', theme: new ThemeData.dark(), home: Calculator());
  }
}

class Calculator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalculatorState();
  }
}

class _CalculatorState extends State<Calculator> {
  var _list = <String>['0'];
  String _numShow = '0';
  String prevBtn = '';

  void input(arg) {
    final lastIndex = _list.length - 1;
    final listLen = _list.length;
    List<String> storageList = _list;
    String numAfter = '';

    print(' ');
    print('------------------------------------------');
    if (_list[lastIndex] == '0' &&
        !['C', 'AC', '.', '+', '-', 'x', '/', '+/-', '=', '%'].contains(arg)) {
      numAfter = arg;
      storageList[lastIndex] = numAfter;
      setState(() {
        _list = storageList;
        _numShow = numAfter;
      });
    } else if (arg == 'C') {
      final lastArg = storageList[lastIndex];
      if (['+', '-', 'x', '/', '='].contains(lastArg)) {
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
        prevBtn = '';
      });
    } else if (_numShow == 'Error') {
      if (['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].contains(arg)) {
        setState(() {
          _list = [arg];
          _numShow = arg;
        });
      }
    } else if (arg == '%' || arg == '+/-') {
      // 点击就计算
      if (arg == '%') {
        numAfter = _numShow == '0' ? '0' : _equal(_numShow, '/', '100');
      } else if (arg == '+/-') {
        numAfter = _numShow == '0' ? '0' : _equal(_numShow, 'x', '-1');
      }
      storageList[prevBtn == '' ? lastIndex : lastIndex - 1] = numAfter;
      setState(() {
        _list = storageList;
        _numShow = numAfter;
      });
    } else if (arg == '.') {
      if (!_numShow.contains('.')) {
        if (prevBtn == '') {
          numAfter = _numShow + arg;
          storageList[lastIndex] = numAfter;
        } else {
          numAfter = '0.';
          storageList.add(numAfter);
        }
        setState(() {
          _list = storageList;
          _numShow = numAfter;
          prevBtn = '';
        });
      }
    } else if (['+', '-', 'x', '/'].contains(arg)) {
      if (prevBtn != '' || storageList[lastIndex] == '=') {
        // 之前按过符号
        storageList[lastIndex] = arg;
        setState(() {
          _list = storageList;
          prevBtn = arg;
        });
      } else {
        if (listLen == 3) {
          // 先算乘除后算加减
          if ((arg == 'x' || arg == '/') &&
              (storageList[1] == '+' || storageList[1] == '-')) {
            storageList.add(arg);
            setState(() {
              _list = storageList;
              prevBtn = arg;
            });
          } else {
            numAfter = _equal(storageList[0], storageList[1], storageList[2]);
            storageList.removeRange(0, 2);
            storageList = [numAfter, arg];
            setState(() {
              _list = storageList;
              _numShow = numAfter;
              prevBtn = arg;
            });
          }
        } else if (listLen == 5) {
          if (arg == 'x' || arg == '/') {
            numAfter = _equal(storageList[2], storageList[3], storageList[4]);
            storageList = [storageList[0], storageList[1], numAfter, arg];
            setState(() {
              _list = storageList;
              _numShow = numAfter;
              prevBtn = arg;
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
              prevBtn = arg;
            });
          }
        } else {
          storageList.add(arg);
          setState(() {
            _list = storageList;
            prevBtn = arg;
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
          prevBtn = '';
        });
      } else if (listLen == 5) {
        numAfter = _equal(storageList[0], storageList[1],
            _equal(storageList[2], storageList[3], storageList[4]));
        storageList = [numAfter, arg];
        setState(() {
          _list = storageList;
          _numShow = numAfter;
          prevBtn = '';
        });
      } else {
        setState(() {
          _list = storageList;
          prevBtn = '';
        });
      }
    } else {
      // 普通数字
      // 超位数
      if (storageList[lastIndex].replaceAll('.', '').length >= 9) return;
      // 前一个点击+-x/符号
      if (prevBtn != '') {
        numAfter = arg;
        storageList.add(arg);
        setState(() {
          _list = storageList;
          _numShow = numAfter;
          prevBtn = '';
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
          prevBtn = '';
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
    final obj = {
      '+': _add(_num1, _num2),
      '-': _minus(_num1, _num2),
      'x': _mult(_num1, _num2),
      '/': _division(_num1, _num2),
      '': _num2,
    };
    final num = obj[symbol];
    // 判断是否为无穷
    if (num.isInfinite) return 'Error';

    // 超范围
    var numStr = num.toString();
    final numStrLen = numStr.length;
    if (numStrLen > 11) {
      numStr = num.toStringAsPrecision(6);
      // 末尾为0
      RegExp finalZero = new RegExp(r"0*$");
      // e前.后只有0
      RegExp regPointZero = new RegExp(r"(\.0*?(?=e))");
      // e前.数字后只有0
      RegExp regPointNum = new RegExp(r"((?<=\..*)0*?(?=e))");
      return finalZero.hasMatch(numStr) == true && !numStr.contains('e')
          ? numStr.replaceAll(finalZero, '')
          : regPointZero.hasMatch(numStr) == true
              ? numStr.replaceAll(regPointZero, '')
              : numStr.replaceAll(regPointNum, '');
    } else {
      return numStr;
    }
  }

  // 分隔符
  _splitStr(str) {
    final strLen = str.length;
    if (str.contains('e') || str.contains('Error')) {
      return str;
    } else if (str.contains('.')) {
      final indexPoint = str.indexOf('.');
      print(str.substring(0, str.indexOf('.')));
      return _splitStr(str.substring(0, indexPoint)) + str.substring(indexPoint, strLen);
    } else {
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
    return str.contains('e') ? double.parse(str).toString() : str;
  }

  _symbolBacColor(arg) => prevBtn == arg ? Colors.orange : Colors.white;

  _symbolTextColor(arg) => prevBtn == arg ? Colors.white : Colors.orange;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    print('宽：${width}---高：${height}');
    
    return new Scaffold(
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
                width: width,
                height: 130,
                padding: new EdgeInsets.only(
                  top: 40,
                  right: 20,
                  bottom: 20,
                  left: 20,
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: new Container(
                child: new Center(
                  child: new Container(
                    child: new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            Button(
                                arg: _numShow == '0' ? 'AC' : 'C',
                                textColor: Colors.white,
                                bacColor: Colors.white54,
                                onPress: input),
                            Button(
                                arg: '+/-',
                                textColor: Colors.white,
                                bacColor: Colors.white54,
                                onPress: input),
                            Button(
                                arg: '%',
                                textColor: Colors.white,
                                bacColor: Colors.white54,
                                onPress: input),
                            Button(
                                arg: '/',
                                textColor: _symbolBacColor('/'),
                                bacColor: _symbolTextColor('/'),
                                onPress: input),
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            Button(
                                arg: '7',
                                textColor: Colors.white,
                                bacColor: Colors.white24,
                                onPress: input),
                            Button(
                                arg: '8',
                                textColor: Colors.white,
                                bacColor: Colors.white24,
                                onPress: input),
                            Button(
                                arg: '9',
                                textColor: Colors.white,
                                bacColor: Colors.white24,
                                onPress: input),
                            Button(
                                arg: 'x',
                                textColor: _symbolBacColor('x'),
                                bacColor: _symbolTextColor('x'),
                                onPress: input)
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            Button(
                                arg: '4',
                                textColor: Colors.white,
                                bacColor: Colors.white24,
                                onPress: input),
                            Button(
                                arg: '5',
                                textColor: Colors.white,
                                bacColor: Colors.white24,
                                onPress: input),
                            Button(
                                arg: '6',
                                textColor: Colors.white,
                                bacColor: Colors.white24,
                                onPress: input),
                            Button(
                                arg: '-',
                                textColor: _symbolBacColor('-'),
                                bacColor: _symbolTextColor('-'),
                                onPress: input)
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            Button(
                                arg: '1',
                                textColor: Colors.white,
                                bacColor: Colors.white24,
                                onPress: input),
                            Button(
                                arg: '2',
                                textColor: Colors.white,
                                bacColor: Colors.white24,
                                onPress: input),
                            Button(
                                arg: '3',
                                textColor: Colors.white,
                                bacColor: Colors.white24,
                                onPress: input),
                            Button(
                                arg: '+',
                                textColor: _symbolBacColor('+'),
                                bacColor: _symbolTextColor('+'),
                                onPress: input),
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
                              onTap: () => input('0'),
                            ),
                            Button(
                                arg: '.',
                                textColor: Colors.white,
                                bacColor: Colors.white24,
                                onPress: input),
                            Button(
                                arg: '=',
                                textColor: Colors.white,
                                bacColor: Colors.orange,
                                onPress: input),
                          ],
                        ),
                      ],
                    ),
                    width: 352,
                    height: 440,
                  ),
                ),
                width: width,
                margin: new EdgeInsets.only(
                  top: 10,
                  right: 10,
                  bottom: 20,
                  left: 10,
                ),
              ),
            )
          ],
        ),
        color: Colors.black,
      ),
    );
  }
}
