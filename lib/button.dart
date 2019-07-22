import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button(
      {@required this.arg,
      @required this.textColor,
      @required this.bacColor,
      @required this.onPress});
  final String arg;
  final textColor;
  final bacColor;
  final onPress;

  @override
  State<StatefulWidget> createState() => ButtonState();
}

class ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: Container(
        child: new Center(
          child: new Text(
            widget.arg,
            style: new TextStyle(
                fontSize: 24,
                color: widget.textColor),
          ),
        ),
        width: 68,
        height: 68,
        margin: new EdgeInsets.all(10),
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(const Radius.circular(40)),
            color: widget.bacColor),
      ),
      onTap: () => widget.onPress(widget.arg),
    );
  }
}
