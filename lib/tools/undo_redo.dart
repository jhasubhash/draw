import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../actions/actions.dart';
import '../components/canvas_data.dart';
import '../models/app_state.dart';

void undo(BuildContext context) {
  List<PathData> pathDataList =
      StoreProvider.of<AppState>(context).state.pathDataList;
  if (pathDataList.isNotEmpty) {
    pathDataList.removeLast();
  }
  StoreProvider.of<AppState>(context).dispatch(SetPathData(pathDataList));
}

void redo(BuildContext context) {}
