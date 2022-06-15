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
    print('Initial color: ${color}');
    StoreProvider.of<AppState>(context).dispatch(SetColor(color));
  }

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
        context: context,
        builder: (BuildContext context) => StoreConnector<AppState, Color>(
            converter: (store) => store.state.color,
            builder: (BuildContext context, Color color) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    colorPickerWidth: 300,
                    pickerAreaHeightPercent: 0.7,
                    portraitOnly: true,
                    pickerColor: color,
                    onColorChanged: (color) => {changeColor(context, color)},
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('Got it'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    var state = StoreProvider.of<AppState>(context);
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context).restorablePush(_dialogBuilder);
      },
      child: const Text('Open Dialog'),
    );
  }
}
