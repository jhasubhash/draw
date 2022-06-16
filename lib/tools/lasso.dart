import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../actions/actions.dart';
import '../components/canvas_data.dart';
import '../models/app_state.dart';

class LassoTool extends StatefulWidget {
  const LassoTool({Key? key}) : super(key: key);

  @override
  State<LassoTool> createState() => _LassoToolState();
}

class _LassoToolState extends State<LassoTool> {
  double selectedWidth = 1.0;
  Path p = Path();
  late List<PathData> pathDataList;

  void onPanStart(PathInfo pInfo, DragStartDetails details) {
    bool shiftPressed =
        RawKeyboard.instance.keysPressed.contains(LogicalKeyboardKey.shiftLeft);
    PathType fillType = shiftPressed ? PathType.lassoClear : PathType.lassoFill;

    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    p = Path();
    p.moveTo(details.localPosition.dx, details.localPosition.dy);
    //Color color = shiftPressed ? Colors.transparent : pInfo.color;
    List<PathData> newPathDataList = List<PathData>.from(pInfo.pathDataList)
      ..add(PathData(p, pInfo.color, selectedWidth, fillType));
    pathDataList = newPathDataList;
  }

  void onPanUpdate(PathInfo pInfo, DragUpdateDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    p.lineTo(details.localPosition.dx, details.localPosition.dy);
    StoreProvider.of<AppState>(context).dispatch(SetPathData(pathDataList));
  }

  void onPanEnd(PathInfo pInfo, DragEndDetails details) {
    //StoreProvider.of<AppState>(context).dispatch(SetPathData(pathDataList));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PathInfo>(
        converter: (store) => PathInfo(
            color: store.state.color, pathDataList: store.state.pathDataList),
        builder: (BuildContext context, PathInfo pInfo) {
          return GestureDetector(
            onPanStart: (details) => onPanStart(pInfo, details),
            onPanUpdate: (details) => onPanUpdate(pInfo, details),
            onPanEnd: (details) => onPanEnd(pInfo, details),
          );
        });
  }
}
