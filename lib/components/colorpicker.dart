import 'package:draw/actions/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../models/app_state.dart';

class DrawColorPicker extends StatefulWidget {
  const DrawColorPicker({Key? key}) : super(key: key);

  @override
  State<DrawColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<DrawColorPicker> {
  static void changeColor(BuildContext context, Color color) {
    StoreProvider.of<AppState>(context).dispatch(SetColor(color));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Color>(
        converter: (store) => store.state.color,
        builder: (BuildContext context, Color color) {
          return Column(
            children: [
              Stack(alignment: AlignmentDirectional.bottomStart, children: [
                Container(
                  child: ColorPicker(
                    labelTypes: [],
                    hexInputBar: false,
                    colorPickerWidth: 250,
                    pickerAreaHeightPercent: 0.7,
                    portraitOnly: true,
                    pickerColor: color,
                    onColorChanged: (color) => {changeColor(context, color)},
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(right: 20),
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 75,
                    child: TextField(
                      controller: TextEditingController()
                        ..text = colorToHex(color, enableAlpha: false),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(6),
                        isDense: true,
                        isCollapsed: true,
                        border: OutlineInputBorder(gapPadding: 0),
                      ),
                      onSubmitted: (val) {
                        changeColor(
                            context, colorFromHex(val, enableAlpha: false)!);
                      },
                    ),
                  ),
                )
              ]),
            ],
          );
        });
  }
}
