import 'package:draw/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:math' as math;

import '../actions/actions.dart';
import '../models/app_state.dart';

class ToolsPanel extends StatefulWidget {
  ToolsPanel({Key? key}) : super(key: key);

  @override
  State<ToolsPanel> createState() => _ToolsPanelState();
}

class _ToolsPanelState extends State<ToolsPanel> {
  static const double radius = 20;
  bool zoomSelected = false;
  bool pickerSelected = false;
  bool pencilSelected = false;
  bool brushSelected = false;
  bool panSelected = false;
  bool pointerSelected = false;
  bool lassoSelected = false;
  bool selectSelected = true;

  void resetAllTools() {
    zoomSelected = false;
    pickerSelected = false;
    pencilSelected = false;
    brushSelected = false;
    panSelected = false;
    pointerSelected = false;
    lassoSelected = false;
    selectSelected = false;
  }

  void setSelectedTool(Tool tool) {
    resetAllTools();
    switch (tool) {
      case Tool.select:
        selectSelected = true;
        break;
      case Tool.brush:
        brushSelected = true;
        break;
      case Tool.picker:
        pickerSelected = true;
        break;
      case Tool.pencil:
        pencilSelected = true;
        break;
      case Tool.zoom:
        zoomSelected = true;
        break;
      case Tool.pan:
        panSelected = true;
        break;
      case Tool.lasso:
        lassoSelected = true;
        break;
      default:
        break;
    }
    StoreProvider.of<AppState>(context).dispatch(SetTool(tool));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: double.infinity,
      margin: const EdgeInsets.only(top: 40.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(radius),
            bottomRight: Radius.circular(radius)),
        color: Color.fromARGB(255, 53, 53, 53),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Transform.rotate(
              angle: -math.pi / 2,
              child: IconButton(
                  color: selectSelected ? Colors.white : Colors.white38,
                  icon: const Icon(Icons.near_me),
                  onPressed: () => {
                        setState(() {
                          setSelectedTool(Tool.select);
                        })
                      },
                  //tooltip: "Selection",
                  mouseCursor: MouseCursor.defer),
            ),
            IconButton(
                color: lassoSelected ? Colors.white : Colors.white38,
                icon: const Icon(Icons.gesture),
                onPressed: () => {
                      setState(() {
                        setSelectedTool(Tool.lasso);
                      })
                    },
                //tooltip: "Lasso",
                mouseCursor: MouseCursor.defer),
            IconButton(
                color: pencilSelected ? Colors.white : Colors.white38,
                icon: const Icon(Icons.create),
                onPressed: () => {
                      setState(() {
                        setSelectedTool(Tool.pencil);
                      })
                    },
                //tooltip: "Pencil",
                mouseCursor: MouseCursor.defer),
            IconButton(
                color: brushSelected ? Colors.white : Colors.white38,
                icon: const Icon(Icons.brush),
                onPressed: () => {
                      setState(() {
                        setSelectedTool(Tool.brush);
                      })
                    },
                //tooltip: "Paint Brush",
                mouseCursor: MouseCursor.defer),
            IconButton(
                color: panSelected ? Colors.white : Colors.white38,
                icon: const Icon(Icons.back_hand),
                onPressed: () => {
                      setState(() {
                        setSelectedTool(Tool.pan);
                      })
                    },
                //tooltip: "Pan",
                mouseCursor: MouseCursor.defer),
            IconButton(
                color: pickerSelected ? Colors.white : Colors.white38,
                icon: const Icon(Icons.colorize),
                onPressed: () => {
                      setState(() {
                        setSelectedTool(Tool.picker);
                      })
                    },
                //tooltip: "Color Picker",
                mouseCursor: MouseCursor.defer),
            IconButton(
                color: zoomSelected ? Colors.white : Colors.white38,
                icon: const Icon(Icons.search),
                onPressed: () => {
                      setState(() {
                        setSelectedTool(Tool.zoom);
                      })
                    },
                tooltip: "Zoom",
                mouseCursor: MouseCursor.defer),
          ],
        ),
      ),
    );
  }
}
