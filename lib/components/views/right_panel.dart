import 'package:draw/components/utils.dart';
import 'package:draw/components/views/properties_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../models/app_state.dart';
import 'brush_panel.dart';

class RightPanel extends StatefulWidget {
  RightPanel({Key? key}) : super(key: key);

  @override
  State<RightPanel> createState() => _RightPanelState();
}

class _RightPanelState extends State<RightPanel> {
  double panelWidth = 250;
  bool isPanelVisible = true;
  Offset offset1 = Offset.zero;
  Offset offset2 = const Offset(1, 0);
  GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PropertiesInfo>(
        converter: (store) => PropertiesInfo(
            store.state.propertyPanelVisible, store.state.brushPanelVisible),
        builder: (BuildContext context, PropertiesInfo prop) {
          return AnimatedSlide(
            offset: prop.brushPanelVisible || prop.propertyPanelVisible
                ? offset1
                : offset2,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: Container(
              width: panelWidth,
              height: double.infinity,
              color: const Color.fromARGB(255, 94, 94, 94),
              child: prop.propertyPanelVisible
                  ? const PropertiesPanel()
                  : prop.brushPanelVisible
                      ? const BrushPanel()
                      : null,
            ),
          );
        });
  }
}

class PropertiesInfo {
  bool propertyPanelVisible;
  bool brushPanelVisible;
  PropertiesInfo(this.propertyPanelVisible, this.brushPanelVisible);
}
