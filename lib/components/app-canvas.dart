import 'package:draw/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../models/app_state.dart';
import 'tools/tools.dart';
import 'app_cursor.dart';
import 'artboard.dart';

class AppCanvas extends StatefulWidget {
  AppCanvas({Key? key}) : super(key: key);

  @override
  State<AppCanvas> createState() => _AppCanvasState();
}

class ArtBoardSize {
  late double width;
  late double height;
  ArtBoardSize(this.width, this.height);
}

class _AppCanvasState extends State<AppCanvas> {
  Offset position = Offset.zero;
  double cursorSize = 6;
  bool canvasActive = false;

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    return StoreConnector<AppState, ArtBoardSize>(
        converter: (store) =>
            ArtBoardSize(store.state.artboardWidth, store.state.artboardHeight),
        builder: (BuildContext context, ArtBoardSize size) {
          return Listener(
            onPointerHover: (event) {
              setState(() {
                position = event.position;
              });
            },
            onPointerMove: (event) {
              setState(() {
                position = event.position;
              });
            },
            child: MouseRegion(
              cursor: !IsSelectToolActive(context)
                  ? SystemMouseCursors.none
                  : SystemMouseCursors.basic,
              onEnter: (event) {
                setState(() {
                  canvasActive = !IsSelectToolActive(context) ? true : false;
                });
              },
              onExit: (event) {
                setState(() {
                  canvasActive = false;
                });
              },
              child: Stack(children: [
                Container(
                  color: Colors.grey,
                  width: totalWidth,
                  height: totalHeight,
                  child: InteractiveViewer(
                    boundaryMargin: const EdgeInsets.all(double.infinity),
                    minScale: 0.01,
                    maxScale: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: size.width,
                        height: size.height,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset:
                                  Offset(3, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Stack(children: [
                            Artboard(
                                canvasHeight: constraints.maxHeight,
                                canvasWidth: constraints.maxWidth),
                            const Tools(),
                          ]);
                        }),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: position.dx - cursorSize / 2,
                  top: position.dy - cursorSize / 2,
                  child:
                      canvasActive ? AppCursor(size: cursorSize) : Container(),
                ),
              ]),
            ),
          );
        });
  }
}
