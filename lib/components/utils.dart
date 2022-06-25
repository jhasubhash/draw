import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../models/app_state.dart';

enum Tool {
  select,
  lasso,
  pencil,
  eraser,
  brush,
  pan,
  zoom,
  picker,
  lassoClear
}

enum BrushType { normal, multiline, dashed }

enum OpAction { lassoFill, lassoErase, drawStroke, erase }

var DigitInputFormatter = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
  TextInputFormatter.withFunction((oldValue, newValue) {
    try {
      final text = newValue.text;
      if (text.isNotEmpty) double.parse(text);
      return newValue;
    } catch (e) {}
    return oldValue;
  }),
];

bool IsSelectToolActive(context) {
  return StoreProvider.of<AppState>(context).state.tool == Tool.select;
}

bool IsPanToolActive(context) {
  bool panToolActive =
      StoreProvider.of<AppState>(context).state.tool == Tool.pan;
  bool panningActive = StoreProvider.of<AppState>(context).state.panning;

  return panToolActive || panningActive;
}
