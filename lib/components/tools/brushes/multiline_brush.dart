import 'package:draw/components/canvas_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../models/app_state.dart';
import '../../custom/path.dart';
import 'base_brush.dart';

class MultilineBrush extends BaseBrush {
  static final MultilineBrush _instance = MultilineBrush._internal();
  List<DPath> p = [];
  factory MultilineBrush() {
    return _instance;
  }

  MultilineBrush._internal() {
    // initialization logic
  }

  @override
  List<PathData> onPanStart(
      BuildContext context, PathInfo pInfo, DragStartDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    final pathWidth = StoreProvider.of<AppState>(context).state.strokeWidth;
    p.clear();
    for (int i = 0; i < 5; i++) {
      DPath p1 = DPath();
      p1.moveTo(details.localPosition.dx + (i - 2) * pathWidth,
          details.localPosition.dy + (i - 2) * pathWidth);
      p.add(p1);
    }

    List<PathData> newPathDataList = [];
    for (var path in p) {
      newPathDataList
          .add(PathData(path, pInfo.color, pathWidth, PathType.normal));
    }
    return newPathDataList;
  }

  @override
  onPanUpdate(BuildContext context, PathInfo pInfo, DragUpdateDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    final pathWidth = StoreProvider.of<AppState>(context).state.strokeWidth;
    for (int i = 0; i < 5; i++) {
      p[i].lineTo(details.localPosition.dx + (i - 2) * pathWidth,
          details.localPosition.dy + (i - 2) * pathWidth);
    }
  }

  @override
  onPanEnd(BuildContext context, PathInfo pInfo, DragEndDetails details) {}
}
