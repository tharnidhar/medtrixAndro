import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ToolMode { pen, eraser, highlight }

class ToolbarController extends Notifier<ToolMode> {
  @override
  ToolMode build() => ToolMode.pen;

  void next() {
    state = ToolMode.values[
        (ToolMode.values.indexOf(state) + 1) % ToolMode.values.length
    ];
  }
}

final toolbarProvider =
    NotifierProvider<ToolbarController, ToolMode>(ToolbarController.new);
