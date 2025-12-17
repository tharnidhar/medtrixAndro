import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfect_freehand/perfect_freehand.dart';
import '../logic/ink_controller.dart';

class InkCanvas extends ConsumerWidget {
  const InkCanvas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inkState = ref.watch(inkProvider);
    final notifier = ref.read(inkProvider.notifier);

    return Listener(
      onPointerDown: (e) {
        notifier.startLine(
          Point(e.localPosition.dx, e.localPosition.dy),
        );
      },
      onPointerMove: (e) {
        notifier.updateLine(
          Point(e.localPosition.dx, e.localPosition.dy),
        );
      },
      child: CustomPaint(
        painter: _InkPainter(inkState.lines),
        size: Size.infinite,
      ),
    );
  }
}

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
