import 'package:draw/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:touchable/touchable.dart';

import '../models/app_state.dart';
import 'canvas_data.dart';
import 'painter/path_painter.dart';

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
  getGesturesToOverride() {
    var overrideList = [GestureType.onTapDown];
    if (IsSelectToolActive(context)) {
      overrideList.add(GestureType.onPanStart);
      overrideList.add(GestureType.onPanUpdate);
      overrideList.add(GestureType.onPanDown);
    }
    return overrideList;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Layer>>(
        converter: (store) => store.state.layers,
        builder: (BuildContext context, List<Layer> layers) {
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
                      gesturesToOverride: getGesturesToOverride(),
                      builder: (context) =>
                          CustomPaint(painter: PathPainter(context, layers)))),
            ),
          );
        });
  }
}
