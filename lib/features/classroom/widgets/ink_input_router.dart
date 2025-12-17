import 'package:perfect_freehand/perfect_freehand.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/toolbar_controller.dart';
import '../logic/eraser_controller.dart';
import '../logic/ink_controller.dart';

class InkInputRouter {
  static void handleMove({
    required WidgetRef ref, // ✅ FIX: WidgetRef, not Ref<Object?>
    required double x,
    required double y,
  }) {
    final p = Point(x, y);

    final tool = ref.read(toolbarProvider);
    final ink = ref.read(inkProvider.notifier);

    if (tool == ToolMode.eraser) {
      EraserController.eraseAt(ink, p);
    } else {
      ink.updateLine(p);
    }
  }
}
