import 'package:draw/tools/lasso.dart';
import 'package:flutter/material.dart';

enum ToolType { lassoTool, penTool, eraseTool }

class Tools extends StatefulWidget {
  const Tools({Key? key, required this.canvasHeight, required this.canvasWidth})
      : super(key: key);
  final double canvasWidth;
  final double canvasHeight;

  @override
  State<Tools> createState() => _ToolsState();
}

class _ToolsState extends State<Tools> {
  ToolType toolType = ToolType.lassoTool;
  @override
  Widget build(BuildContext context) {
    switch (toolType) {
      case ToolType.lassoTool:
        return LassoTool(
            canvasHeight: widget.canvasHeight, canvasWidth: widget.canvasWidth);
      default:
        return Container();
    }
  }
}
