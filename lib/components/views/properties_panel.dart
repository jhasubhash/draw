import 'package:draw/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../actions/actions.dart';
import '../../models/app_state.dart';
import '../colorpicker.dart';
import 'layer_panel.dart';
import 'dart:math';

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
  double maxStrokeWidthVal = 40;
  double minStrokeWidthVal = 0.001;
  late TextEditingController _strokeController = TextEditingController();

  FocusNode _strokefocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _strokefocus.addListener(_onFocusChange);
    _strokeController.text = strokeWidth.toStringAsFixed(1);
  }

  @override
  void dispose() {
    super.dispose();
    _strokefocus.removeListener(_onFocusChange);
    _strokefocus.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_strokefocus.hasFocus.toString()}");
  }

  void onStrokeWidthChange(val) {
    if (!_strokefocus.hasFocus) {
      _strokeController.text = val.toStringAsFixed(1);
    }
    setState(() {
      val = min<double>(val, maxStrokeWidthVal);
      val = max<double>(minStrokeWidthVal, val);
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const DrawColorPicker(),
                        Column(
                          children: [
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
                                  width: 180,
                                  child: Slider(
                                    value: prop.strokeWidth,
                                    onChanged: onStrokeWidthChange,
                                    //label: prop.strokeWidth.toStringAsFixed(1),
                                    divisions: 80,
                                    min: minStrokeWidthVal,
                                    max: maxStrokeWidthVal,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: TextField(
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    controller: _strokeController,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(6),
                                      isDense: true,
                                      isCollapsed: true,
                                      border: OutlineInputBorder(gapPadding: 0),
                                    ),
                                    onChanged: (val) {
                                      if (val.isNotEmpty) {
                                        onStrokeWidthChange(double.parse(val));
                                      }
                                    },
                                    focusNode: _strokefocus,
                                    inputFormatters: DigitInputFormatter,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ), // Stroke Width
                    LayerPanel(),
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
