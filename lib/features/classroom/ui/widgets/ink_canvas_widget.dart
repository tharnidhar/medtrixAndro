import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfect_freehand/perfect_freehand.dart';
import '../../logic/ink_controller.dart';
import '../../logic/toolbar_controller.dart';
import '../../widgets/ink_input_router.dart';

class InkCanvasWidget extends ConsumerWidget {
  const InkCanvasWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ink = ref.read(inkProvider.notifier);
    final tool = ref.watch(toolbarProvider);

    return Listener(
      onPointerDown: (e) {
        if (tool == ToolMode.pen) {
          ink.startLine(
            Point(e.localPosition.dx, e.localPosition.dy),
          );
        }
      },
      onPointerMove: (e) {
        InkInputRouter.handleMove(
          ref: ref,
          x: e.localPosition.dx,
          y: e.localPosition.dy,
        );
      },
      child: CustomPaint(
        painter: _InkPainter(ref.watch(inkProvider).lines),
        size: Size.infinite,
      ),
    );
  }
}

// =========================
// DRAWING (UNCHANGED)
// =========================
class _InkPainter extends CustomPainter {
  final List<DrawnLine> lines;
  _InkPainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    for (final line in lines) {
      final stroke = getStroke(
        line.points,
        size: line.size,
        thinning: 0.7,
        smoothing: 0.5,
      );

      if (stroke.isEmpty) continue;

      final path = Path()..moveTo(stroke[0].x, stroke[0].y);
      for (int i = 1; i < stroke.length; i++) {
        path.lineTo(stroke[i].x, stroke[i].y);
      }
      path.close();

      canvas.drawPath(
        path,
        Paint()
          ..color = line.color
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(_) => true;
}
