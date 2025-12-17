import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/data/local_db/video_asset.dart';
import 'package:myapp/features/marrow/logic/marrow_provider.dart';

class MarrowScreen extends ConsumerWidget {
  const MarrowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lecturesAsync = ref.watch(marrowLecturesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Marrow Lectures")),
      body: lecturesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
        data: (lectures) {
          if (lectures.isEmpty) {
            return const Center(child: Text("No lectures found."));
          }
          return ListView.builder(
            itemCount: lectures.length,
            itemBuilder: (context, index) {
              final video = lectures[index];
              return ListTile(
                leading: const Icon(Icons.play_circle_fill, color: Colors.teal),
                title: Text(video.title),
                subtitle: Text(video.subjectName),
                trailing: video.isCompleted 
                    ? const Icon(Icons.check, color: Colors.green) 
                    : null,
                onTap: () => context.push('/classroom/${video.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
