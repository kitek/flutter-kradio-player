import 'package:flutter/material.dart';

/// Wraps [widget] with MaterialApp.
/// For some Widgets (InkWell) Material presence is required.
Widget wrapWithMaterial(Widget widget) {
  return MaterialApp(home: Material(child: widget));
}
