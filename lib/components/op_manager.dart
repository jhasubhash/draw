import 'package:draw/components/utils.dart';
import 'package:flutter/material.dart';

import 'canvas_data.dart';
import 'layer_manager.dart';

class Operation {
  late Tool tool;
  late OpAction action;
}

class DrawOperation extends Operation {
  late Layer layer;
}

class OpManager {
  static final OpManager _instance = OpManager._internal();
  List<Operation> opStack = [];
  factory OpManager() {
    return _instance;
  }

  OpManager._internal() {
    // initialization logic
  }

  void addOperation(Operation op) {
    opStack.add(op);
  }

  void revert(BuildContext context, Operation op) {
    if (op is DrawOperation) {
      if (op.layer.pathDataList.isNotEmpty) {
        op.layer.pathDataList.removeLast();
        LayerManager(context)
            .modifyLayerWithId(op.layer.layerId, op.layer.pathDataList);
      }
    }
  }

  void revertLastOperation(context) {
    if (opStack.isNotEmpty) {
      Operation op = opStack.last;
      opStack.removeLast();
      revert(context, op);
    }
  }
}
