import 'package:flutter/material.dart';

import '../../canvas_data.dart';

abstract class BaseBrush {
  List<PathData> onPanStart(
      BuildContext context, PathInfo pInfo, DragStartDetails details);
  onPanUpdate(BuildContext context, PathInfo pInfo, DragUpdateDetails details);
  onPanEnd(BuildContext context, PathInfo pInfo, DragEndDetails details);
}
