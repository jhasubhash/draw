import 'package:draw/components/tools/pencil.dart';
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

class SetBrushPanelVisibility {
  final bool brushPanelVisible;
  SetBrushPanelVisibility(this.brushPanelVisible);
}

class SetSavePanelVisibility {
  final bool savePanelVisible;
  SetSavePanelVisibility(this.savePanelVisible);
}

class SetTool {
  final Tool tool;
  SetTool(this.tool);
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

class ResetState {}

class NewDocument {
  final double artboardHeight;
  final double artboardWidth;
  NewDocument(this.artboardHeight, this.artboardWidth);
}

class SetArtboardWidth {
  final double artboardWidth;
  SetArtboardWidth(this.artboardWidth);
}

class SetArtboardHeight {
  final double artboardHeight;
  SetArtboardHeight(this.artboardHeight);
}

class SetSelectedBrushType {
  final BrushType selectedBrushType;
  SetSelectedBrushType(this.selectedBrushType);
}
