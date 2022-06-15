import 'package:draw/actions/actions.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

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
