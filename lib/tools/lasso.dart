import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../models/app_state.dart';

class LassoTool extends StatefulWidget {
  const LassoTool(
      {Key? key, required this.canvasHeight, required this.canvasWidth})
      : super(key: key);
  final double canvasWidth;
  final double canvasHeight;

  @override
  State<LassoTool> createState() => _LassoToolState();
}

class _LassoToolState extends State<LassoTool> {
  double selectedWidth = 2.0;
  Path p = Path();

  List<PathData> pathDataList = [PathData(Path(), Colors.black, 1.0)];

  void onPanStart(Color color, DragStartDetails details) {
    print('User started drawing');
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    p = Path();
    p.moveTo(details.localPosition.dx, details.localPosition.dy);
    List<PathData> newPathDataList = List<PathData>.from(pathDataList)
      ..add(PathData(p, color, selectedWidth));
    setState(() {
      pathDataList = newPathDataList;
    });
    print(point);
  }

  void onPanUpdate(DragUpdateDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    p.lineTo(details.localPosition.dx, details.localPosition.dy);
    setState(() {
      pathDataList = [...pathDataList];
    });
    print(point);
  }

  void onPanEnd(DragEndDetails details) {
    print('User ended drawing');
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Color>(
        converter: (store) => store.state.color,
        builder: (BuildContext context, Color color) {
          return GestureDetector(
            onPanStart: (details) => onPanStart(color, details),
            onPanUpdate: onPanUpdate,
            onPanEnd: onPanEnd,
            child: RepaintBoundary(
              child: Container(
                width: widget.canvasWidth,
                height: widget.canvasHeight,
                // CustomPaint widget will go here
                child: CustomPaint(
                  painter: PathPainter(pathDataList),
                ),
              ),
            ),
          );
        });
  }
}

class PathData {
  Path path = Path();
  Color selectedColor = Colors.blue;
  double selectedWidth = 2.0;
  PathData(this.path, this.selectedColor, this.selectedWidth);
}

class PathPainter extends CustomPainter {
  late List<PathData> pathDataList;
  PathPainter(this.pathDataList);

  @override
  void paint(Canvas canvas, Size size) {
    for (var pathData in pathDataList) {
      Paint paint = Paint();
      paint.color = pathData.selectedColor;
      paint.strokeWidth = pathData.selectedWidth;
      paint.style = PaintingStyle.fill;
      canvas.drawPath(pathData.path, paint);
    }
  }

  // 4
  @override
  bool shouldRepaint(PathPainter delegate) {
    return true;
  }
}
