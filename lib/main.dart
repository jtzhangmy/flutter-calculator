import 'dart:math' as math;
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
  bool secondActive = false;
  String _saveData = '';
  bool _isSaved = false;

  void input(arg) {
    final lastIndex = _list.length - 1;
    final listLen = _list.length;
    List<String> storageList = _list;
    String numAfter = '';

    print(' ');
    print('------------------------------------------');
    if (arg == '2nd') {
      setState(() {
        secondActive = !secondActive;
      });
    } else if (arg == 'save') {
      setState(() {
        _saveData = _numShow;
        _isSaved = true;
      });
    } else if (arg == 'load') {
      if (_isSaved == true) {
        if (prevBtn == '') {
          print('无符号');
          storageList[lastIndex] = _saveData;
          setState(() {
            _numShow = _saveData;
            _list = storageList;
            _isSaved = false;
          });
        } else {
          print('有符号');
          storageList.add(_saveData);
          setState(() {
            _numShow = _saveData;
            _list = storageList;
            _isSaved = false;
          });
        }
      }
    } else if (_list[lastIndex] == '0' &&
        ![
          'C',
          'AC',
          '.',
          '+',
          '-',
          'x',
          '/',
          '+/-',
          '=',
          '%',
          'x!',
          '1/x',
          'x^2',
          'e^x',
          '2√x',
          '3√x',
          'y√x',
          'x^y',
          '10^x',
          'ln',
          'lg',
          'sin',
          'cos',
          'tan',
          '2^x',
          '3^x'
          'asin',
          'acos',
          'atan',
          'e',
          'π'
        ].contains(arg)) {
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
    } else if ([
      '%',
      '+/-',
      'x!',
      '1/x',
      'x^2',
      'x^3',
      'e^x',
      '2√x',
      '3√x',
      '10^x',
      'ln',
      'lg',
      'sin',
      'cos',
      'tan',
      '2^x',
      'asin',
      'acos',
      'atan'
    ].contains(arg)) {
      // 点击就计算
      switch (arg) {
        case '%':
          numAfter = _numShow == '0' ? '0' : _equal(_numShow, '/', '100');
          break;
        case '+/-':
          numAfter = _numShow == '0' ? '0' : _equal(_numShow, 'x', '-1');
          break;
        case 'x!':
          numAfter = _factorial(int.parse(_numShow));
          break;
        case '1/x':
          numAfter = _numShow == '0' ? 'Error' : _equal('1', '/', _numShow);
          break;
        case 'x^2':
          numAfter = _numShow == '0' ? '0' : _pow(double.parse(_numShow), 2).toString();
          break;
        case 'x^3':
          numAfter = _numShow == '0' ? '0' : _pow(double.parse(_numShow), 3).toString();
          break;
        case 'e^x':
          numAfter = _pow(math.e, double.parse(_numShow)).toString();
          break;
        case '2√x':
          numAfter = _sqrt2(double.parse(_numShow)).toString();
          break;
        case '3√x':
          numAfter = _sqrt(double.parse(_numShow), 3).toString();
          break;
        case '10^x':
          numAfter = _pow(10, double.parse(_numShow)).toString();
          break;
        case '2^x':
          numAfter = _pow(2, double.parse(_numShow)).toString();
          break;
        case 'ln':
          String result = _ln(double.parse(_numShow)).toString();
          numAfter = result.contains('Infinity') ? 'Error' : result;
          break;
        case 'lg':
          String result = _lg(double.parse(_numShow)).toString();
          numAfter = result.contains('Infinity') ? 'Error' : result;
          break;
        case 'sin':
          numAfter = _sin(double.parse(_numShow)).toString();
          break;
        case 'asin':
          numAfter = _asin(double.parse(_numShow)).toString();
          break;
        case 'cos':
          numAfter = _cos(double.parse(_numShow)).toString();
          break;
        case 'acos':
          numAfter = _acos(double.parse(_numShow)).toString();
          break;
        case 'tan':
          numAfter = _tan(double.parse(_numShow)).toString();
          break;
        case 'atan':
          numAfter = _atan(double.parse(_numShow)).toString();
          break;
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
    } else if (['+', '-', 'x', '/', 'x^y', 'y√x'].contains(arg)) {
      if (prevBtn != '' || storageList[lastIndex] == '=') {
        // 之前按过符号
        storageList[lastIndex] = arg;
        setState(() {
          _list = storageList;
          prevBtn = arg;
        });
      } else {
        if (listLen == 3) {
          // 先算高级运算
          if ((['x', '/', 'x^y', 'y√x'].contains(arg) &&
                  [
                    '+',
                    '-',
                  ].contains(storageList[1])) ||
              (['x^y', 'y√x'].contains(arg) &&
                  ['+', '-', 'x', '/'].contains(storageList[1]))) {
            storageList.add(arg);
            setState(() {
              _list = storageList;
              prevBtn = arg;
            });
          } else {
            numAfter = _equal(storageList[0], storageList[1], storageList[2]);
            storageList = [numAfter, arg];
            setState(() {
              _list = storageList;
              _numShow = numAfter;
              prevBtn = arg;
            });
          }
        } else if (listLen == 5) {
          // 不算
          if (['x^y', 'y√x'].contains(arg) &&
              ['x', '/'].contains(storageList[3])) {
            print('---不算---');
            storageList.add(arg);
            setState(() {
              _list = storageList;
              prevBtn = arg;
            });
          } else if ((['x^y', 'y√x'].contains(arg) &&
                  ['+', '-', 'x', '/'].contains(storageList[1])) ||
              (['x', '/'].contains(arg) &&
                  ['+', '-'].contains(storageList[1]))) {
            print('---算后不算前---');
            numAfter = _equal(storageList[2], storageList[3], storageList[4]);
            storageList = [storageList[0], storageList[1], numAfter, arg];
            setState(() {
              _list = storageList;
              _numShow = numAfter;
              prevBtn = arg;
            });
          } else if ([
                '+',
                '-',
              ].contains(arg) ||
              (['x', '/'].contains(arg) &&
                  ['x', '/'].contains(storageList[1]))) {
            print('---全算---');
            numAfter = _equal(storageList[0], storageList[1],
                _equal(storageList[2], storageList[3], storageList[4]));
            storageList = [numAfter, arg];
            setState(() {
              _list = storageList;
              _numShow = numAfter;
              prevBtn = arg;
            });
          }
        } else if (listLen == 7) {
          if (arg == 'x^y' || arg == 'y√x') {
            print('--- 算最后一位 ---');
            numAfter = _equal(storageList[4], storageList[5], storageList[6]);
            storageList = [
              storageList[0],
              storageList[1],
              storageList[2],
              storageList[3],
              numAfter,
              arg
            ];
          } else if (['x', '/'].contains(arg)) {
            print('---算最后2位---');
            numAfter = _equal(storageList[2], storageList[3],
                _equal(storageList[4], storageList[5], storageList[6]));
            storageList = [storageList[0], storageList[1], numAfter, arg];
          } else {
            print('---全算---');
            numAfter = _equal(
                storageList[0],
                storageList[1],
                _equal(storageList[2], storageList[3],
                    _equal(storageList[4], storageList[5], storageList[6])));
            storageList = [numAfter, arg];
          }
          setState(() {
            _list = storageList;
            _numShow = numAfter;
            prevBtn = arg;
          });
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
        print('---3位---');
        numAfter = _equal(storageList[0], storageList[1], storageList[2]);
        storageList = [numAfter, arg];
      } else if (listLen == 5) {
        print('---5位---');
        numAfter = _equal(storageList[0], storageList[1],
            _equal(storageList[2], storageList[3], storageList[4]));
        storageList = [numAfter, arg];
      } else if (listLen == 7) {
        print('---7位---');
        numAfter = _equal(
            storageList[0],
            storageList[1],
            _equal(storageList[2], storageList[3],
                _equal(storageList[4], storageList[5], storageList[6])));
        storageList = [numAfter, arg];
      }
      setState(() {
        _list = storageList;
        _numShow = numAfter;
        prevBtn = '';
      });
    } else if (['e', 'π'].contains(arg)) {
      if (arg == 'e') {
        numAfter = math.e.toString();
      }
      if (arg == 'π') {
        numAfter = math.pi.toString();
      }
      if (prevBtn == '') {
        storageList[lastIndex] = numAfter;
      } else {
        storageList.add(numAfter);
      }
      setState(() {
        _list = storageList;
        _numShow = numAfter;
        prevBtn = '';
      });
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

  _add(num1, num2) => num1 + num2;

  _minus(num1, num2) => num1 - num2;

  _mult(num1, num2) => num1 * num2;

  _division(num1, num2) => num1 / num2;

  _sin(num) => math.sin(num * (math.pi / 180));

  _asin(num) => math.asin(1) * 180 / math.pi;

  _cos(num) => math.cos(num * (math.pi / 180));

  _acos(num) => math.acos(num) * 180 / math.pi;

  _tan(num) => math.tan(num * (math.pi / 180));

  _atan(num) => math.atan(num) * 180 / math.pi;

  _sqrt2(num) => math.sqrt(num);

  _sqrt(num1, num2) => math.pow(num1, 1 / num2);

  _pow(num1, num2) => math.pow(num1, num2);

  _ln(num) => math.log(num);

  _lg(num) => math.log(num) / math.ln10;

  _factorial(num) {
    if (num is int) {
      int sum = 1;
      for (var i = 1; i <= num; i++) {
        sum *= i;
      }
      return sum < 0 ? 'Error' : sum.toString();
    } else {
      return 'Error';
    }
  }

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
      'x^y': _pow(_num1, _num2),
      'y√x': _sqrt(_num1, _num2),
      '': _num2,
    };
    final num = obj[symbol];
    // 判断是否为无穷
    if (num.isInfinite) return 'Error';
    // 超范围
    var numStr = num.toString();
    final numStrLen = numStr.length;
    if (numStrLen > 11) {
      numStr = num.toStringAsPrecision(8);
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
    } else if (str.contains('Infinity')) {
      return str;
    } else if (str.contains('.')) {
      final indexPoint = str.indexOf('.');
      print(str.substring(0, str.indexOf('.')));
      return _splitStr(str.substring(0, indexPoint)) +
          str.substring(indexPoint, strLen);
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
      } else if (strLen > 9 && strLen < 13) {
        return str.substring(0, strLen - 9) +
            ',' +
            str.substring(strLen - 9, strLen - 6) +
            ',' +
            str.substring(strLen - 6, strLen - 3) +
            ',' +
            str.substring(strLen - 3, strLen);
      } else if (strLen > 12 && strLen < 15) {
        return str.substring(0, strLen - 12) +
            ',' +
            str.substring(strLen - 12, strLen - 9) +
            ',' +
            str.substring(strLen - 9, strLen - 6) +
            ',' +
            str.substring(strLen - 6, strLen - 3) +
            ',' +
            str.substring(strLen - 3, strLen);
      }  else if (strLen > 15 && strLen < 18) {
        return str.substring(0, strLen - 15) +
            ',' +
            str.substring(strLen - 15, strLen - 12) +
            ',' +
            str.substring(strLen - 12, strLen - 9) +
            ',' +
            str.substring(strLen - 9, strLen - 6) +
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
  _transE(str) => str.contains('e') ? double.parse(str).toString() : str;

  _symbolBacColor(arg) => prevBtn == arg ? Colors.orange : Colors.white;

  _symbolTextColor(arg) => prevBtn == arg ? Colors.white : Colors.orange;

  // 0选中状态
  bool isTap0 = false;
  onTapUp0() {
    setState(() {
      isTap0 = false;
    });
  }

  onTapDown0() {
    setState(() {
      isTap0 = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 设置边界大小
    final media = MediaQuery.of(context);
    final mediaPadding = media.padding;
    final size = media.size;
    final double topPadding = mediaPadding.top;
    final double bottomPadding = mediaPadding.bottom;
    final double leftPadding = mediaPadding.left;
    final double rightPadding = mediaPadding.right;
    double width = size.width - leftPadding - rightPadding;
    double height = size.height - topPadding - bottomPadding;
    final direction = height > width ? 'column' : 'row';
    double buttonWidth =
        direction == 'column' ? width / 4 - 20 : width / 8 - 10;
    double buttonHeight =
        direction == 'column' ? buttonWidth : (height - 40 - 50) / 5 - 20;
    double buttonZeroWidth =
        direction == 'column' ? width / 2 - 20 : width / 4 - 10;

    return Scaffold(
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: Text(_splitStr(_numShow),
                    style: TextStyle(fontSize: 48, color: Colors.white),
                    textAlign: TextAlign.right),
                width: width,
                height: 30,
                padding: EdgeInsets.only(
                  top: 40,
                  right: 20,
                  bottom: 20,
                  left: 20,
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                child: Row(
                  children: <Widget>[
                    direction == 'row'
                        ? Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Button(
                                    arg: 'x!',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                  Button(
                                    arg: '1/x',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                  Button(
                                    arg: 'e^x',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                  Button(
                                    arg: secondActive ? '2^x' : '10^x',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Button(
                                    arg: '2nd',
                                    textColor: Colors.white,
                                    bacColor: secondActive
                                        ? Colors.white70
                                        : Colors.white12,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                  Button(
                                    arg: 'x^2',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                  Button(
                                    arg: 'x^3',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                  Button(
                                    arg: 'x^y',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Button(
                                    arg: 'save',
                                    textColor: Colors.white,
                                    bacColor: _isSaved
                                        ? Colors.white24
                                        : Colors.white12,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                  Button(
                                    arg: '2√x',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                  Button(
                                    arg: '3√x',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                  Button(
                                    arg: 'y√x',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Button(
                                    arg: 'load',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                  Button(
                                    arg: 'ln',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                  Button(
                                    arg: 'lg',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                  Button(
                                    arg: 'e',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Button(
                                    arg: secondActive ? 'asin' : 'sin',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                  Button(
                                    arg: secondActive ? 'acos' : 'cos',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                  Button(
                                    arg: secondActive ? 'atan' : 'tan',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                  Button(
                                    arg: 'π',
                                    textColor: Colors.white,
                                    bacColor: Colors.white12,
                                    tapColor: Colors.white24,
                                    onPress: input,
                                    width: buttonWidth,
                                    height: buttonHeight,
                                    direction: direction,
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Text(''),
                    Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            Button(
                              arg: _numShow == '0' ? 'AC' : 'C',
                              textColor: Colors.white,
                              bacColor: Colors.white54,
                              tapColor: Colors.white70,
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
                            Button(
                              arg: '+/-',
                              textColor: Colors.white,
                              bacColor: Colors.white54,
                              tapColor: Colors.white70,
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
                            Button(
                              arg: '%',
                              textColor: Colors.white,
                              bacColor: Colors.white54,
                              tapColor: Colors.white70,
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
                            Button(
                              arg: '/',
                              textColor: _symbolBacColor('/'),
                              bacColor: _symbolTextColor('/'),
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            Button(
                              arg: '7',
                              textColor: Colors.white,
                              bacColor: Colors.white24,
                              tapColor: Colors.white30,
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
                            Button(
                              arg: '8',
                              textColor: Colors.white,
                              bacColor: Colors.white24,
                              tapColor: Colors.white30,
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
                            Button(
                              arg: '9',
                              textColor: Colors.white,
                              bacColor: Colors.white24,
                              tapColor: Colors.white30,
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
                            Button(
                              arg: 'x',
                              textColor: _symbolBacColor('x'),
                              bacColor: _symbolTextColor('x'),
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            )
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            Button(
                              arg: '4',
                              textColor: Colors.white,
                              bacColor: Colors.white24,
                              tapColor: Colors.white30,
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
                            Button(
                              arg: '5',
                              textColor: Colors.white,
                              bacColor: Colors.white24,
                              tapColor: Colors.white30,
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
                            Button(
                              arg: '6',
                              textColor: Colors.white,
                              bacColor: Colors.white24,
                              tapColor: Colors.white30,
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
                            Button(
                              arg: '-',
                              textColor: _symbolBacColor('-'),
                              bacColor: _symbolTextColor('-'),
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            )
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            Button(
                              arg: '1',
                              textColor: Colors.white,
                              bacColor: Colors.white24,
                              tapColor: Colors.white30,
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
                            Button(
                              arg: '2',
                              textColor: Colors.white,
                              bacColor: Colors.white24,
                              tapColor: Colors.white30,
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
                            Button(
                              arg: '3',
                              textColor: Colors.white,
                              bacColor: Colors.white24,
                              tapColor: Colors.white30,
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
                            Button(
                              arg: '+',
                              textColor: _symbolBacColor('+'),
                              bacColor: _symbolTextColor('+'),
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
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
                                width: buttonZeroWidth,
                                height: buttonHeight,
                                margin: EdgeInsets.all(
                                    direction == 'column' ? 10 : 5),
                                decoration: BoxDecoration(
                                  color:
                                      isTap0 ? Colors.white30 : Colors.white24,
                                  borderRadius: BorderRadius.all(
                                    const Radius.circular(50),
                                  ),
                                ),
                              ),
                              onTap: () => input('0'),
                              onTapUp: (detail) => onTapUp0(),
                              onTapDown: (detail) => onTapDown0(),
                            ),
                            Button(
                              arg: '.',
                              textColor: Colors.white,
                              bacColor: Colors.white24,
                              tapColor: Colors.white30,
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
                            Button(
                              arg: '=',
                              textColor: Colors.white,
                              bacColor: Colors.orange,
                              onPress: input,
                              width: buttonWidth,
                              height: buttonHeight,
                              direction: direction,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                width: width,
                margin: EdgeInsets.only(
                  top: topPadding,
                  right: rightPadding,
                  bottom: bottomPadding,
                  left: leftPadding,
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
