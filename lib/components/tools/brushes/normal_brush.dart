import 'package:draw/components/canvas_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../models/app_state.dart';
import '../../custom/path.dart';
import 'base_brush.dart';

class NormalBrush extends BaseBrush {
  static final NormalBrush _instance = NormalBrush._internal();
  DPath p = DPath();

  factory NormalBrush() {
    return _instance;
  }

  NormalBrush._internal() {
    // initialization logic
  }

  @override
  List<PathData> onPanStart(
      BuildContext context, PathInfo pInfo, PointerDownEvent details) {
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.localPosition);
    final pathWidth = StoreProvider.of<AppState>(context).state.strokeWidth;
    p = DPath();
    p.moveTo(details.localPosition.dx, details.localPosition.dy);
    List<PathData> newPathDataList = [
      PathData(p, pInfo.color, pathWidth, PathType.normal)
    ];
    return newPathDataList;
  }

  @override
  onPanUpdate(BuildContext context, PathInfo pInfo, PointerMoveEvent details) {
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.localPosition);
    p.lineTo(details.localPosition.dx, details.localPosition.dy);
  }

  @override
  onPanEnd(BuildContext context, PathInfo pInfo, PointerUpEvent details) {}
}
