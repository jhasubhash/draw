import 'package:flutter/material.dart';

import '../tools/tools.dart';
import 'app_cursor.dart';
import 'artboard.dart';

class AppCanvas extends StatefulWidget {
  AppCanvas({Key? key}) : super(key: key);

  @override
  State<AppCanvas> createState() => _AppCanvasState();
}

class _AppCanvasState extends State<AppCanvas> {
  Offset position = Offset.zero;
  double cursorSize = 6;
  bool canvasActive = false;

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    double artboardWidth = 800; //totalWidth / 1.5;
    double artboardHeight = 600; //totalHeight / 1.5;

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
        cursor: SystemMouseCursors.none,
        onEnter: (event) {
          setState(() {
            canvasActive = true;
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
              maxScale: 1000,
              child: Align(
                alignment: Alignment.center,
                child: ClipRect(
                  child: Container(
                    width: artboardWidth,
                    height: artboardHeight,
                    child: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Stack(children: [
                        Artboard(
                            canvasHeight: constraints.maxHeight,
                            canvasWidth: constraints.maxWidth),
                        Tools(
                            canvasWidth: constraints.maxWidth,
                            canvasHeight: constraints.maxHeight),
                      ]);
                    }),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: position.dx - cursorSize / 2,
            top: position.dy - cursorSize / 2,
            child: canvasActive ? AppCursor(size: cursorSize) : Container(),
          ),
        ]),
      ),
    );
  }
}
