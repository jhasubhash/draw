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
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
        converter: (store) => store.state.propertyPanelVisible,
        builder: (BuildContext context, bool propertyPanelVisible) {
          return Visibility(
            visible: propertyPanelVisible,
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
