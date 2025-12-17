import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:myapp/data/local_db/video_asset.dart';
import 'package:myapp/main.dart';

// Provides the list of videos to the UI
final marrowLecturesProvider = FutureProvider.autoDispose<List<VideoAsset>>((ref) async {
  // Ensure Isar is open before querying
  if (!isar.isOpen) return [];
  return await isar.videoAssets.where().findAll();
});
