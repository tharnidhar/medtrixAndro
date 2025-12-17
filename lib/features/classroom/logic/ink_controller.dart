import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfect_freehand/perfect_freehand.dart';

class DrawnLine {
  final List<Point> points;
  final Color color;
  final double size;

  DrawnLine({
    required this.points,
    required this.color,
    required this.size,
  });
}

class InkState {
  final int page;
  final List<DrawnLine> lines;

  InkState(this.page, this.lines);
}

class InkNotifier extends Notifier<InkState> {
  @override
  InkState build() => InkState(0, []);

  // 🔒 SAFE NO-OP (required for lifecycle autosave hook)
  Future<void> savePage() async {
    // Intentionally empty.
    // Persistence can be wired later without breaking API.
  }

  void startLine(Point p) {
    state = InkState(
      state.page,
      [
        ...state.lines,
        DrawnLine(
          points: [p],
          color: Colors.black,
          size: 4.0,
        ),
      ],
    );
  }

  void updateLine(Point p) {
    if (state.lines.isEmpty) return;

    final last = state.lines.last;
    state = InkState(
      state.page,
      [
        ...state.lines.sublist(0, state.lines.length - 1),
        DrawnLine(
          points: [...last.points, p],
          color: last.color,
          size: last.size,
        ),
      ],
    );
  }
}

final inkProvider =
    NotifierProvider<InkNotifier, InkState>(InkNotifier.new);
