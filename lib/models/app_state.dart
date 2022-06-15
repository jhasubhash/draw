import 'package:flutter/material.dart';

@immutable
class AppState {
  final Color color;
  final bool propertyPanelVisible;

  const AppState({required this.color, required this.propertyPanelVisible});

  @override
  String toString() {
    return 'AppState: {color: $color} {propertyPanelVisible: $propertyPanelVisible}';
  }
}
