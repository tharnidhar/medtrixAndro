import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../data/schemas/video_asset.dart';
import '../../../core/db/isar_provider.dart';

final marrowLecturesProvider = StreamProvider<List<VideoAsset>>((ref) {
  final isar = ref.watch(isarProvider);
  return isar.videoAssets.where().watch(fireImmediately: true);
});
