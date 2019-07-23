import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({
    @required this.arg,
    @required this.textColor,
    @required this.bacColor,
    @required this.onPress,
    @required this.width,
    @required this.height,
    @required this.direction,
  });
  final String arg;
  final Color textColor;
  final Color bacColor;
  final onPress;
  final double width;
  final double height;
  final String direction;

  @override
  State<StatefulWidget> createState() => ButtonState();
}

class ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: Container(
        child: Center(
          child: Text(widget.arg,
              style: TextStyle(fontSize: 24, color: widget.textColor)),
        ),
        width: widget.width,
        height: widget.height,
        margin: EdgeInsets.all(widget.direction == 'column' ? 10 : 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(const Radius.circular(40)),
            color: widget.bacColor),
      ),
      onTap: () => widget.onPress(widget.arg),
    );
  }
}
