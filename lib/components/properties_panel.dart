import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../models/app_state.dart';
import 'colorpicker.dart';

class PropertiesPanel extends StatefulWidget {
  PropertiesPanel({Key? key}) : super(key: key);

  @override
  State<PropertiesPanel> createState() => _PropertiesPanelState();
}

class _PropertiesPanelState extends State<PropertiesPanel> {
  double panelWidth = 250;
  bool isPanelVisible = true;
  Offset offset1 = Offset.zero;
  Offset offset2 = const Offset(1, 0);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
        converter: (store) => store.state.propertyPanelVisible,
        builder: (BuildContext context, bool propertyPanelVisible) {
          return AnimatedSlide(
            offset: propertyPanelVisible ? offset1 : offset2,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: Container(
              width: panelWidth,
              height: double.infinity,
              color: Color.fromARGB(255, 94, 94, 94),
              child: Container(
                alignment: Alignment.topCenter,
                child: const DrawColorPicker(),
              ),
            ),
          );
        });
  }
}
