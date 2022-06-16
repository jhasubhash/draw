import 'package:draw/tools/pencil.dart';
import 'package:flutter/material.dart';

import '../components/canvas_data.dart';
import '../components/utils.dart';

@immutable
class AppState {
  final Color color;
  final bool propertyPanelVisible;
  final Tool tool;
  final List<PathData> pathDataList;
  final double strokeWidth;

  const AppState(
      {required this.color,
      required this.propertyPanelVisible,
      required this.tool,
      required this.pathDataList,
      required this.strokeWidth});

  @override
  String toString() {
    return 'AppState: {color: $color} {propertyPanelVisible: $propertyPanelVisible}';
  }
}
