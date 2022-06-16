// ignore_for_file: unnecessary_new

import 'package:draw/components/artboard.dart';
import 'package:draw/components/colorpicker.dart';
import 'package:draw/components/properties_panel.dart';
import 'package:draw/components/right_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/app-canvas.dart';
import 'components/app_cursor.dart';
import 'components/canvas_data.dart';
import 'components/command_manager.dart';
import 'components/shortcut_manager.dart';
import 'components/tools_panel.dart';
import 'components/utils.dart';
import 'models/app_state.dart';
import 'reducers/app_reducer.dart';
import 'tools/tools.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(
        color: Colors.black,
        propertyPanelVisible: false,
        tool: Tool.select,
        pathDataList: [PathData(Path(), Colors.black, 1.0, PathType.normal)],
        strokeWidth: 1),
  );
  print('Initial state: ${store.state}');
  runApp(StoreProvider(store: store, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draw ++',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Draw ++'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    return FocusableActionDetector(
      autofocus: true,
      shortcuts: getShortcuts(),
      actions: getActions(context),
      child: Builder(builder: (context) {
        return Scaffold(
            body: Container(
          color: Colors.grey,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: totalWidth,
                  height: totalHeight,
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    AppCanvas(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 30.0, bottom: 30.0),
                              child: PropertiesPanel()),
                          RightBar(),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                      child: ToolsPanel(),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ));
      }),
    );
  }
}
