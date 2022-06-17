import 'package:draw/actions/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../components/canvas_data.dart';
import '../components/layer_manager.dart';
import '../models/app_state.dart';

class Eraser extends StatefulWidget {
  const Eraser({Key? key}) : super(key: key);
  @override
  State<Eraser> createState() => _EraserState();
}

class _EraserState extends State<Eraser> {
  Path p = Path();
  late List<PathData> pathDataList;

  void onPanStart(PathInfo pInfo, DragStartDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    final pathWidth = StoreProvider.of<AppState>(context).state.strokeWidth;
    p = Path();
    p.moveTo(details.localPosition.dx, details.localPosition.dy);
    List<PathData> newPathDataList = List<PathData>.from(pInfo.pathDataList)
      ..add(PathData(p, pInfo.color, pathWidth, PathType.erase));
    pathDataList = newPathDataList;
  }

  void onPanUpdate(PathInfo pInfo, DragUpdateDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    p.lineTo(details.localPosition.dx, details.localPosition.dy);
    Layer layer = LayerManager(context).getActiveLayer();
    LayerManager(context).modifyLayerWithId(layer.layerId, pathDataList);
  }

  void onPanEnd(PathInfo pInfo, DragEndDetails details) {
    //StoreProvider.of<AppState>(context).dispatch(SetPathData(pathDataList));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PathInfo>(
        converter: (store) => PathInfo(
            color: store.state.color,
            pathDataList: store.state.activeLayer.pathDataList),
        builder: (BuildContext context, PathInfo pInfo) {
          return GestureDetector(
            onPanStart: (details) => onPanStart(pInfo, details),
            onPanUpdate: (details) => onPanUpdate(pInfo, details),
            onPanEnd: (details) => onPanEnd(pInfo, details),
          );
        });
  }
}
