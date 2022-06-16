import 'package:draw/actions/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../models/app_state.dart';

class RightBar extends StatefulWidget {
  RightBar({Key? key}) : super(key: key);

  @override
  State<RightBar> createState() => _RightBarState();
}

class _RightBarState extends State<RightBar> {
  bool panelVisible = false;

  void changePanelVisibility(BuildContext context, bool visible) {
    StoreProvider.of<AppState>(context)
        .dispatch(SetPropertiesPanelVisibility(visible));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: double.infinity,
      color: const Color.fromARGB(255, 53, 53, 53),
      child: Container(
        margin: const EdgeInsets.only(top: 40.0),
        alignment: Alignment.topCenter,
        child: IconButton(
          color: Colors.white38,
          icon: const Icon(Icons.tune),
          onPressed: () => {
            panelVisible = !panelVisible,
            changePanelVisibility(context, panelVisible)
          },
        ),
      ),
    );
  }
}
