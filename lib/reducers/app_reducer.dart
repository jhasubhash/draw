import 'package:draw/reducers/prop_reducer.dart';
import 'package:flutter/material.dart';
import '../actions/actions.dart';
import '../models/models.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    color: action is SetColor ? colorReducer(state.color, action) : state.color,
    propertyPanelVisible: action is SetPropertiesPanelVisibility
        ? propPanelVisibleReducer(state.propertyPanelVisible, action)
        : state.propertyPanelVisible,
  );
}
