import 'package:draw/actions/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../canvas_data.dart';
import '../custom/path.dart';
import '../layer_manager.dart';
import '../op_manager.dart';
import '../utils.dart';
import '../../models/app_state.dart';

class Pencil extends StatefulWidget {
  const Pencil({Key? key}) : super(key: key);
  @override
  State<Pencil> createState() => _PencilState();
}

class _PencilState extends State<Pencil> {
  double selectedWidth = 1.0;
  DPath p = DPath();
  late List<PathData> pathDataList;

  void onPanStart(PathInfo pInfo, DragStartDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    final pathWidth = StoreProvider.of<AppState>(context).state.strokeWidth;
    p = DPath();
    p.moveTo(details.localPosition.dx, details.localPosition.dy);
    List<PathData> newPathDataList = List<PathData>.from(pInfo.pathDataList)
      ..add(PathData(p, pInfo.color, pathWidth, PathType.normal));
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
    DrawOperation op = DrawOperation();
    Layer layer = LayerManager(context).getActiveLayer();
    op.tool = Tool.lasso;
    op.layer = layer;
    OpManager().addOperation(op);
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
