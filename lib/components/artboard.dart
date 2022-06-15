import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:touchable/touchable.dart';

import '../models/app_state.dart';
import 'canvas_data.dart';
import 'path_painter.dart';

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
    return StoreConnector<AppState, List<PathData>>(
        converter: (store) => store.state.pathDataList,
        builder: (BuildContext context, List<PathData> pathDataList) {
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
            child: RepaintBoundary(
              child: Container(
                  width: widget.canvasWidth,
                  height: widget.canvasHeight,
                  // CustomPaint widget will go here
                  child: CanvasTouchDetector(
                      gesturesToOverride: const [GestureType.onTapDown],
                      builder: (context) => CustomPaint(
                          painter: PathPainter(context, pathDataList)))),
            ),
          );
        });
  }
}
