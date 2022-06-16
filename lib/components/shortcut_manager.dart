import 'package:draw/components/command_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Map<LogicalKeySet, Intent> getShortcuts() {
  return <LogicalKeySet, Intent>{
    LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyZ):
        const UndoIntent(),
    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ):
        const UndoIntent(),
  };
}

getActions(BuildContext context) {
  return <Type, Action<Intent>>{
    UndoIntent: UndoAction(context),
  };
}
