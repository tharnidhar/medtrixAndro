import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

// 1. Import your DB Schema and global instance
import 'package:myapp/data/local_db/video_asset.dart';
import 'package:myapp/main.dart';

class TopicIndexScreen extends StatefulWidget {
  final String subjectId; // This is the Subject Name (e.g. "Anatomy")
  const TopicIndexScreen({super.key, required this.subjectId});

  @override
  State<TopicIndexScreen> createState() => _TopicIndexScreenState();
}

class _TopicIndexScreenState extends State<TopicIndexScreen> {
  late Future<List<VideoAsset>> _videosFuture;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  void _loadVideos() {
    // Query: Find all videos where 'subjectName' matches the selected subject
    _videosFuture = isar.videoAssets
        .filter()
        .subjectNameEqualTo(widget.subjectId)
        .findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectId),
      ),
      body: FutureBuilder<List<VideoAsset>>(
        future: _videosFuture,
        builder: (context, snapshot) {
          // 1. Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Error State
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final videos = snapshot.data ?? [];

          // 3. Empty State
          if (videos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.video_library_outlined, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text("No videos found for ${widget.subjectId}"),
                ],
              ),
            );
          }

          // 4. Real Data List
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return _buildVideoRow(context, video);
            },
          );
        },
      ),
    );
  }

  Widget _buildVideoRow(BuildContext context, VideoAsset video) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: CircleAvatar(
          backgroundColor: Colors.teal.withOpacity(0.1),
          child: const Icon(Icons.play_arrow_rounded, color: Colors.teal),
        ),
        title: Text(
          video.title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        // Since 'duration' isn't in your DB schema yet, we hide it or show a placeholder
        // subtitle: const Text("15 min"), 
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (video.isCompleted)
              const Icon(Icons.check_circle, size: 18, color: Colors.green)
            else
              IconButton(
                icon: Icon(
                  video.isDownloaded ? Icons.download_done : Icons.download_outlined,
                  color: video.isDownloaded ? Colors.teal : Colors.grey,
                ),
                onPressed: () {
                  // TODO: Implement Download Logic later
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Download feature coming soon!")),
                  );
                },
              ),
          ],
        ),
        onTap: () {
          // Pass the REAL database ID to the classroom
          context.push('/classroom/${video.id}');
        },
      ),
    );
  }
}