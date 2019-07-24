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
    @required this.tapColor,
  });
  final String arg;
  final Color textColor;
  final Color bacColor;
  final onPress;
  final double width;
  final double height;
  final String direction;
  final Color tapColor;

  @override
  State<StatefulWidget> createState() => ButtonState();
}

class ButtonState extends State<Button> {
  bool tap = false;
  onTapDown() {
    setState(() {
      tap = true;
    });
  }

  onTapUp() {
    setState(() {
      tap = false;
    });
  }

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
            color: widget.tapColor == null
                ? widget.bacColor
                : tap ? widget.tapColor : widget.bacColor),
      ),
      onTap: () => widget.onPress(widget.arg),
      onTapDown: (detail) => onTapDown(),
      onTapUp: (detail) => onTapUp(),
    );
  }
}
