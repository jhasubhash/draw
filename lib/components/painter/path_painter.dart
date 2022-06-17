import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

import '../canvas_data.dart';

class PathPainter extends CustomPainter {
  late List<PathData> pathDataList;
  final BuildContext context;

  PathPainter(this.context, this.pathDataList);

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

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);
    canvas.saveLayer(Rect.largest, Paint());
    for (var pathData in pathDataList) {
      Paint paint = Paint();
      paint.color = pathData.selectedColor;
      paint.strokeWidth = pathData.selectedWidth;
      paint.style = getPaintStyle(pathData.pathType);
      paint.blendMode = getBlendMode(pathData.pathType);
      paint.strokeCap = StrokeCap.round;
      myCanvas.drawPath(
        pathData.path,
        paint,
        onTapDown: (tapdetail) {
          print("orange Circle touched");
        },
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(PathPainter delegate) {
    return true;
  }
}
