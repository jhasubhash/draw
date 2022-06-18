import 'dart:typed_data';

import 'package:draw/components/layer_manager.dart';
import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

import '../canvas_data.dart';

Offset initialOffset = const Offset(0, 0);

class PathPainter extends CustomPainter {
  late List<Layer> layers;
  late BuildContext context;

  // static final PathPainter _instance = PathPainter._internal();

  // factory PathPainter(context, pathDataList) {
  //   _instance.context = context;
  //   _instance.pathDataList = pathDataList;
  //   return _instance;
  // }

  // PathPainter._internal() {
  //   // initialization logic
  // }

  PathPainter(this.context, this.layers);

  PaintingStyle getPaintStyle(PathType pathType) {
    switch (pathType) {
      case PathType.normal:
        return PaintingStyle.stroke;
      case PathType.erase:
        return PaintingStyle.stroke;
      default:
        return PaintingStyle.fill;
    }
  }

  BlendMode getBlendMode(PathType pathType) {
    switch (pathType) {
      case PathType.lassoClear:
        return BlendMode.clear;
      case PathType.erase:
        return BlendMode.clear;
      default:
        return BlendMode.srcOver;
    }
  }

  void onPanStart(DragStartDetails detail, int layerIdx, int pathIdx) {
    initialOffset = detail.globalPosition;
  }

  void onPanUpdate(DragUpdateDetails detail, int layerIdx, int pathIdx) {
    var newLayers = List<Layer>.from(layers);
    PathData pathData = newLayers[layerIdx].pathDataList[pathIdx];
    Offset diff = detail.globalPosition - initialOffset;
    initialOffset = detail.globalPosition;
    //Manipulate pathdata
    List<double> ll = [
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      diff.dx,
      diff.dy,
      0,
      1
    ];
    Float64List mat = Float64List.fromList(ll);
    pathData.path.transform(mat);
    newLayers[layerIdx].pathDataList[pathIdx] = pathData;
    LayerManager(context).setLayers(newLayers);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);
    canvas.saveLayer(Rect.largest, Paint());
    for (int layerIdx = layers.length - 1; layerIdx >= 0; layerIdx--) {
      for (int pathIdx = 0;
          pathIdx < layers[layerIdx].pathDataList.length;
          pathIdx++) {
        var pathData = layers[layerIdx].pathDataList[pathIdx];
        Paint paint = Paint();
        paint.color = pathData.selectedColor;
        paint.strokeWidth = pathData.selectedWidth;
        paint.style = getPaintStyle(pathData.pathType);
        paint.blendMode = getBlendMode(pathData.pathType);
        paint.strokeCap = StrokeCap.round;
        myCanvas.drawPath(
          pathData.path.path,
          paint,
          onTapDown: (tapdetail) {},
          onPanStart: (detail) => onPanStart(detail, layerIdx, pathIdx),
          onPanUpdate: (detail) => onPanUpdate(detail, layerIdx, pathIdx),
        );
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(PathPainter delegate) {
    return true;
  }
}
