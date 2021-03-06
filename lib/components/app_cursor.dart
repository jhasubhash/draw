import 'package:flutter/material.dart';

class AppCursor extends StatefulWidget {
  final double size;
  AppCursor({Key? key, required this.size}) : super(key: key);

  @override
  State<AppCursor> createState() => _AppCursorState();
}

class _AppCursorState extends State<AppCursor> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
          child: CircleAvatar(
        radius: widget.size / 2,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: Icon(
          Icons.circle,
          size: widget.size,
          color: Colors.white,
        ),
      )),
    );
  }
}
