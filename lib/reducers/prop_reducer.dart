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

final toolReducer = TypedReducer<Tool, SetTool>(_setToolReducer);

Tool _setToolReducer(Tool state, SetTool action) {
  return action.tool;
}

final pathDataReducer =
    TypedReducer<List<PathData>, SetPathData>(_setPathDataReducer);

List<PathData> _setPathDataReducer(List<PathData> state, SetPathData action) {
  return action.pathDataList;
}
