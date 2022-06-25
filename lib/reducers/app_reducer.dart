import 'package:draw/reducers/prop_reducer.dart';
import 'package:flutter/material.dart';
import '../actions/actions.dart';
import '../components/canvas_data.dart';
import '../components/utils.dart';
import '../models/models.dart';

AppState getInitialState() {
  return AppState(
      color: Colors.black,
      propertyPanelVisible: false,
      brushPanelVisible: false,
      tool: Tool.select,
      strokeWidth: 1,
      artboardWidth: 800,
      artboardHeight: 600,
      activeLayer: Layer(1),
      layers: [Layer(1), Layer(0)],
      savePanelVisible: false,
      selectedBrushType: BrushType.normal);
}

AppState appReducer(AppState state, action) {
  if (action is NewDocument) {
    return AppState(
        color: state.color,
        propertyPanelVisible: state.propertyPanelVisible,
        brushPanelVisible: state.brushPanelVisible,
        tool: state.tool,
        strokeWidth: state.strokeWidth,
        activeLayer: Layer(1),
        layers: [Layer(1), Layer(0)],
        artboardWidth: action.artboardWidth,
        artboardHeight: action.artboardHeight,
        savePanelVisible: false,
        selectedBrushType: state.selectedBrushType);
  }
  return AppState(
      color:
          action is SetColor ? colorReducer(state.color, action) : state.color,
      propertyPanelVisible: action is SetPropertiesPanelVisibility
          ? propPanelVisibleReducer(state.propertyPanelVisible, action)
          : state.propertyPanelVisible,
      brushPanelVisible: action is SetBrushPanelVisibility
          ? brushPanelVisibleReducer(state.brushPanelVisible, action)
          : state.brushPanelVisible,
      tool: action is SetTool ? toolReducer(state.tool, action) : state.tool,
      strokeWidth: action is SetStrokeWidth
          ? strokeWidthReducer(state.strokeWidth, action)
          : state.strokeWidth,
      activeLayer: action is SetActiveLayer
          ? activeLayerReducer(state.activeLayer, action)
          : state.activeLayer,
      layers: action is SetLayers
          ? layersReducer(state.layers, action)
          : state.layers,
      artboardWidth: action is SetArtboardWidth
          ? artboardWidthReducer(state.artboardWidth, action)
          : state.artboardWidth,
      artboardHeight: action is SetArtboardHeight
          ? artboardHeightReducer(state.artboardHeight, action)
          : state.artboardHeight,
      savePanelVisible: action is SetSavePanelVisibility
          ? savePanelVisibilityReducer(state.savePanelVisible, action)
          : state.savePanelVisible,
      selectedBrushType: action is SetSelectedBrushType
          ? selectedBrushTypeReducer(state.selectedBrushType, action)
          : state.selectedBrushType);
}
