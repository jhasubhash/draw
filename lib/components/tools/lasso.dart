import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../actions/actions.dart';
import '../canvas_data.dart';
import '../custom/path.dart';
import '../layer_manager.dart';
import '../op_manager.dart';
import '../utils.dart';
import '../../models/app_state.dart';

class LassoTool extends StatefulWidget {
  final lassoClear;
  const LassoTool({Key? key, required this.lassoClear}) : super(key: key);

  @override
  State<LassoTool> createState() => _LassoToolState();
}

class _LassoToolState extends State<LassoTool> {
  double selectedWidth = 1.0;
  DPath p = DPath();
  late List<PathData> pathDataList;
  bool secondaryDragging = false;

  void onPanStart(PathInfo pInfo, PointerDownEvent details) {
    PointerDeviceKind pointerType = details.kind;
    bool touchDevice = pointerType == PointerDeviceKind.touch ||
        pointerType == PointerDeviceKind.stylus;
    if (details.buttons == kSecondaryButton && !touchDevice) {
      secondaryDragging = true;
      StoreProvider.of<AppState>(context).dispatch(SetPanning(true));
      return;
    }
    bool clear = widget.lassoClear ||
        RawKeyboard.instance.keysPressed.contains(LogicalKeyboardKey.shiftLeft);
    PathType fillType = clear ? PathType.lassoClear : PathType.lassoFill;

    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.localPosition);
    p = DPath();
    p.moveTo(details.localPosition.dx, details.localPosition.dy);
    List<PathData> newPathDataList = List<PathData>.from(pInfo.pathDataList)
      ..add(PathData(p, pInfo.color, 0, fillType));
    pathDataList = newPathDataList;
  }

  void onPanUpdate(PathInfo pInfo, PointerMoveEvent details) {
    PointerDeviceKind pointerType = details.kind;
    bool touchDevice = pointerType == PointerDeviceKind.touch ||
        pointerType == PointerDeviceKind.stylus;
    if (details.buttons == kSecondaryButton && !touchDevice) {
      return;
    }
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.localPosition);
    p.lineTo(details.localPosition.dx, details.localPosition.dy);
    Layer layer = LayerManager(context).getActiveLayer();
    LayerManager(context).modifyLayerWithId(layer.layerId, pathDataList);
  }

  void onPanEnd(PathInfo pInfo, PointerUpEvent details) {
    PointerDeviceKind pointerType = details.kind;
    bool touchDevice = pointerType == PointerDeviceKind.touch ||
        pointerType == PointerDeviceKind.stylus;
    if (secondaryDragging && !touchDevice) {
      StoreProvider.of<AppState>(context).dispatch(SetPanning(false));
      setState(() {
        secondaryDragging = false;
      });
      return;
    }
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
