import 'package:draw/actions/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../models/app_state.dart';

class RightBar extends StatefulWidget {
  RightBar({Key? key}) : super(key: key);

  @override
  State<RightBar> createState() => _RightBarState();
}

class _RightBarState extends State<RightBar> {
  bool propertiesPanelVisible = false;
  bool brushPanelVisible = false;

  resetVisibility() {
    setState(() {
      propertiesPanelVisible = false;
      brushPanelVisible = false;
    });
    StoreProvider.of<AppState>(context)
        .dispatch(SetPropertiesPanelVisibility(false));
    StoreProvider.of<AppState>(context)
        .dispatch(SetBrushPanelVisibility(false));
  }

  void changePropertiesPanelVisibility(BuildContext context, bool visible) {
    resetVisibility();
    setState(() {
      propertiesPanelVisible = visible;
    });
    StoreProvider.of<AppState>(context)
        .dispatch(SetPropertiesPanelVisibility(visible));
  }

  void changeBrushPanelVisibility(BuildContext context, bool visible) {
    resetVisibility();
    setState(() {
      brushPanelVisible = visible;
    });
    StoreProvider.of<AppState>(context)
        .dispatch(SetBrushPanelVisibility(visible));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: double.infinity,
      color: const Color.fromARGB(255, 53, 53, 53),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40.0),
            alignment: Alignment.topCenter,
            child: IconButton(
              color: propertiesPanelVisible ? Colors.white : Colors.white38,
              icon: const Icon(Icons.tune),
              onPressed: () => {
                changePropertiesPanelVisibility(
                    context, !propertiesPanelVisible)
              },
            ),
          ),
          IconButton(
            color: brushPanelVisible ? Colors.white : Colors.white38,
            icon: const Icon(Icons.draw),
            onPressed: () =>
                {changeBrushPanelVisibility(context, !brushPanelVisible)},
          ),
        ],
      ),
    );
  }
}
