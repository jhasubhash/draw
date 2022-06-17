import 'package:draw/tools/pencil.dart';
import 'package:flutter/material.dart';

import '../components/canvas_data.dart';
import '../components/utils.dart';

class SetColor {
  final Color color;
  SetColor(this.color);
}

class SetPropertiesPanelVisibility {
  final bool propertyPanelVisible;
  SetPropertiesPanelVisibility(this.propertyPanelVisible);
}

class SetTool {
  final Tool tool;
  SetTool(this.tool);
}

class SetPathData {
  final List<PathData> pathDataList;
  SetPathData(this.pathDataList);
}

class SetStrokeWidth {
  final double strokeWidth;
  SetStrokeWidth(this.strokeWidth);
}

class SetActiveLayer {
  final Layer activeLayer;
  SetActiveLayer(this.activeLayer);
}

class SetLayers {
  final List<Layer> layers;
  SetLayers(this.layers);
}
