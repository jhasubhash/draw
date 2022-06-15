import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

import 'canvas_data.dart';

class PathPainter extends CustomPainter {
  late List<PathData> pathDataList;
  final BuildContext context;

  PathPainter(this.context, this.pathDataList);

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);
    for (var pathData in pathDataList) {
      Paint paint = Paint();
      paint.color = pathData.selectedColor;
      paint.strokeWidth = pathData.selectedWidth;
      paint.style = pathData.pathType == PathType.normal
          ? PaintingStyle.stroke
          : PaintingStyle.fill;
      myCanvas.drawPath(
        pathData.path,
        paint,
        onTapDown: (tapdetail) {
          print("orange Circle touched");
          print(tapdetail.localPosition);
          print(pathData.pathType);
        },
      );
    }
  }

  @override
  bool shouldRepaint(PathPainter delegate) {
    return true;
  }
}
