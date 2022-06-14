import 'package:draw/components/artboard.dart';
import 'package:draw/components/colorpicker.dart';
import 'package:flutter/material.dart';
import 'models/app_state.dart';
import 'reducers/app_reducer.dart';
import 'tools/tools.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: const AppState(color: Colors.black),
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    var padding = MediaQuery.of(context).padding;
    double newheight = totalHeight - padding.top - padding.bottom;

    double artboardWidth = 800; //totalWidth / 1.5;
    double artboardHeight = 600; //totalHeight / 1.5;

    AppBar appBar = AppBar(
      title: Text(widget.title),
      toolbarHeight: 30,
    );

    return Scaffold(
      body: StoreConnector<AppState, Color>(
          converter: (Store<AppState> store) => store.state.color,
          builder: (BuildContext context, Color color) {
            return Container(
              color: Colors.black,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: Colors.grey,
                      width: totalWidth,
                      height: totalHeight,
                      child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            InteractiveViewer(
                              boundaryMargin:
                                  const EdgeInsets.all(double.infinity),
                              minScale: 0.01,
                              maxScale: 1000,
                              child: SizedBox(
                                width: totalWidth,
                                height: totalHeight,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: ClipRect(
                                    child: Container(
                                      width: artboardWidth,
                                      height: artboardHeight,
                                      child: LayoutBuilder(builder:
                                          (BuildContext context,
                                              BoxConstraints constraints) {
                                        return Stack(children: [
                                          Artboard(
                                              canvasHeight:
                                                  constraints.maxHeight,
                                              canvasWidth:
                                                  constraints.maxWidth),
                                          Tools(
                                              canvasWidth: constraints.maxWidth,
                                              canvasHeight:
                                                  constraints.maxHeight),
                                        ]);
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              color: Colors.green,
                              child: const DrawColorPicker(),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
