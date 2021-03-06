import 'package:draw/components/tools/pencil.dart';
import 'package:flutter/material.dart';

import '../components/canvas_data.dart';
import '../components/utils.dart';

@immutable
class AppState {
  final Color color;
  final bool propertyPanelVisible;
  final bool brushPanelVisible;
  final Tool tool;
  final double strokeWidth;
  final Layer activeLayer;
  final List<Layer> layers;
  final double artboardWidth;
  final double artboardHeight;
  final bool savePanelVisible;
  final BrushType selectedBrushType;
  final bool panning;

  const AppState({
    required this.color,
    required this.propertyPanelVisible,
    required this.brushPanelVisible,
    required this.tool,
    required this.strokeWidth,
    required this.activeLayer,
    required this.layers,
    required this.artboardWidth,
    required this.artboardHeight,
    required this.savePanelVisible,
    required this.selectedBrushType,
    required this.panning,
  });

  @override
  String toString() {
    return 'AppState: {color: $color} {propertyPanelVisible: $propertyPanelVisible}';
  }
}
