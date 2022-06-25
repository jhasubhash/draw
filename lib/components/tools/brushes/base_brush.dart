import 'package:flutter/material.dart';

import '../../canvas_data.dart';

abstract class BaseBrush {
  List<PathData> onPanStart(
      BuildContext context, PathInfo pInfo, PointerDownEvent details);
  onPanUpdate(BuildContext context, PathInfo pInfo, PointerMoveEvent details);
  onPanEnd(BuildContext context, PathInfo pInfo, PointerUpEvent details);
}
