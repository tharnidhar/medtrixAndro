import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ink_controller.dart';

class AutosaveLifecycleObserver extends WidgetsBindingObserver {
  final Ref ref;

  AutosaveLifecycleObserver(this.ref);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      ref.read(inkProvider.notifier).savePage();
    }
  }
}
