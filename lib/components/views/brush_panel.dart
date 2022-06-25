import 'package:draw/components/tools/brush.dart';
import 'package:draw/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../actions/actions.dart';
import '../../models/app_state.dart';
import '../colorpicker.dart';
import 'layer_panel.dart';
import 'dart:math';

class BrushPanel extends StatefulWidget {
  const BrushPanel({Key? key}) : super(key: key);

  @override
  State<BrushPanel> createState() => _BrushPanelState();
}

class _BrushPanelState extends State<BrushPanel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  handleBrushSelect(BrushType type) {
    switch (type) {
      case BrushType.normal:
        break;
      default:
    }
    StoreProvider.of<AppState>(context).dispatch(SetSelectedBrushType(type));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BrushType>(
        converter: (store) => store.state.selectedBrushType,
        builder: (BuildContext context, BrushType selectedBrushType) {
          return Container(
            alignment: Alignment.topCenter,
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                canvasColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: ListTile(
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      textColor: Colors.white,
                      selectedColor: Colors.white,
                      style: ListTileStyle.list,
                      hoverColor: const Color.fromARGB(255, 53, 53, 53),
                      focusColor: const Color.fromARGB(255, 53, 53, 53),
                      selectedTileColor: const Color.fromARGB(255, 53, 53, 53),
                      key: const Key('1'),
                      title: const Text("Normal Brush"),
                      selected: selectedBrushType == BrushType.normal,
                      onTap: () {
                        handleBrushSelect(BrushType.normal);
                      },
                    ),
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: ListTile(
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      textColor: Colors.white,
                      selectedColor: Colors.white,
                      style: ListTileStyle.list,
                      hoverColor: const Color.fromARGB(255, 53, 53, 53),
                      focusColor: const Color.fromARGB(255, 53, 53, 53),
                      selectedTileColor: const Color.fromARGB(255, 53, 53, 53),
                      key: const Key('1'),
                      title: const Text("Dashed Brush"),
                      selected: selectedBrushType == BrushType.dashed,
                      onTap: () {
                        handleBrushSelect(BrushType.dashed);
                      },
                    ),
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: ListTile(
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      textColor: Colors.white,
                      selectedColor: Colors.white,
                      style: ListTileStyle.list,
                      hoverColor: const Color.fromARGB(255, 53, 53, 53),
                      focusColor: const Color.fromARGB(255, 53, 53, 53),
                      selectedTileColor: const Color.fromARGB(255, 53, 53, 53),
                      key: const Key('1'),
                      title: const Text("Multiline Brush"),
                      selected: selectedBrushType == BrushType.multiline,
                      onTap: () {
                        handleBrushSelect(BrushType.multiline);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
