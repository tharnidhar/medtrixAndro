import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import '../../data/schemas/video_asset.dart';

class MarrowSeeder {
  static Future<void> seedIfNeeded(Isar isar) async {
    final count = await isar.videoAssets.count();
    if (count > 0) return;

    final jsonStr = await rootBundle
        .loadString('lib/assets/data/marrow_ordered.json');

    final List data = json.decode(jsonStr);

    final lectures = data.map((e) {
      return VideoAsset()
        ..title = e['title'] ?? 'Untitled'
        ..localFileName = ''
        ..lastAccessed = DateTime.now()
        ..isDownloaded = false
        ..durationSeconds = e['duration'] ?? 0;
    }).toList();

    await isar.writeTxn(() async {
      await isar.videoAssets.putAll(lectures);
    });
  }
}
