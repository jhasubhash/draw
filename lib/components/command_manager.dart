import 'package:draw/components/undo_redo.dart';
import 'package:flutter/material.dart';

enum Command { undo, redo }

class CommandManager {
  static final CommandManager _instance = CommandManager._internal();

  factory CommandManager() {
    return _instance;
  }

  CommandManager._internal() {
    // initialization logic
  }

  execute(BuildContext context, Command cmd) {
    switch (cmd) {
      case Command.undo:
        undo(context);
        break;
      case Command.redo:
        redo(context);
        break;
      default:
        break;
    }
  }
}

class UndoIntent extends Intent {
  const UndoIntent();
}

class UndoAction extends Action<UndoIntent> {
  final context;
  UndoAction(this.context);

  @override
  Object? invoke(UndoIntent intent) {
    CommandManager().execute(context, Command.undo);
    return null;
  }
}
