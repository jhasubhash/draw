import 'package:draw/actions/actions.dart';
import 'package:draw/components/tools/brushes/multiline_brush.dart';
import 'package:draw/components/tools/brushes/normal_brush.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../canvas_data.dart';
import '../custom/path.dart';
import '../layer_manager.dart';
import '../op_manager.dart';
import '../utils.dart';
import '../../models/app_state.dart';

class Brush extends StatefulWidget {
  const Brush({Key? key}) : super(key: key);
  @override
  State<Brush> createState() => _BrushState();
}

class _BrushState extends State<Brush> {
  double selectedWidth = 1.0;
  DPath p = DPath();
  late List<PathData> pathDataList;
  bool secondaryDragging = false;

  void onPanStart(PathInfo pInfo, PointerDownEvent details) {
    if (details.buttons == kSecondaryButton) {
      secondaryDragging = true;
      StoreProvider.of<AppState>(context).dispatch(SetPanning(true));
      return;
    }
    final brushType =
        StoreProvider.of<AppState>(context).state.selectedBrushType;
    List<PathData> newPathDataList = [];
    switch (brushType) {
      case BrushType.normal:
        newPathDataList = NormalBrush().onPanStart(context, pInfo, details);
        break;
      case BrushType.multiline:
        newPathDataList = MultilineBrush().onPanStart(context, pInfo, details);
        break;
      default:
    }
    pathDataList = List<PathData>.from(pInfo.pathDataList)
      ..addAll(newPathDataList);
  }

  void onPanUpdate(PathInfo pInfo, PointerMoveEvent details) {
    if (details.buttons == kSecondaryButton) {
      return;
    }
    final brushType =
        StoreProvider.of<AppState>(context).state.selectedBrushType;
    switch (brushType) {
      case BrushType.normal:
        NormalBrush().onPanUpdate(context, pInfo, details);
        break;
      case BrushType.multiline:
        MultilineBrush().onPanUpdate(context, pInfo, details);
        break;
      default:
    }
    Layer layer = LayerManager(context).getActiveLayer();
    LayerManager(context).modifyLayerWithId(layer.layerId, pathDataList);
  }

  void onPanEnd(PathInfo pInfo, PointerUpEvent details) {
    if (secondaryDragging) {
      StoreProvider.of<AppState>(context).dispatch(SetPanning(false));
      setState(() {
        secondaryDragging = false;
      });
      return;
    }
    DrawOperation op = DrawOperation();
    Layer layer = LayerManager(context).getActiveLayer();
    op.tool = Tool.brush;
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
          return AbsorbPointer(
            absorbing: false,
            child: Listener(
              behavior: secondaryDragging
                  ? HitTestBehavior.deferToChild
                  : HitTestBehavior.opaque,
              onPointerDown: (details) => onPanStart(pInfo, details),
              onPointerMove: (details) => onPanUpdate(pInfo, details),
              onPointerUp: (details) => onPanEnd(pInfo, details),
            ),
          );
        });
  }
}
