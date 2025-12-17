import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/smartlink_controller.dart';

class SmartLinkButton extends ConsumerWidget {
  final int currentTimeSeconds;
  final int currentPdfPage;

  const SmartLinkButton({
    super.key,
    required this.currentTimeSeconds,
    required this.currentPdfPage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      icon: const Icon(Icons.link),
      label: const Text("Link Page"),
      onPressed: () {
        ref
            .read(smartLinkProvider.notifier)
            .addLink(currentTimeSeconds, currentPdfPage);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Linked ${_format(currentTimeSeconds)} → Page $currentPdfPage",
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }

  String _format(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }
}
