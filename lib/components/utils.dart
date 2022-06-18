import 'package:flutter/services.dart';

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
