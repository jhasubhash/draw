import 'package:draw/actions/actions.dart';
import 'package:draw/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../components/canvas_data.dart';

final colorReducer = TypedReducer<Color, SetColor>(_setColorReducer);

Color _setColorReducer(Color state, SetColor action) {
  return action.color;
}

final propPanelVisibleReducer =
    TypedReducer<bool, SetPropertiesPanelVisibility>(
        _setPPanelVisibilityReducer);

bool _setPPanelVisibilityReducer(
    bool state, SetPropertiesPanelVisibility action) {
  return action.propertyPanelVisible;
}

final brushPanelVisibleReducer = TypedReducer<bool, SetBrushPanelVisibility>(
    _setBrushPanelVisibilityReducer);

bool _setBrushPanelVisibilityReducer(
    bool state, SetBrushPanelVisibility action) {
  return action.brushPanelVisible;
}

final toolReducer = TypedReducer<Tool, SetTool>(_setToolReducer);

Tool _setToolReducer(Tool state, SetTool action) {
  return action.tool;
}

final strokeWidthReducer =
    TypedReducer<double, SetStrokeWidth>(_setStrokeWidthReducer);

double _setStrokeWidthReducer(double state, SetStrokeWidth action) {
  return action.strokeWidth;
}

final activeLayerReducer =
    TypedReducer<Layer, SetActiveLayer>(_setActiveLayerReducer);

Layer _setActiveLayerReducer(Layer state, SetActiveLayer action) {
  return action.activeLayer;
}

final layersReducer = TypedReducer<List<Layer>, SetLayers>(_setLayersReducer);

List<Layer> _setLayersReducer(List<Layer> state, SetLayers action) {
  return action.layers;
}

final artboardWidthReducer =
    TypedReducer<double, SetArtboardWidth>(_setArtboardWidthReducer);

double _setArtboardWidthReducer(double state, SetArtboardWidth action) {
  return action.artboardWidth;
}

final artboardHeightReducer =
    TypedReducer<double, SetArtboardHeight>(_setArtboardHeightReducer);

double _setArtboardHeightReducer(double state, SetArtboardHeight action) {
  return action.artboardHeight;
}

final savePanelVisibilityReducer =
    TypedReducer<bool, SetSavePanelVisibility>(_setSavePanelVisibilityReducer);

bool _setSavePanelVisibilityReducer(bool state, SetSavePanelVisibility action) {
  return action.savePanelVisible;
}

final selectedBrushTypeReducer =
    TypedReducer<BrushType, SetSelectedBrushType>(_setSelectedBrushTypeReducer);

BrushType _setSelectedBrushTypeReducer(
    BrushType state, SetSelectedBrushType action) {
  return action.selectedBrushType;
}

final panningReducer = TypedReducer<bool, SetPanning>(_setPanningReducer);

bool _setPanningReducer(bool state, SetPanning action) {
  return action.panning;
}
