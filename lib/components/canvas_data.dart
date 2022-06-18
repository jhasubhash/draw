import 'dart:convert';

import 'package:draw/components/custom/path.dart';
import 'package:flutter/material.dart';

enum PathType { normal, lassoFill, lassoClear, erase }

class Layer {
  late int layerId;
  late CustomPainter painter;
  List<PathData> pathDataList = [];
  Layer(this.layerId);

  Layer.fromJson(Map<String, dynamic> json) {
    layerId = json['layerId'];
    var data = jsonDecode(json['pathDataList']);
    for (var pathData in data) {
      pathDataList.add(PathData.fromJson(pathData));
    }
  }

  Map<String, dynamic> toJson() => {
        'layerId': layerId,
        'pathDataList': jsonEncode(pathDataList),
      };
}

int colorStringToInt(String colorString) {
  String valueString = colorString.split('(0x')[1].split(')')[0];
  int value = int.parse(valueString, radix: 16);
  return value;
}

class PathData {
  DPath path = DPath();
  Color selectedColor = Colors.black;
  double selectedWidth = 1.0;
  PathType pathType = PathType.normal;
  PathData(this.path, this.selectedColor, this.selectedWidth, this.pathType);

  PathData.fromJson(Map<String, dynamic> json) {
    path = DPath.fromJson(json['path']);
    selectedColor = Color(colorStringToInt(json['selectedColor']));
    selectedWidth = json['selectedWidth'];
    pathType = PathType.values[json['pathType']];
  }

  Map<String, dynamic> toJson() => {
        'path': jsonEncode(path),
        'selectedColor': selectedColor.toString(),
        'selectedWidth': selectedWidth,
        'pathType': pathType.index,
      };
}

class PathInfo {
  final Color color;
  final List<PathData> pathDataList;
  PathInfo({Key? key, required this.color, required this.pathDataList});
}
