import 'package:draw/reducers/color_reducer.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    color: colorReducer(state.color, action),
  );
}
