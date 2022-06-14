import 'package:flutter/material.dart';

@immutable
class AppState {
  final Color color;

  const AppState({
    required this.color,
  });

  @override
  String toString() {
    return 'AppState: {color: $color}';
  }
}
