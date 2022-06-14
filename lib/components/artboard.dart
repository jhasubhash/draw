import 'package:flutter/material.dart';

class Artboard extends StatefulWidget {
  const Artboard(
      {Key? key, required this.canvasHeight, required this.canvasWidth})
      : super(key: key);
  final double canvasWidth;
  final double canvasHeight;

  @override
  State<Artboard> createState() => _ArtboardState();
}

class _ArtboardState extends State<Artboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.canvasHeight,
      width: widget.canvasWidth,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
