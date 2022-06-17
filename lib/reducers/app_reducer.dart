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
      tool: Tool.select,
      pathDataList: [PathData(Path(), Colors.black, 1.0, PathType.normal)],
      strokeWidth: 1,
      activeLayer: Layer(0),
      layers: [Layer(0)]);
}

AppState appReducer(AppState state, action) {
  if (action is ResetState) {
    return getInitialState();
  }
  return AppState(
      color:
          action is SetColor ? colorReducer(state.color, action) : state.color,
      propertyPanelVisible: action is SetPropertiesPanelVisibility
          ? propPanelVisibleReducer(state.propertyPanelVisible, action)
          : state.propertyPanelVisible,
      tool: action is SetTool ? toolReducer(state.tool, action) : state.tool,
      pathDataList: action is SetPathData
          ? pathDataReducer(state.pathDataList, action)
          : state.pathDataList,
      strokeWidth: action is SetStrokeWidth
          ? strokeWidthReducer(state.strokeWidth, action)
          : state.strokeWidth,
      activeLayer: action is SetActiveLayer
          ? activeLayerReducer(state.activeLayer, action)
          : state.activeLayer,
      layers: action is SetLayers
          ? layersReducer(state.layers, action)
          : state.layers);
}
