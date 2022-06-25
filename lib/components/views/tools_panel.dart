import 'package:draw/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:math' as math;

import '../../actions/actions.dart';
import '../../models/app_state.dart';
import '../command_manager.dart';

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
  bool eraserSelected = false;
  bool lassoClearSelected = false;

  void resetAllTools() {
    zoomSelected = false;
    pickerSelected = false;
    pencilSelected = false;
    brushSelected = false;
    panSelected = false;
    pointerSelected = false;
    lassoSelected = false;
    selectSelected = false;
    eraserSelected = false;
    lassoClearSelected = false;
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
      case Tool.eraser:
        eraserSelected = true;
        break;
      case Tool.lassoClear:
        lassoClearSelected = true;
        break;
      default:
        break;
    }
    StoreProvider.of<AppState>(context).dispatch(SetTool(tool));
  }

  void changeSavePanelVisibility(BuildContext context, bool visible) {
    StoreProvider.of<AppState>(context)
        .dispatch(SetSavePanelVisibility(visible));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
        converter: (store) => store.state.savePanelVisible,
        builder: (BuildContext context, bool savePanelVisible) {
          return Container(
              width: 40,
              height: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(radius),
                    bottomRight: Radius.circular(radius)),
                color: Color.fromARGB(255, 53, 53, 53),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Transform.rotate(
                          angle: -math.pi / 2,
                          child: IconButton(
                              color: selectSelected
                                  ? Colors.white
                                  : Colors.white38,
                              icon: const Icon(Icons.near_me),
                              onPressed: () => {
                                    setState(() {
                                      setSelectedTool(Tool.select);
                                    })
                                  },
                              //tooltip: "Selection",
                              mouseCursor: MouseCursor.defer),
                        ),
                        Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              IconButton(
                                  color: lassoSelected
                                      ? Colors.white
                                      : Colors.white38,
                                  icon: const Icon(Icons.gesture_outlined),
                                  onPressed: () => {
                                        setState(() {
                                          setSelectedTool(Tool.lasso);
                                        })
                                      },
                                  //tooltip: "Lasso",
                                  mouseCursor: MouseCursor.defer),
                              Text("+ ",
                                  style: TextStyle(
                                    color: lassoSelected
                                        ? Colors.white
                                        : Colors.white38,
                                  )),
                            ]),
                        Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              IconButton(
                                  color: lassoClearSelected
                                      ? Colors.white
                                      : Colors.white38,
                                  icon: const Icon(Icons.gesture_outlined),
                                  onPressed: () => {
                                        setState(() {
                                          setSelectedTool(Tool.lassoClear);
                                        })
                                      },
                                  //tooltip: "Lasso",
                                  mouseCursor: MouseCursor.defer),
                              Text("- ",
                                  style: TextStyle(
                                    color: lassoClearSelected
                                        ? Colors.white
                                        : Colors.white38,
                                  )),
                            ]),
                        IconButton(
                            color:
                                pencilSelected ? Colors.white : Colors.white38,
                            icon: const Icon(Icons.create),
                            onPressed: () => {
                                  setState(() {
                                    setSelectedTool(Tool.pencil);
                                  })
                                },
                            //tooltip: "Pencil",
                            mouseCursor: MouseCursor.defer),
                        IconButton(
                            color:
                                brushSelected ? Colors.white : Colors.white38,
                            icon: const Icon(Icons.brush),
                            onPressed: () => {
                                  setState(() {
                                    setSelectedTool(Tool.brush);
                                  })
                                },
                            //tooltip: "Paint Brush",
                            mouseCursor: MouseCursor.defer),
                        Transform.rotate(
                          angle: -math.pi / 4,
                          child: Transform.scale(
                            scaleY: 0.6,
                            child: IconButton(
                                color: eraserSelected
                                    ? Colors.white
                                    : Colors.white38,
                                icon: const Icon(Icons.rectangle),
                                onPressed: () => {
                                      setState(() {
                                        setSelectedTool(Tool.eraser);
                                      })
                                    },
                                //tooltip: "Eraser",
                                mouseCursor: MouseCursor.defer),
                          ),
                        ),
                        // IconButton(
                        //     color: panSelected ? Colors.white : Colors.white38,
                        //     icon: const Icon(Icons.back_hand),
                        //     onPressed: () => {
                        //       setState(() {
                        //         setSelectedTool(Tool.pan);
                        //       })
                        //     },
                        //     //tooltip: "Pan",
                        //     mouseCursor: MouseCursor.defer),
                        // IconButton(
                        //     color: pickerSelected ? Colors.white : Colors.white38,
                        //     icon: const Icon(Icons.colorize),
                        //     onPressed: () => {
                        //       setState(() {
                        //         setSelectedTool(Tool.picker);
                        //       })
                        //     },
                        //     //tooltip: "Color Picker",
                        //     mouseCursor: MouseCursor.defer),
                        // IconButton(
                        //     color: zoomSelected ? Colors.white : Colors.white38,
                        //     icon: const Icon(Icons.search),
                        //     onPressed: () => {
                        //       setState(() {
                        //         setSelectedTool(Tool.zoom);
                        //       })
                        //     },
                        //     tooltip: "Zoom",
                        //     mouseCursor: MouseCursor.defer),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            color: Colors.white38,
                            focusColor: Colors.white,
                            splashColor: Colors.white,
                            icon: const Icon(Icons.undo),
                            onPressed: () =>
                                CommandManager().execute(context, Command.undo),
                            //tooltip: "Undo",
                            mouseCursor: MouseCursor.defer),
                        IconButton(
                            color: Colors.white38,
                            focusColor: Colors.white,
                            splashColor: Colors.white,
                            icon: const Icon(Icons.insert_drive_file),
                            onPressed: () => CommandManager()
                                .execute(context, Command.newDoc),
                            //tooltip: "open",
                            mouseCursor: MouseCursor.defer),
                        IconButton(
                            color: Colors.white38,
                            focusColor: Colors.white,
                            splashColor: Colors.white,
                            icon: const Icon(Icons.folder_open),
                            onPressed: () =>
                                CommandManager().execute(context, Command.open),
                            //tooltip: "open",
                            mouseCursor: MouseCursor.defer),
                        IconButton(
                            color: savePanelVisible
                                ? Colors.white
                                : Colors.white38,
                            icon: const Icon(Icons.save),
                            onPressed: () => {
                                  changeSavePanelVisibility(
                                      context, !savePanelVisible)
                                },
                            //CommandManager().execute(context, Command.save),
                            //tooltip: "save",
                            mouseCursor: MouseCursor.defer),
                        // const IconButton(
                        //     color: Colors.white38,
                        //     focusColor: Colors.white,
                        //     icon: Icon(Icons.redo),
                        //     onPressed:
                        //         null, //() => CommandManager().execute(context, Command.redo),
                        //     //tooltip: "Redo",
                        //     mouseCursor: MouseCursor.defer),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
