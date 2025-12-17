import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import '../schemas/video_asset.dart';

Future<void> seedMarrow(Isar isar) async {
  final raw = await rootBundle.loadString('lib/assets/data/marrow_ordered.json');
  final List<dynamic> jsonList = json.decode(raw);

  await isar.writeTxn(() async {
    for (final v in jsonList) {
      final video = VideoAsset()
        ..title = v['title'] ?? ''
        ..subject = v['subject']
        ..topic = v['topic']
        ..remoteUrl = v['url']
        ..isDownloaded = false
        ..lastAccessed = DateTime.now();

      await isar.videoAssets.put(video);
    }
  });
}
