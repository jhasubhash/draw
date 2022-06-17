import 'package:draw/components/op_manager.dart';
import 'package:flutter/material.dart';

void undo(BuildContext context) {
  OpManager().revertLastOperation(context);
}

void redo(BuildContext context) {}
