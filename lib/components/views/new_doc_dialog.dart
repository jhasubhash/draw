// ignore_for_file: unnecessary_const

import 'package:draw/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../actions/actions.dart';
import '../../models/app_state.dart';
import '../commands/new_document.dart';

class NewDocumentDialog extends StatefulWidget {
  NewDocumentDialog({Key? key}) : super(key: key);

  @override
  State<NewDocumentDialog> createState() => _NewDocumentDialogState();
}

class _NewDocumentDialogState extends State<NewDocumentDialog> {
  double artboardHeight = 600;
  double artboardWidth = 800;

  void onOk(context) {
    print("width ${artboardWidth} height ${artboardHeight}");
    StoreProvider.of<AppState>(context)
        .dispatch(NewDocument(artboardHeight, artboardWidth));
  }

  void onCancel(context) {
    // Do nothing
  }

  void onHeightChange(val) {
    setState(() {
      artboardHeight = val;
    });
  }

  void onWidthChange(val) {
    setState(() {
      artboardWidth = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Document'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Width",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        initialValue: artboardWidth.toStringAsFixed(0),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                          isDense: true,
                          isCollapsed: true,
                          border: OutlineInputBorder(gapPadding: 0),
                        ),
                        onChanged: (val) {
                          onWidthChange(double.parse(val));
                        },
                        inputFormatters: DigitInputFormatter,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 5),
                      child: const Text(
                        "Pixels",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Height",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        initialValue: artboardHeight.toStringAsFixed(0),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                          isDense: true,
                          isCollapsed: true,
                          border: OutlineInputBorder(gapPadding: 0),
                        ),
                        onChanged: (val) {
                          onHeightChange(double.parse(val));
                        },
                        inputFormatters: DigitInputFormatter,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 5),
                      child: const Text(
                        "Pixels",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
            onOk(context);
          },
        ),
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    ;
  }
}
