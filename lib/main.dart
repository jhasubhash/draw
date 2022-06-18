// ignore_for_file: unnecessary_new

import 'package:draw/components/views/properties_panel.dart';
import 'package:draw/components/views/right_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/app-canvas.dart';
import 'components/command_manager.dart';
import 'components/views/tools_panel.dart';
import 'models/app_state.dart';
import 'reducers/app_reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(appReducer, initialState: getInitialState());
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

  final FocusNode _mainAppfocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _mainAppfocus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _mainAppfocus.removeListener(_onFocusChange);
    _mainAppfocus.dispose();
  }

  void _onFocusChange() {
    debugPrint("Mainapp Focus: ${_mainAppfocus.hasFocus.toString()}");
    if (!_mainAppfocus.hasFocus) {
      FocusNode? _focusNode = FocusScope.of(context).focusedChild;
      if (_focusNode == null) {
        _mainAppfocus.requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyZ, meta: true): () =>
            CommandManager().execute(context, Command.undo),
        const SingleActivator(LogicalKeyboardKey.keyN, meta: true): () =>
            CommandManager().execute(context, Command.newDoc),
      },
      child: Focus(
        autofocus: true,
        canRequestFocus: true,
        focusNode: _mainAppfocus,
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
                    child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
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
                            margin:
                                const EdgeInsets.only(top: 50.0, bottom: 50.0),
                            child: ToolsPanel(),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ));
        }),
      ),
    );
  }
}
