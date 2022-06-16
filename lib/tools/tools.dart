import 'package:draw/components/utils.dart';
import 'package:draw/models/app_state.dart';
import 'package:draw/tools/lasso.dart';
import 'package:draw/tools/pencil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

enum ToolType { lassoTool, penTool, eraseTool }

class Tools extends StatefulWidget {
  const Tools({Key? key}) : super(key: key);

  @override
  State<Tools> createState() => _ToolsState();
}

class _ToolsState extends State<Tools> {
  ToolType toolType = ToolType.lassoTool;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Tool>(
        converter: (store) => store.state.tool,
        builder: (BuildContext context, Tool tool) {
          switch (tool) {
            case Tool.lasso:
              return const LassoTool();
            case Tool.pencil:
              return const Pencil();
            default:
              return Container();
          }
        });
  }
}
