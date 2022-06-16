import 'package:draw/reducers/prop_reducer.dart';
import 'package:flutter/material.dart';
import '../actions/actions.dart';
import '../models/models.dart';

AppState appReducer(AppState state, action) {
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
          : state.strokeWidth);
}
