import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:isar/isar.dart';
import 'package:myapp/data/local_db/video_asset.dart';

class MarrowLoader {
  static Future<void> seed(Isar isar) async {
    // 1. CLEAR OLD DATA (Necessary because schema changed)
    // We will wipe the DB once so we can reload it correctly.
    final currentCount = await isar.videoAssets.count();
    if (currentCount > 0) {
      await isar.writeTxn(() async {
        await isar.videoAssets.clear();
      });
      print("🧹 Cleared old database data.");
    }

    print("🌱 Seeding database from JSON...");

    try {
      final jsonString = await rootBundle.loadString('lib/assets/data/marrow_ordered.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);

      final List<VideoAsset> newAssets = jsonData.map((item) {
        return VideoAsset()
          ..title = item['title'] ?? 'Unknown Title'
          ..subjectName = item['subject'] ?? 'General'
          // 2. SAVE THE URL CORRECTLY HERE
          ..url = item['url'] ?? '' 
          ..storageUuid = 'online'
          ..isDownloaded = false
          ..isCompleted = false
          ..lastAccessed = DateTime.now();
      }).toList();

      await isar.writeTxn(() async {
        await isar.videoAssets.putAll(newAssets);
      });

      print("✅ Successfully re-seeded ${newAssets.length} videos with URLs.");
    } catch (e) {
      print("❌ Error seeding database: $e");
    }
  }
}