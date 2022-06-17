import 'package:flutter/material.dart';

enum PathType { normal, lassoFill, lassoClear, erase }

class Layer {
  late int layerId;
  late CustomPainter painter;
  List<PathData> pathDataList = [];
  Layer(this.layerId);
}

class PathData {
  Path path = Path();
  Color selectedColor = Colors.black;
  double selectedWidth = 1.0;
  PathType pathType = PathType.normal;
  PathData(this.path, this.selectedColor, this.selectedWidth, this.pathType);
}

class PathInfo {
  final Color color;
  final List<PathData> pathDataList;
  PathInfo({Key? key, required this.color, required this.pathDataList});
}
