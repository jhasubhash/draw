import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class DPath {
  List<Offset> data = [];
  Path path = Path();

  DPath() {}

  //@override
  moveTo(double x, double y) {
    data.add(Offset(x, y));
    path.moveTo(x, y);
  }

  //@override
  lineTo(double x, double y) {
    data.add(Offset(x, y));
    path.lineTo(x, y);
  }

  //@override
  transform(Float64List matrix4) {
    path = path.transform(matrix4);
    var mat = Matrix4.fromFloat64List(matrix4);
    for (int idx = 0; idx < data.length; idx++) {
      var offset = data[idx];
      MatrixUtils.transformPoint(mat, offset);
      data[idx] = offset;
    }
  }

  DPath.fromJson(String pathData) {
    var data = jsonDecode(pathData);
    var offsetData = data.map((e) => Offset(e[0], e[1])).toList();
    for (int idx = 0; idx < offsetData.length; idx++) {
      var offset = offsetData[idx];
      if (idx == 0) {
        moveTo(offsetData[0].dx, offsetData[0].dy);
        continue;
      }
      lineTo(offset.dx, offset.dy);
    }
  }

  List<List<double>> toJson() {
    var simplified = data.map((e) => [e.dx, e.dy]).toList();
    return simplified;
  }
}
