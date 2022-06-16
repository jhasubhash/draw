import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../actions/actions.dart';
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
  double strokeWidth = 1;

  void onStrokeWidthChange(val) {
    setState(() {
      strokeWidth = val;
      StoreProvider.of<AppState>(context).dispatch(SetStrokeWidth(strokeWidth));
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PropertiesInfo>(
        converter: (store) => PropertiesInfo(
            store.state.propertyPanelVisible, store.state.strokeWidth),
        builder: (BuildContext context, PropertiesInfo prop) {
          return AnimatedSlide(
            offset: prop.visible ? offset1 : offset2,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: Container(
              width: panelWidth,
              height: double.infinity,
              color: Color.fromARGB(255, 94, 94, 94),
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    const DrawColorPicker(),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      child: const Text(
                        "Stroke Width",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Slider(
                            value: prop.strokeWidth,
                            onChanged: onStrokeWidthChange,
                            //label: prop.strokeWidth.toStringAsFixed(1),
                            divisions: 80,
                            min: 0.001,
                            max: 40,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: TextField(
                            controller: TextEditingController()
                              ..text = prop.strokeWidth.toStringAsFixed(1),
                            onSubmitted: (val) {
                              onStrokeWidthChange(double.parse(val));
                            },
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9.]")),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {}
                                return oldValue;
                              }),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class PropertiesInfo {
  bool visible;
  double strokeWidth;
  PropertiesInfo(this.visible, this.strokeWidth);
}
