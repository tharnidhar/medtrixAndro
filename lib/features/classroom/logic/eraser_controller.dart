import 'package:perfect_freehand/perfect_freehand.dart';
import 'ink_controller.dart';

class EraserController {
  static void eraseAt(
    InkNotifier notifier,
    Point position, {
    double radius = 18,
  }) {
    final state = notifier.state;

    final remaining = state.lines.where((line) {
      return !line.points.any(
        (p) => (p.x - position.x).abs() < radius &&
               (p.y - position.y).abs() < radius,
      );
    }).toList();

    notifier.state = InkState(state.page, remaining);
  }
}
