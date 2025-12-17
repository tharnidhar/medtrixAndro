import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/toolbar_controller.dart';

class FloatingToolbar extends ConsumerWidget {
  const FloatingToolbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tool = ref.watch(toolbarProvider);
    final notifier = ref.read(toolbarProvider.notifier);

    IconData icon;
    switch (tool) {
      case ToolMode.pen:
        icon = Icons.edit;
        break;
      case ToolMode.eraser:
        icon = Icons.auto_fix_high;
        break;
      case ToolMode.highlight:
        icon = Icons.highlight;
        break;
    }

    return FloatingActionButton(
      mini: true,
      onPressed: notifier.next,
      tooltip: tool.name,
      child: Icon(icon),
    );
  }
}
