import 'package:draw/actions/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../models/app_state.dart';
import '../command_manager.dart';

class SavePanel extends StatefulWidget {
  SavePanel({Key? key}) : super(key: key);

  @override
  State<SavePanel> createState() => _SavePanelState();
}

class _SavePanelState extends State<SavePanel> {
  Offset offset1 = const Offset(0, 0);
  Offset offset2 = const Offset(-1, 0);

  saveAsJson() {
    CommandManager().execute(context, Command.save);
    StoreProvider.of<AppState>(context).dispatch(SetSavePanelVisibility(false));
  }

  saveAsPng() {
    CommandManager().execute(context, Command.saveAsPng);
    StoreProvider.of<AppState>(context).dispatch(SetSavePanelVisibility(false));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
        converter: (store) => store.state.savePanelVisible,
        builder: (BuildContext context, bool visible) {
          return AnimatedSlide(
            offset: visible ? offset1 : offset2,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 80,
                  width: 150,
                  color: const Color.fromARGB(255, 94, 94, 94),
                  margin: const EdgeInsets.only(left: 40),
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
                            selectedTileColor:
                                const Color.fromARGB(255, 53, 53, 53),
                            key: const Key('1'),
                            title: const Text("Save as JSON"),
                            onTap: () {
                              saveAsJson();
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
                            selectedTileColor:
                                const Color.fromARGB(255, 53, 53, 53),
                            key: const Key('2'),
                            title: const Text("Save as PNG"),
                            onTap: () {
                              saveAsPng();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
