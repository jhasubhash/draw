import 'package:flutter/material.dart';

class ToolsPanel extends StatefulWidget {
  ToolsPanel({Key? key}) : super(key: key);

  @override
  State<ToolsPanel> createState() => _ToolsPanelState();
}

class _ToolsPanelState extends State<ToolsPanel> {
  static const double radius = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: double.infinity,
      margin: const EdgeInsets.only(top: 40.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(radius),
            bottomRight: Radius.circular(radius)),
        color: Color.fromARGB(255, 53, 53, 53),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            IconButton(
              color: Colors.white38,
              icon: const Icon(Icons.create),
              onPressed: () => {},
            ),
            IconButton(
              color: Colors.white38,
              icon: const Icon(Icons.brush),
              onPressed: () => {},
            ),
            IconButton(
              color: Colors.white38,
              icon: const Icon(Icons.back_hand),
              onPressed: () => {},
            ),
            IconButton(
              color: Colors.white38,
              icon: const Icon(Icons.colorize),
              onPressed: () => {},
            ),
            IconButton(
              color: Colors.white38,
              icon: const Icon(Icons.zoom_in),
              onPressed: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
