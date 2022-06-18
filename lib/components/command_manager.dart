import 'package:draw/components/commands/undo_redo.dart';
import 'package:flutter/material.dart';

import 'commands/new_document.dart';

enum Command { undo, redo, newDoc }

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
      case Command.newDoc:
        newDocument(context);
        break;
      default:
        break;
    }
  }
}
