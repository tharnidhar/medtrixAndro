import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:isar/isar.dart';

// 1. Import your Database Schema and the global 'isar' instance
import 'package:myapp/data/local_db/video_asset.dart';
import 'package:myapp/main.dart'; 

class SubjectHubScreen extends StatefulWidget {
  final String brandId;
  const SubjectHubScreen({super.key, required this.brandId});

  @override
  State<SubjectHubScreen> createState() => _SubjectHubScreenState();
}

class _SubjectHubScreenState extends State<SubjectHubScreen> {
  late Future<List<String>> _subjectsFuture;

  @override
  void initState() {
    super.initState();
    _subjectsFuture = _fetchSubjects();
  }

  // Fetch unique subjects from the database
  Future<List<String>> _fetchSubjects() async {
    // Get all videos
    final allVideos = await isar.videoAssets.where().findAll();
    
    // Extract unique subject names
    final uniqueSubjects = allVideos
        .map((v) => v.subjectName)
        .where((name) => name.isNotEmpty) // Safety check
        .toSet()
        .toList();
    
    // Sort A-Z
    uniqueSubjects.sort();
    
    return uniqueSubjects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.brandId} Subjects"),
      ),
      body: FutureBuilder<List<String>>(
        future: _subjectsFuture,
        builder: (context, snapshot) {
          // 1. Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Error State
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error loading subjects:\n${snapshot.error}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final subjects = snapshot.data ?? [];

          // 3. Empty State
          if (subjects.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_off_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("No subjects found in database."),
                ],
              ),
            );
          }

          // 4. Data List
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];
              final firstLetter = subject.isNotEmpty ? subject[0].toUpperCase() : "?";

              return Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    child: Text(firstLetter),
                  ),
                  title: Text(
                    subject,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text("Tap to view topics"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to TopicIndexScreen with the real subject name
                    context.push('/topics/$subject');
                  },
                ),
              ).animate().fadeIn(delay: (50 * index).ms).slideX();
            },
          );
        },
      ),
    );
  }
}